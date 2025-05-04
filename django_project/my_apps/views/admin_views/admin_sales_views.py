# In admin/admin_sales_views/admin_views.py
from django.shortcuts import render
from django.db.models import Count, Sum
from my_apps.models import Order, OrderItem
from .analytics_helpers_views import generate_sales_data  # if modularized
from django.contrib.auth.decorators import login_required

@login_required
def admin_sales_dashboard(request):
    context = generate_sales_data(role='admin')  # or inline the logic
    return render(request, 'admin/sale_management/sales_dahsboard.html', context)

@login_required
def sales_dashboard(request):
    daily_sales = (
        Order.objects
        .extra({'day': "DATE(date)"})
        .values('day')
        .annotate(total=Sum('total'))
        .order_by('day')
    )

    top_products = (
        OrderItem.objects
        .values('product__name')
        .annotate(quantity=Sum('quantity'))
        .order_by('-quantity')[:5]
    )

    return render(request, 'admin/sale_management/sales_dahsboard.html', {
        'role': 'admin',
        'daily_sales': list(daily_sales),
        'top_products': list(top_products),
    })

