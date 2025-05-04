from django.core.mail import send_mail
from django.conf import settings
from django.template.loader import render_to_string
from django.core.mail import EmailMultiAlternatives
from django.shortcuts import render
from my_apps.models import Order

def checkout_complete(request, order_id):
    # Example: fetch the user and order
    order = Order.objects.get(id=order_id)
    user = request.user
    order_items = order.orderitem_set.all()

    # 1. Render the email HTML
    html_message = render_to_string('emails/order_confirmation.html', {
        'user': user,
        'order': order,
        'order_items': order_items,
    })

    # 2. Set up email details
    subject = f"Order Confirmation - #{order.id}"
    from_email = 'your_email@example.com'
    to_email = [user.email]
    text_content = f"Thank you for your order #{order.id}!"

    # 3. Send the email
    email = EmailMultiAlternatives(subject, text_content, from_email, to_email)
    email.attach_alternative(html_message, "text/html")
    email.send()

    # 4. Redirect to a "thank you" page or order summary
    return render(request, 'order/thank_you.html', {'order': order})