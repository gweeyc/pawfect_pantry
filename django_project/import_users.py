# import_users.py

# Usage:
# python manage.py shell
# >>> exec(open("import_users.py").read())

import csv
from django.contrib.auth.models import User
from my_apps.models import UserProfile  # Change 'my_apps' to your app name

with open('csv_data/user_profiles.csv', newline='', encoding='utf-8') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        username = row['username'].strip()
        email = row['email'].strip()
        first_name = row.get('first_name', '').strip()
        last_name = row.get('last_name', '').strip()
        phone = row.get('phone', '').strip()
        address = row.get('address', '').strip()
        bio = row.get('bio', '').strip()
        is_admin = row.get('is_admin', 'false').strip().lower() == 'true'

        user, created = User.objects.get_or_create(
            username=username,
            defaults={
                'email': email,
                'first_name': first_name,
                'last_name': last_name,
            }
        )

        if created:
            user.set_password("defaultpassword123")
            user.save()
            print(f"Created user: {username}")
        else:
            print(f"User already exists: {username}")

        profile, created_profile = UserProfile.objects.get_or_create(
            user=user,
            defaults={
                'phone': phone,
                'address': address,
                'bio': bio,
                'is_admin': is_admin
            }
        )
        if created_profile:
            print(f"Created profile for: {username}")
        else:
            print(f"Profile already exists for: {username}")
