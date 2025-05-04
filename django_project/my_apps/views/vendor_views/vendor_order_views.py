from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from my_apps.models import Order, OrderItem, UserProfile

@login_required
def manage_order(request):
    profile = get_object_or_404(UserProfile, user=request.user)

    # Get orders containing at least one product by this vendor
    orders = Order.objects.filter(items__product__vendor__user=request.user).distinct()

    return render(request, 'vendor/order_management/manage_order.html', {
        'orders': orders,
        'profile': profile,
    })

@login_required
def order_detail(request, order_id):
    profile = get_object_or_404(UserProfile, user=request.user)
    order = get_object_or_404(Order, id=order_id)

    # Filter only the vendor's items
    vendor_items = order.items.filter(product__vendor__user=request.user)

    return render(request, 'vendor/order_management/order_detail.html', {
        'order': order,
        'items': vendor_items,
        'profile': profile,
    })
