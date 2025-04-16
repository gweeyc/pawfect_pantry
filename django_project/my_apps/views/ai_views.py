from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from my_apps.models import Product, Feedback
from my_apps.utils.ai_utils import get_similar_products
import openai, json, os


openai.api_key = os.getenv("OPENAI_API_KEY")  # Alternatively, set your key directly

@login_required
def ai_recommendations(request):
    recommended_products = Product.objects.order_by('-views')[:3]
    data = [
        {
            "id": p.id,
            "name": p.name,
            "price": p.price,
            "views": p.views,
            "image": p.image.url if p.image else None,
        }
        for p in recommended_products
    ]
    return JsonResponse({"recommended": data})

@login_required
def product_recommendations(request, product_id):
    similar_products = get_similar_products(product_id)
    data = [
        {
            "id": p.id,
            "name": p.name,
            "price": p.price,
            "views": p.views,
            "image": p.image.url if p.image else None,
        }
        for p in similar_products
    ]
    return JsonResponse({"similar": data})

@csrf_exempt
def chatbot_view(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            user_message = data.get("message")

            if not user_message:
                return JsonResponse({"error": "Message cannot be empty."}, status=400)

            response = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=[
                    {"role": "system", "content": "You are a helpful chatbot."},
                    {"role": "user", "content": user_message},
                ]
            )

            bot_reply = response['choices'][0]['message']['content']
            return JsonResponse({"reply": bot_reply})

        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)

    return JsonResponse({"error": "POST method required"}, status=405)

@csrf_exempt
def submit_feedback(request, product_id):
    if request.method == "POST":
        data = json.loads(request.body)
        comment = data.get("comment")
        product = Product.objects.get(id=product_id)
        Feedback.objects.create(product=product, user=request.user, comment=comment)
        return JsonResponse({'message': 'Feedback submitted'})
 