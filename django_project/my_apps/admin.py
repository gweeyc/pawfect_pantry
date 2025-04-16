from django.contrib import admin
from .models import UserProfile, Product, CartItem, Order

admin.site.register(UserProfile)
admin.site.register(CartItem)
admin.site.register(Order)

class ProductAdmin(admin.ModelAdmin):
    list_display = ['name', 'category', 'price', 'stock']

admin.site.register(Product, ProductAdmin)  # ✅ Register with custom admin only
