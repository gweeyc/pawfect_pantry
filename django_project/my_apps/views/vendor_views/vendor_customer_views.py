from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from my_apps.models import Order, OrderItem, UserProfile, User

@login_required
def manage_customer(request):
    profile = get_object_or_404(UserProfile, user=request.user)

    # Get distinct customers who bought from this vendor
    customer_ids = OrderItem.objects.filter(
        product__vendor__user=request.user
    ).values_list('order__user', flat=True).distinct()

    customers = User.objects.filter(id__in=customer_ids)

    return render(request, 'vendor/customer_management/manage_customer.html', {
        'customers': customers,
        'profile': profile,
    })

@login_required
def customer_detail(request, user_id):
    profile = get_object_or_404(UserProfile, user=request.user)
    customer = get_object_or_404(User, id=user_id)

    # Get all items this customer bought from this vendor
    order_items = OrderItem.objects.filter(
        order__user=customer,
        product__vendor__user=request.user
    ).select_related('product', 'order')

    return render(request, 'vendor/customer_management/customer_detail.html', {
        'customer': customer,
        'order_items': order_items,
        'profile': profile,
    })
