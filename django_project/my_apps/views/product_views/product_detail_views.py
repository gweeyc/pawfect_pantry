from django.http import JsonResponse
from django.shortcuts import get_object_or_404
from django.contrib.auth.decorators import login_required
from django.views.decorators.csrf import csrf_exempt
from django.core.paginator import Paginator
from my_apps.models import Product
from my_apps.utils.feedback_analysis_utils import analyze_sentiment
from my_apps.forms import FeedbackForm
import json
from django.views.decorators.http import require_http_methods
from django.utils.decorators import method_decorator

@csrf_exempt
@require_http_methods(["GET"])
def product_detail(request, product_id):
    product = get_object_or_404(Product, id=product_id)
    
    # ✅ Increment view count
    product.views = int(product.views) + 1
    product.save()

    # ✅ Collect feedback with sentiment
    feedback_list = product.feedbacks.select_related('user').all()
    feedback_data = [
        {
            "user": fb.user.username,
            "comment": fb.comment,
            "sentiment": analyze_sentiment(fb.comment),
            "created_at": fb.created_at.strftime('%Y-%m-%d')
        }
        for fb in feedback_list
    ]

    return JsonResponse({
        "id": product.id,
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "stock": product.stock,
        "tags": str(product.tags),
        "species": product.species if product.species else None,
        "food_type": product.food_type if product.food_type else None,
        "image": request.build_absolute_uri(str(product.image.url)) if product.image else None,
        "views": product.views,
        "feedback": feedback_data
    })

@csrf_exempt
@login_required
def submit_feedback(request, product_id):
    product = get_object_or_404(Product, id=product_id)

    if request.method == "POST":
        try:
            data = json.loads(request.body)
        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON'}, status=400)

        form = FeedbackForm(data)

        if form.is_valid():
            feedback = form.save(commit=False)
            feedback.product = product
            feedback.user = request.user
            feedback.save()
            return JsonResponse({'message': 'Feedback submitted'})
        return JsonResponse({'errors': form.errors}, status=400)

    return JsonResponse({'error': 'POST method required'}, status=405)


# ✅ Checkout logic with stock update
@csrf_exempt
@login_required
def product_checkout(request, product_id):
    product = get_object_or_404(Product, id=product_id)

    if request.method == "POST":
        data = json.loads(request.body)
        quantity = int(data.get('quantity', 0))
        address = data.get('address', '')

        if quantity > product.stock:
            return JsonResponse({'error': 'Not enough stock available'}, status=400)

        product.stock -= quantity
        product.save()

        return JsonResponse({
            "message": f"Order placed for {quantity}x {product.name}",
            "shipping_address": address
        })

    return JsonResponse({'error': 'POST method required'}, status=405)

def get_product_feedback(request, product_id):
    product = get_object_or_404(Product, id=product_id)
    feedbacks = product.feedback_set.select_related('user').order_by('-created')
    feedback_data = [
        {
            "user": fb.user.username,
            "comment": fb.comment,
            "sentiment": analyze_sentiment(fb.comment),
            "created_at": fb.created_at.strftime('%Y-%m-%d')
        }
        for fb in feedbacks
    ]
    return JsonResponse(feedback_data, safe=False)
