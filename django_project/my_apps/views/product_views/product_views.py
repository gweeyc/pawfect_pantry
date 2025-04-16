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

# ✅ Return full product list
def product_list(request):
    products = Product.objects.all()
    data = [
        {
            "id": p.id,
            "name": p.name,
            "price": p.price,
            "stock": p.stock,
            "description": p.description,
            "category": p.category.name if p.category else None,
            "image": request.build_absolute_uri(p.image.url) if p.image else None,
            "views": p.views
        }
        for p in products
    ]
    return JsonResponse(data, safe=False)

# ✅ Return filtered, sorted, paginated catalogue
def catalogue_list(request):
    query = request.GET.get('search', '')
    sort_by = request.GET.get('sort', '')
    category = request.GET.get('category', '')
    page = int(request.GET.get('page', 1))

    products = Product.objects.all()

    if query:
        products = products.filter(name__icontains=query)
    if category:
        products = products.filter(category__iexact=category)

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

    paginator = Paginator(products, 12)
    page_obj = paginator.get_page(page)

    data = [
        {
            "id": p.id,
            "name": p.name,
            "price": p.price,
            "stock": p.stock,
            "category": p.category,  # no .name needed
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

