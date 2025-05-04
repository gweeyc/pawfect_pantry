from django.contrib import admin
from .models import UserProfile, Product, CartItem, Order

admin.site.register(UserProfile)
admin.site.register(CartItem)
admin.site.register(Order)

@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('name', 'species', 'food_type', 'price', 'stock', 'created_at')
    list_filter = ('species', 'food_type')  # now string-based
    search_fields = ('name', 'tags')
