from django.http import JsonResponse
from my_apps.models import Product

# 🔁 Shared category filter
def get_products_by_category(category_name):
    products = Product.objects.filter(category__iexact=category_name).values(
        'id', 'name', 'price', 'stock', 'description',
        'image', 'views'
    )
    return list(products)

# 🐟 Farmed Fish
def farmed_fish_view(request):
    products = get_products_by_category('farmed_fish')
    return JsonResponse({'category': 'farmed_fish', 'products': products})

# 🦐 Crustaceans
def crustaceans_view(request):
    products = get_products_by_category('crustaceans')
    return JsonResponse({'category': 'crustaceans', 'products': products})

def mollusc_view(request):
    products = Product.objects.filter(
        category__iexact='shellfish'
    ) | Product.objects.filter(
        category__iexact='mollusk'
    )
    products = products.values(
        'id', 'name', 'price', 'stock', 'description',
        'image', 'views'
    )
    return JsonResponse({'category': 'shellfish_mollusk', 'products': list(products)})

def salmon_and_tuna_view(request):
    products = get_products_by_category('slamon and tuna')
    return JsonResponse({'category': 'slamon_and_tuna', 'products': products})

def wild_caught_fish_view(request):
    products = get_products_by_category('wild_caught_fish')
    return JsonResponse({'category': 'wild_caught_fish', 'products': products})
