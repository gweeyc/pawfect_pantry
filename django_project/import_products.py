# import_products.py
import os
import django
import csv

# Setup Django environment
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "django_project.settings")
django.setup()

from my_apps.models import Product

csv_path = 'csv_data/products.csv'

with open(csv_path, newline='', encoding='utf-8') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        Product.objects.get_or_create(
            name=row['name'].strip(),
            defaults={
                'species': row.get('species', '').strip(),
                'food_type': row.get('food_type', '').strip(),
                'description': row.get('description', '').strip(),
                'tags': row.get('tags', '').strip(),
                'image': row.get('image', '').strip(),
                'price': float(row['price']) if row.get('price') else 0.0,
                'stock': int(row['stock']) if row.get('stock') else 0,
            }
        )
print("Product import completed successfully.")

exec(open("import_products.py").read())