from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from my_apps.models import Vendor, Product
from django.contrib import messages
from django.shortcuts import redirect
from ...forms import VendorCreationForm


@login_required
def manage_vendor(request):
    vendors = Vendor.objects.select_related('user').all()

    return render(request, 'admin/vendor_management/manage_vendor.html', {
        'vendors': vendors,
    })

@login_required
def vendor_detail(request, vendor_id):
    vendor = get_object_or_404(Vendor, id=vendor_id)
    products = Product.objects.filter(vendor=vendor)

    return render(request, 'admin/vendor_management/vendor_detail.html', {
        'vendor': vendor,
        'products': products,
    })

@login_required
def vendor_delete(request, vendor_id):
    vendor = get_object_or_404(Vendor, id=vendor_id)

    # Optional: cascade delete vendor's products first
    Product.objects.filter(vendor=vendor).delete()

    vendor.user.delete()  # this will also delete Vendor if user is FK-linked
    messages.success(request, "Vendor deleted successfully.")

    return redirect('vendor_list')

@login_required
def add_vendor(request):
    if request.method == 'POST':
        form = VendorCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('manage_vendors')
    else:
        form = VendorCreationForm()
    return render(request, 'admin/vendor_management/vendor_add.html', {'form': form})