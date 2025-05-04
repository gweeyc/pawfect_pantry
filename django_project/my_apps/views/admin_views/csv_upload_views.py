# views/admin/csv_upload_view.py (or anywhere appropriate)
import csv
from django.shortcuts import render, redirect
from my_apps.models import Product
from my_apps.forms import CSVUploadForm

def upload_products_csv(request):
    if request.method == 'POST':
        form = CSVUploadForm(request.POST, request.FILES)
        if form.is_valid():
            csv_file = form.cleaned_data['csv_file']
            decoded_file = csv_file.read().decode('utf-8').splitlines()
            reader = csv.DictReader(decoded_file)

            for row in reader:
                Product.objects.get_or_create(
                    name=row['name'],
                    defaults={
                        'description': row.get('description', ''),
                        'category': row.get('category', ''),
                        'tags': row.get('tags', ''),
                        'image': row.get('image', None),  # Assuming this is a filename, you’ll need to handle it properly
                        'price': float(row['price']) if row['price'] else 0.0,
                        'stock': int(row['stock']) if row['stock'] else 0,
                    }
                )
            return redirect('product_list')  # Replace with your desired redirect
    else:
        form = CSVUploadForm()

    return render(request, 'admin/csv_upload.html', {'form': form})
