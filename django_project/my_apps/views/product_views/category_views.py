from django.http import JsonResponse
from my_apps.models import Product
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.db import models


def get_products_by_category(category_name):
    products = Product.objects.filter(
        models.Q(species__name__iexact=category_name) | 
        models.Q(food_type__name__iexact=category_name)
    ).values(
        'id', 'name', 'price', 'stock', 'description',
        'image', 'views',
        'species__name',
        'food_type__name'
    )
    return list(products)

def get_species_categories(request):
    species = Product.objects.values_list('species', flat=True).distinct().order_by('species')
    return JsonResponse(list(species), safe=False)

def get_food_type_categories(request):
    food_types = Product.objects.values_list('food_type', flat=True).distinct().order_by('food_type')
    return JsonResponse(list(food_types), safe=False)