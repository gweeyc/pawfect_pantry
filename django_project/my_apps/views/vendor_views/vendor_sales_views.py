# In vendor/vendor_sales_views/vendor_views.py

from django.shortcuts import render
from ..admin_views.analytics_helpers_views import generate_sales_data  # optional
from django.contrib.auth.decorators import login_required

@login_required
def vendor_sales_dashboard(request):
    context = generate_sales_data(role='vendor')
    return render(request, 'vendor/sale_management/sales_dashboard.html', context)