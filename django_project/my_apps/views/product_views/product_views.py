from django.http import JsonResponse
from django.shortcuts import get_object_or_404
from django.contrib.auth.decorators import login_required
from django.views.decorators.csrf import csrf_exempt
from django.core.paginator import Paginator
from my_apps.models import Product
from my_apps.utils.feedback_analysis_utils import analyze_sentiment
from my_apps.forms import FeedbackForm
import json
from django.views.decorators.http import require_http_methods
from django.utils.decorators import method_decorator
from django.db.models import Q
from rest_framework.decorators import api_view
from ...serializers import ProductSerializer
from rest_framework.response import Response


# ✅ Return full product list
@api_view(['GET'])
def product_list(request):
    query = request.GET.get('q', '')
    print("Search query:", query)

    if query:
        products = Product.objects.filter(
            Q(name__icontains=query) |
            Q(description__icontains=query) |
            Q(species__icontains=query) |
            Q(food_type__icontains=query) |
            Q(tags__icontains=query)
        )
        print("Filtered results:", products)
    else:
        products = Product.objects.all()
        print("Returning all products")

    serializer = ProductSerializer(products, many=True, context={'request': request})
    return Response(serializer.data)


# ✅ Return filtered, sorted, paginated catalogue
def catalogue_list(request):
    query = request.GET.get('search', '')
    sort_by = request.GET.get('sort', '')
    species = request.GET.get('species', '')
    food_type = request.GET.get('food_type', '')
    page = int(request.GET.get('page', 1))

    products = Product.objects.all()

    # 🔍 Search by name or description
    if query:
        products = products.filter(Q(name__icontains=query) | Q(description__icontains=query))

    # 🔁 Filter by species or food type directly
    if species:
        products = products.filter(species__iexact=species)
    if food_type:
        products = products.filter(food_type__iexact=food_type)

    # 🔽 Sort
    if sort_by == 'price_asc':
        products = products.order_by('price')
    elif sort_by == 'price_desc':
        products = products.order_by('-price')
    elif sort_by == 'az':
        products = products.order_by('name')
    elif sort_by == 'za':
        products = products.order_by('-name')
    else:
        products = products.order_by('id')

    # 📄 Pagination
    paginator = Paginator(products, 12)
    page_obj = paginator.get_page(page)

    data = [
        {
            "id": p.id,
            "name": p.name,
            "price": p.price,
            "stock": p.stock,
            "species": p.species,
            "food_type": p.food_type,
            "description": p.description,
            "image": request.build_absolute_uri(p.image.url) if p.image else None,
            "views": p.views
        }
        for p in page_obj
    ]

    return JsonResponse({
        "products": data,
        "page": page,
        "has_next": page_obj.has_next(),
        "has_previous": page_obj.has_previous(),
        "total_pages": paginator.num_pages
    })