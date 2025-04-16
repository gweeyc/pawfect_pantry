from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from my_apps.models import Product, Feedback

def get_product_feedback(request, product_id):
    try:
        product = get_object_or_404(Product, id=product_id)

        feedback_qs = Feedback.objects.filter(product=product).select_related('user')
        feedback_data = [
            {
                'user': f.user.username,
                'comment': f.comment,
                'sentiment': f.sentiment,
                'created_at': f.created_at.strftime('%Y-%m-%d %H:%M:%S'),  # ✅ formatted
            }
            for f in feedback_qs
        ]

        return JsonResponse({
            'id': product.id,
            'name': product.name,
            'category': product.category.name if product.category else '',
            'description': product.description,
            'price': product.price,
            'stock': product.stock,
            'image': product.image.url if product.image else None,
            'feedback': feedback_data
        })
    except Exception as e:
        print("Error in get_product_feedback:", e)
        return JsonResponse({'error': str(e)}, status=500)
