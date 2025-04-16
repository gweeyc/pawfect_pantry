from django.contrib.auth.decorators import login_required, user_passes_test
from django.shortcuts import render, get_object_or_404
from my_apps.models import Order


# Reusable admin check
def is_admin(user):
    return user.is_staff or user.is_superuser


# View: List all orders
@login_required
@user_passes_test(is_admin)
def order_list(request):
    orders = Order.objects.all().order_by('-date')
    return render(request, 'admin/order_management/order_list.html', {'orders': orders})


# View: Order detail + status update
@login_required
@user_passes_test(is_admin)
def order_detail(request, order_id):
    order = get_object_or_404(Order, id=order_id)

    if request.method == "POST":
        new_status = request.POST.get('status')
        if new_status and new_status != order.status:
            order.status = new_status
            order.save()

    return render(request, 'admin/order_management/order_detail.html', {'order': order})
