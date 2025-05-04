from django.contrib.auth.decorators import login_required
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from django.conf import settings
from ...models import Order, Product
import openai, json

openai.api_key = settings.OPENAI_API_KEY

def custom_login_required(view_func):
    def wrapper(request, *args, **kwargs):
        if not request.user.is_authenticated:
            return JsonResponse({"error": "Authentication required."}, status=401)
        return view_func(request, *args, **kwargs)
    return wrapper

@csrf_exempt
@custom_login_required
def chatbot_view(request):
    if not request.user.is_authenticated:
        return JsonResponse({
            "reply": "🔒 Please log in to use the chatbot. You can log in from the top-right menu."
        })

    # Ensure POST method
    if request.method != "POST":
        return JsonResponse({
            "error": "❌ POST method required."
        }, status=405)

    # Get message from POST
    msg = request.POST.get('msg', '').lower()

    try:
        data = json.loads(request.body)
        user_message = data.get("message", "").strip()

        if not user_message:
            return JsonResponse({"error": "Message cannot be empty."}, status=400)

        msg = user_message.lower()

        # Keyword: Order Status
        if "order" in msg and any(keyword in msg for keyword in ["what", "current", "status", "where", "track", "check"]):
            latest_order = Order.objects.filter(user=request.user).order_by('-date').first()
            if latest_order:
                reply = (
                    f"🧾 Your latest order (#{latest_order.id}) is currently <strong>'{latest_order.status}'</strong>. "
                    f"The total was <strong>${latest_order.total:.2f}</strong>. "
                    "Estimated delivery: 3–5 business days.<br><br>"
                    "📦 You can view your full order history here: "
                    "<a href='http://localhost:3000/orders/history' target='_blank'>Order History</a>"
                )
            else:
                reply = (
                    "🕵️ You currently have no orders yet.<br>"
                    "You can view your order history once you place an order: "
                    "<a href='http://localhost:3000/orders/history' target='_blank'>Order History</a>"
                )

            return JsonResponse({"reply": reply})

        # Keyword: Payment Confirmation
        elif "payment" in msg and any(keyword in msg for keyword in ["status", "where", "track", "check", "did", "pay"]):
            latest_order = Order.objects.filter(user=request.user).order_by('-date').first()
            if latest_order:
                reply = (
                    f"Your latest payment of ${latest_order.total:.2f} for order #{latest_order.id} was received. "
                    "Thank you for your purchase!"
                )
            else:
                reply = "No recent payment found. You haven’t placed any orders yet."
            return JsonResponse({"reply": reply})
        
        # Keyword: All Products
        elif any(keyword in msg for keyword in ["products", "items", "sell", "buy", "stuff"]):
            all_products = Product.objects.all()[:3]
            if all_products:
                product_lines = [
                    f'<a href="http://localhost:3000/catalogue/{p.id}/">{p.name} - ${p.price}</a>'
                    for p in all_products
                ]
                reply = "🛒 Here are some of our top products:<br>" + "<br>".join(product_lines)
            else:
                reply = "Sorry, I couldn’t find any products right now."
            return JsonResponse({"reply": reply})

        # Keyword: Cat-related inquiries
        elif any(keyword in msg for keyword in ["cat", "cats", "kitten", "meow"]):
            cat_products = Product.objects.filter(species__icontains="cat")[:3]
            if cat_products:
                product_lines = [
                    f'<a href="http://localhost:3000/catalogue/{p.id}/">{p.name} - ${p.price}</a>'
                    for p in cat_products
                ]
                reply = "🐱 Here are some cat-friendly picks:\n" + "\n".join(product_lines)
            else:
                reply = "Sorry, I couldn’t find any products for cats at the moment."
            return JsonResponse({"reply": reply})

        # Keyword: Dog-related inquiries
        elif any(keyword in msg for keyword in ["dog", "dogs", "puppy", "bark"]):
            dog_products = Product.objects.filter(species__icontains="dog")[:3]
            if dog_products:
                product_lines = [
                    f'<a href="http://localhost:3000/catalogue/{p.id}/">{p.name} - ${p.price}</a>'
                    for p in dog_products
                ]
                reply = "🐶 Here are some dog-approved picks:\n" + "\n".join(product_lines)
            else:
                reply = "Sorry, I couldn’t find any products for dogs at the moment."
            return JsonResponse({"reply": reply})
        
        # Keyword: Jerky-related inquiries
        elif any(keyword in msg.lower() for keyword in ["jerky", "dried meat", "dried jerky", "dried", "muscle meat"]):
            dried_products = Product.objects.filter(
                food_type__icontains="dried"
            ).order_by('-views')[:3]

            if dried_products:
                product_lines = [
                    f'<a href="http://localhost:3000/catalogue/{p.id}/">{p.name} - ${p.price}</a>'
                    for p in dried_products
                ]
                reply = "🥓 Here are some of our dried meat and jerky-style products:\n" + "\n".join(product_lines)
            else:
                reply = "Sorry, I couldn’t find any dried or jerky-style products at the moment."

            return JsonResponse({"reply": reply})

        # Greeting
        if any(word in msg for word in ["assist", "assistance", "how are you", "need", "help", "hello"]):
            return JsonResponse({"reply": "Hi there! 👋 How can I assist you today?"})
        
        # Profanity and Vulgarity-filter
        if any(word in msg for word in ["fuck", "shit", "cunt", "pussy", "wtf", "bitch", "asshole", "dick"]):
            return JsonResponse({
            "reply": "⚠️ That’s not a polite message. Please try asking respectfully."
            })

        # GPT fallback
        latest_order = Order.objects.filter(user=request.user).order_by('-date').first()
        context_info = (
            f"Order #{latest_order.id}, status: {latest_order.status}, total: ${latest_order.total:.2f}"
            if latest_order else "User has no current orders."
        )

        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system", "content": f"You are a helpful chatbot. {context_info}"},
                {"role": "user", "content": user_message},
            ]
        )

        bot_reply = response['choices'][0]['message']['content']
        return JsonResponse({"reply": bot_reply})

    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)
