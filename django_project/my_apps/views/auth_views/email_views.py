from django.core.mail import send_mail
from django.conf import settings

def send_password_reset_email(user, token):
    subject = "Password Reset Requested"
    uid = user.pk
    reset_link = f"http://127.0.0.1:8000/reset/{uid}/{token}/"

    message = f"Hi {user.get_full_name() or user.username},\n\nClick the link below to reset your password:\n{reset_link}\n\nIf you didn’t request this, just ignore this email."

    send_mail(
        subject,
        message,
        settings.DEFAULT_FROM_EMAIL,
        [user.email],
        fail_silently=False,
    )
