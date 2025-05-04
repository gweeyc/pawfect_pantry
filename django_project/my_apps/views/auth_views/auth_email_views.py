from django.template.loader import render_to_string
from django.core.mail import EmailMultiAlternatives

#------------------------------------------------------------------------------------------------------
#Send Password Reset Email
#------------------------------------------------------------------------------------------------------

def send_password_reset_email(user, token):
    subject = "Your Password Reset Request"
    
    uid = user.pk
    reset_link = f"http://127.0.0.1:8000/reset/{uid}/{token}/"

    # 1. Render HTML message
    html_message = render_to_string('emails/password_reset_email.html', {
        'user': user,
        'reset_link': reset_link,
    })

    # 2. Text fallback
    text_message = f"""
Hi {user.get_full_name() or user.username},

We received a request to reset your password. ✅

To proceed, click the link below:
{reset_link}

If you didn’t request a password reset, you can safely ignore this email — your account will remain secure. 🔒

🛒 Also, just a friendly reminder: you still have items waiting in your cart!

Best regards,  
Your Store Team
    """

    # 3. Send email
    email = EmailMultiAlternatives(subject, text_message, 'your_email@example.com', [user.email])
    email.attach_alternative(html_message, "text/html")
    email.send()

#------------------------------------------------------------------------------------------------------
#Registration Email Confirmation
#------------------------------------------------------------------------------------------------------

def send_registration_confirmation_email(user):
    subject = "Welcome to Our Store!"
    
    homepage_link = "http://127.0.0.1:8000/"
    image_url = "http://127.0.0.1:8000/media/banner_images/welcome_email.png"

    html_message = render_to_string('emails/registration_confirmation_email.html', {
        'user': user,
        'homepage_link': homepage_link,
        'image_url': image_url,  # 🔥 pass full URL
    })

    text_message = f"""
Hi {user.get_full_name() or user.username},

Thank you for registering an account with us! 🚀

You can start browsing our latest products and exclusive deals here:
{homepage_link}

We're excited to have you onboard!

Best regards,  
Your Store Team
    """

    email = EmailMultiAlternatives(subject, text_message, 'your_email@example.com', [user.email])
    email.attach_alternative(html_message, "text/html")
    email.send()