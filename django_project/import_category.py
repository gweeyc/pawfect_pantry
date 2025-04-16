import csv
import os
from django.conf import settings
from my_apps.models import Category  # Change to your app name if needed

# File paths
csv_path = os.path.join(settings.BASE_DIR, 'csv_data', 'category.csv')
banner_folder = 'banner_images'  # Relative to MEDIA_ROOT

with open(csv_path, newline='', encoding='utf-8') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        banner_image_path = os.path.join(banner_folder, row['banner_image']) if row['banner_image'] else None

        Category.objects.update_or_create(
            slug=row['slug'],
            defaults={
                'name': row['name'],
                'description': row['description'],
                'banner_image': banner_image_path,
            }
        )
