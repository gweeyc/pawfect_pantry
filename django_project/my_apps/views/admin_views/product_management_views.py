from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test
from my_apps.models import Product
from my_apps.forms import ProductForm

# Admin check
def is_admin(user):
    return user.is_staff or user.is_superuser

# View: List All Products
@login_required
@user_passes_test(is_admin)
def product_list(request):
    products = Product.objects.all()
    return render(request, 'admin/product_management/manage_product.html', {'products': products})

# View: Product Details + Edit Form
@login_required
@user_passes_test(is_admin)
def product_detail(request, product_id):
    product = get_object_or_404(Product, id=product_id)
    if request.method == 'POST':
        product.name = request.POST.get('name')
        product.description = request.POST.get('description')
        product.price = request.POST.get('price')
        product.stock = request.POST.get('stock')
        product.save()
        messages.success(request, f'Product "{product.name}" updated.')
        return redirect('product_detail', product_id=product.id)
    return render(request, 'admin/product_management/products_detail.html', {'product': product})

# View: Create Product
@login_required
@user_passes_test(is_admin)
def product_create(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        description = request.POST.get('description')
        price = request.POST.get('price')
        stock = request.POST.get('stock')
        Product.objects.create(name=name, description=description, price=price, stock=stock)
        messages.success(request, f'Product "{name}" created.')
        return redirect('product_list')
    return render(request, 'admin/product_management/products_detail.html')  # optional separate form if needed

# View: Delete Product
@login_required
@user_passes_test(is_admin)
def product_delete(request, product_id):
    product = get_object_or_404(Product, id=product_id)
    product.delete()
    messages.success(request, f'Product "{product.name}" deleted.')
    return redirect('admin/product_management/manage_product.html')

@login_required
@user_passes_test(lambda u: u.is_staff)
def product_update(request, product_id):
    product = get_object_or_404(Product, id=product_id)

    if request.method == "POST":
        form = ProductForm(request.POST, request.FILES, instance=product)
        if form.is_valid():
            form.save()
            return redirect('manage_products')  # Redirect back to admin product list
    else:
        form = ProductForm(instance=product)

    return render(request, 'admin/product_management/update_product.html', {'form': form})


# Manage Products
@login_required
@user_passes_test(is_admin)
def manage_products(request):
    products = Product.objects.all()
    return render(request, 'admin/product_management/manage_product.html', {'products': products})


def product_add_view(request):
    if request.method == 'POST':
        form = ProductForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('product_list')  # or wherever your product list view is
    else:
        form = ProductForm()
    return render(request, 'admin/product_management/add_product.html', {'form': form})
