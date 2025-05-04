# views/cart_views.py
from django.shortcuts import get_object_or_404
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from my_apps.models import Product, CartItem, Order
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt
import json
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def cart_view(request):
    cart_items = CartItem.objects.filter(user=request.user)
    cart_data = [
        {
            'id': item.id,
            'product_id': item.product.id,
            'product_name': item.product.name,
            'price': float(item.product.price),
            'quantity': item.quantity,
            'subtotal': float(item.subtotal()),
            'image': item.product.image.url if item.product.image else None,
        }
        for item in cart_items
    ]
    total = sum(item['subtotal'] for item in cart_data)
    return Response({'cart': cart_data, 'total': total})

@csrf_exempt
@login_required
def update_cart(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        for item_data in data.get('items', []):
            item = get_object_or_404(CartItem, user=request.user, product_id=item_data['product_id'])
            item.quantity = int(item_data['quantity'])
            item.save()
        return JsonResponse({'message': 'Cart updated successfully!'})
    return JsonResponse({'error': 'Invalid method'}, status=405)


@csrf_exempt
@login_required
def remove_from_cart(request, product_id):
    if request.method == 'POST':
        item = get_object_or_404(CartItem, user=request.user, product_id=product_id)
        item.delete()
        return JsonResponse({'message': 'Item removed from cart.'})
    return JsonResponse({'error': 'Invalid method'}, status=405)


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def add_to_cart(request, product_id):
    product = get_object_or_404(Product, id=product_id)
    cart_item, created = CartItem.objects.get_or_create(user=request.user, product=product)
    if not created:
        cart_item.quantity += 1
        cart_item.save()
    return Response({'message': 'Item added to cart successfully!'})


from my_apps.models import Product, CartItem, Order, OrderItem  # include OrderItem

@csrf_exempt
@login_required
def checkout_view(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        name = data.get('full_name')
        phone = data.get('phone')
        address = data.get('address')
        note = data.get('note', '')

        cart_items = CartItem.objects.filter(user=request.user)

        if not cart_items.exists():
            return JsonResponse({'error': 'Your cart is empty.'}, status=400)

        total = sum(item.product.price * item.quantity for item in cart_items)

        order = Order.objects.create(
            user=request.user,
            full_name=name,
            phone=phone,
            address=address,
            note=note,
            total=total,
            status="Processing",
            date=timezone.now()
        )

        # ✅ Create OrderItem for each CartItem
        for item in cart_items:
            OrderItem.objects.create(
                order=order,
                product=item.product,
                quantity=item.quantity,
                price=item.product.price  # store price at time of order
            )

        cart_items.delete()

        return JsonResponse({'message': 'Order placed successfully!', 'order_id': order.id})
    
    return JsonResponse({'error': 'Invalid method'}, status=405)

