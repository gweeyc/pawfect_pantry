from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from my_apps.models import Product, Feedback
from my_apps.utils.ai_utils import get_similar_products
from my_apps.models import Order  # make sure this is correct path
import json
from django.conf import settings
import requests


@login_required
def ai_recommendations(request):
    recommended_products = Product.objects.order_by('-views')[:3]
    data = [
        {
            "id": p.id,
            "name": p.name,
            "price": p.price,
            "views": p.views,
            "image": request.build_absolute_uri(p.image.url) if p.image else None,
        }
        for p in recommended_products
    ]
    return JsonResponse({"recommended": data})

@login_required
def product_recommendations(request, product_id):
    similar_products = get_similar_products(product_id)
    data = [
        {
            "id": p.id,
            "name": p.name,
            "price": p.price,
            "views": p.views,
            "image": request.build_absolute_uri(p.image.url) if p.image else None,
        }
        for p in similar_products
    ]
    return JsonResponse({"similar": data})

def get_similar_products(product_id):
    try:
        base = Product.objects.get(id=product_id)
        query = Product.objects.exclude(id=product_id)
        # Naive similarity based on tags or name overlap (simplified for now)
        similar = query.filter(tags__icontains=base.tags.split(',')[0])[:3]
        return similar
    except Product.DoesNotExist:
        return Product.objects.none()

@csrf_exempt
def submit_feedback(request, product_id):
    if request.method == "POST":
        data = json.loads(request.body)
        comment = data.get("comment")
        product = Product.objects.get(id=product_id)
        Feedback.objects.create(product=product, user=request.user, comment=comment)
        return JsonResponse({'message': 'Feedback submitted'})
 