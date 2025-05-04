# my_apps/context_processors.py
from .models import UserProfile

def user_role(request):
    role = None
    if request.user.is_authenticated:
        try:
            role = request.user.userprofile.role
        except:
            pass
    return {'role': role}