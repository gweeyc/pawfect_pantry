# views/product_views/order_history_views.py
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from my_apps.models import Order
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse


@login_required
def order_history(request):
    orders = Order.objects.filter(user=request.user).order_by('-date')
    order_data = [
        {
            'id': order.id,
            'status': order.status,
            'total': float(order.total),
            'date': order.date,
        }
        for order in orders
    ]
    return JsonResponse({'orders': order_data})


@login_required
def order_detail(request, order_id):
    try:
        order = get_object_or_404(Order, id=order_id, user=request.user)
        order_items = order.items.all()

        items_data = []
        for item in order_items:
            product = item.product
            items_data.append({
                'product_id': product.id if product else None,
                'product_name': product.name if product else 'Deleted Product',
                'quantity': item.quantity,
                'price': float(item.price),
                'subtotal': float(item.subtotal()),
            })

        order_data = {
            'id': order.id,
            'status': order.status,
            'total': float(order.total),
            'full_name': order.full_name,
            'phone': order.phone,
            'address': order.address,
            'note': order.note,
            'date': order.date,
            'items': items_data,
        }

        return JsonResponse({'order': order_data})

    except Exception as e:
        print(f"❌ Error in order_detail view: {e}")
        return JsonResponse({'error': str(e)}, status=500)