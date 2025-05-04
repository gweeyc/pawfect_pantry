from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from my_apps.models import Delivery, UserProfile

@login_required
def delivery_management(request):
    profile = get_object_or_404(UserProfile, user=request.user)

    # Updated to use order__items__product__vendor
    deliveries = Delivery.objects.filter(order__items__product__vendor__user=request.user).distinct()

    return render(request, 'vendor/delivery_management/delivery_management.html', {
        'deliveries': deliveries,
        'profile': profile,
    })

@login_required
def delivery_detail(request, delivery_id):
    profile = get_object_or_404(UserProfile, user=request.user)
    delivery = get_object_or_404(Delivery, id=delivery_id, product__vendor__user=request.user)

    return render(request, 'vendor/delivery_management/delivery_detail.html', {
        'delivery': delivery,
        'profile': profile,
    })
