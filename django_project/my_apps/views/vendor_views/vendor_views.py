from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from my_apps.models import UserProfile, Product, Order, Vendor
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import User
from django.core.mail import send_mail
from django.contrib.auth.models import BaseUserManager
from my_apps.forms import VendorInfoForm, VendorAccountForm, VendorProfileForm
from my_apps.models import Vendor


@login_required
def vendor_dashboard(request):
    try:
        profile = UserProfile.objects.get(user=request.user)
    except UserProfile.DoesNotExist:
        return redirect('admin_vendor_login')  # fallback

    if profile.role != 'vendor':
        return redirect('admin_vendor_login')  # prevent non-vendors from accessing

    # Optional: Get products owned by this vendor
    products = Product.objects.filter(vendor__user=request.user)

    # Optional: Orders that contain vendor's products
    vendor_orders = Order.objects.filter(items__product__vendor__user=request.user).distinct()

    context = {
        'profile': profile,
        'products': products,
        'orders': vendor_orders,
    }

    return render(request, 'vendor/vendor_dashboard.html', context)

# VENDOR LOGIN VIEW
def vendor_login(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')

        user = authenticate(request, username=username, password=password)

        if user is not None:
            try:
                profile = UserProfile.objects.get(user=user)
                if profile.role == 'vendor':
                    login(request, user)
                    return redirect('vendor_dashboard')
                else:
                    messages.error(request, 'Access denied: not a vendor.')
            except UserProfile.DoesNotExist:
                messages.error(request, 'User profile not found.')
        else:
            messages.error(request, 'Invalid credentials.')

    return render(request, 'vendor/vendor_login.html', {'role': 'vendor'})

def vendor_logout(request):
    logout(request)
    messages.success(request, "You have been logged out successfully.")
    return redirect('vendor_login')  # Redirect to vendor login after logout

def vendor_register(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        email = request.POST.get('email')
        password = request.POST.get('password')
        business_name = request.POST.get('business_name')
        location = request.POST.get('location')

        if User.objects.filter(username=username).exists():
            messages.error(request, "Username already taken.")
        else:
            user = User.objects.create(
                username=username,
                email=email,
                password=make_password(password)
            )
            user_profile = UserProfile.objects.create(user=user, role='vendor')
            Vendor.objects.create(user=user, business_name=business_name, location=location)
            messages.success(request, "Vendor registered successfully. Please log in.")
            return redirect('vendor_login')

    return render(request, 'vendor/vendor_register.html')

def vendor_reset_password(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        try:
            user = User.objects.get(email=email)
            # You can generate a new password or send a reset link
            temp_password = BaseUserManager().make_random_password()
            user.set_password(temp_password)
            user.save()

            send_mail(
                'Your Password Reset',
                f'Hi {user.username}, your new password is: {temp_password}',
                'no-reply@tourbooking.com',
                [email],
                fail_silently=False,
            )

            messages.success(request, "A new password has been sent to your email.")
        except User.DoesNotExist:
            messages.error(request, "No vendor found with that email.")

    return render(request, 'vendor/vendor_reset_password.html')

@login_required
def update_vendor_profile(request):
    user = request.user
    profile = user.userprofile
    vendor = user.vendor

    if request.method == 'POST':
        account_form = VendorAccountForm(request.POST, instance=user)
        profile_form = VendorProfileForm(request.POST, request.FILES, instance=profile)
        vendor_form = VendorInfoForm(request.POST, request.FILES, instance=vendor)

        if all([account_form.is_valid(), profile_form.is_valid(), vendor_form.is_valid()]):
            account_form.save()
            profile_form.save()
            vendor_form.save()
            messages.success(request, "Your profile has been updated.")
            return redirect('vendor_dashboard')
    else:
        account_form = VendorAccountForm(instance=user)
        profile_form = VendorProfileForm(instance=profile)
        vendor_form = VendorInfoForm(instance=vendor)

    return render(request, 'vendor/vendor_profile_edit.html', {
        'account_form': account_form,
        'profile_form': profile_form,
        'vendor_form': vendor_form,
    })

