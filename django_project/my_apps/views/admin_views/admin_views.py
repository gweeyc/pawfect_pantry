from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.shortcuts import render, redirect
from django.contrib import messages

from my_apps.models import Order, OrderItem, UserProfile  # make sure these models exist and are imported


# Helper: Check if user is staff or superuser
def is_admin(user):
    return user.is_staff or user.is_superuser

# ADMIN LOGIN VIEW
def admin_login(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')

        user = authenticate(request, username=username, password=password)

        if user is not None:
            try:
                profile = UserProfile.objects.get(user=user)
                if profile.role == 'admin':
                    login(request, user)
                    return redirect('admin_dashboard')
                else:
                    messages.error(request, 'Access denied: not an admin.')
            except UserProfile.DoesNotExist:
                messages.error(request, 'User profile not found.')
        else:
            messages.error(request, 'Invalid credentials.')

    return render(request, 'admin/admin_login.html', {'role': 'admin'})

# ✅ Admin Dashboard with Users, Orders, and Products
@login_required
@user_passes_test(is_admin)
def admin_dashboard(request):
    recent_users = User.objects.order_by('-date_joined')[:5]
    recent_orders = Order.objects.select_related('user').order_by('-date')[:5]
    recent_products = OrderItem.objects.select_related('product', 'order__user').order_by('-order__date')[:5]

    return render(request, 'admin/admin_dashboard.html', {
        'recent_users': recent_users,
        'recent_orders': recent_orders,
        'recent_products': recent_products,
    })


# ✅ Manage Users Page
@login_required
@user_passes_test(is_admin)
def manage_users(request):
    users = User.objects.all()
    return render(request, 'admin/user_management/manage_user.html', {'users': users})


# ✅ Admin Logout
@login_required
@user_passes_test(is_admin)
def admin_logout(request):
    logout(request)
    messages.info(request, "You have been logged out.")
    return redirect(request.GET.get('next', 'admin_login'))

