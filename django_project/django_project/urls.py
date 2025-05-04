from django.contrib import admin
from django.urls import path, include
from django.http import JsonResponse

def root_view(request):
    return JsonResponse({'message': 'API is running 🚀'})

urlpatterns = [
    path('', root_view),  # Base URL check
    path('admin/', admin.site.urls),
    path('dashboard/', include('my_apps.urls')),  # your custom views
    # ✅ Include structured app-specific routes
    path('', include('my_apps.urls')),  # customer/admin-facing views
    # Optional: Allauth (for login, registration templates)
    path('accounts/', include('allauth.urls')),

]

