# import_products.py

#open python manage.py shell
#exec(open("import_products.py").read())

import csv
from my_apps.models import Product  # Replace 'my_apps' with your actual app name

with open('csv_data/products.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        Product.objects.get_or_create(
            name=row['name'],
            defaults={
                'description': row['description'],
                'category': row['category'],
                'tags': row.get('tags', ''),
                'image': row.get('image', None),
                'price': float(row['price']),
                'stock': int(row['stock']),
        }
    )

