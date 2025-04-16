# import_users.py

#open python manage.py shell
#exec(open("import_users.py").read())

import csv
from django.contrib.auth.models import User
from my_apps.models import UserProfile  # Update 'my_apps' to your actual app name

with open('csv_data/user_profiles.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        user, created = User.objects.get_or_create(
            username=row['username'],
            defaults={
                'email': row['email'],
                'first_name': row['first_name'],
                'last_name': row['last_name'],
            }
        )
        if created:
            user.set_password("defaultpassword123")
            user.save()

        UserProfile.objects.get_or_create(
            user=user,
            defaults={
                'phone': row['phone'],
                'address': row['address'],
                'bio': row['bio'],
                'is_admin': row['is_admin'].lower() == 'true'
            }
        )
