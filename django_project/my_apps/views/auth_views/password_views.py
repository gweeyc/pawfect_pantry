from django.contrib.auth.models import User
from django.contrib.auth.tokens import default_token_generator
from django.contrib.auth.password_validation import validate_password
from django.core.exceptions import ValidationError
from django.utils.http import urlsafe_base64_decode
from django.utils.encoding import force_str

from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response

from my_apps.views.auth_views import auth_email_views


# 1️⃣ Request password reset link
@api_view(['POST'])
@permission_classes([AllowAny])
def api_password_reset_request(request):
    email = request.data.get('email')
    users = User.objects.filter(email=email)
    if users.exists():
        for user in users:
            token = default_token_generator.make_token(user)
            auth_email_views.send_password_reset_email(user, token)  # Customize this
    return Response({"message": "If your email exists, a reset link has been sent."})


# 2️⃣ Confirm password reset
@api_view(['POST'])
@permission_classes([AllowAny])
def api_password_reset_confirm(request, uidb64, token):
    try:
        uid = force_str(urlsafe_base64_decode(uidb64))
        user = User.objects.get(pk=uid)
    except (User.DoesNotExist, ValueError, TypeError, OverflowError):
        return Response({"error": "Invalid user."}, status=400)

    if not default_token_generator.check_token(user, token):
        return Response({"error": "Invalid or expired token."}, status=400)

    new_password = request.data.get('new_password')
    try:
        validate_password(new_password, user)
        user.set_password(new_password)
        user.save()
        return Response({"message": "Password has been reset successfully."})
    except ValidationError as e:
        return Response({"error": e.messages}, status=400)


# 3️⃣ Logged-in user changes password
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def api_change_password(request):
    user = request.user
    old_password = request.data.get("old_password")
    new_password = request.data.get("new_password")

    if not user.check_password(old_password):
        return Response({"error": "Old password is incorrect."}, status=400)

    try:
        validate_password(new_password, user)
        user.set_password(new_password)
        user.save()
        return Response({"message": "Password successfully changed."})
    except ValidationError as e:
        return Response({"error": e.messages}, status=400)
