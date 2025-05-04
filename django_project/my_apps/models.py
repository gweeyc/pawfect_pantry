from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
from django.utils.text import slugify
from django.conf import settings  # to reference AUTH_USER_MODEL safely


class UserProfile(models.Model):
    ROLE_CHOICES = [
        ('admin', 'Admin'),
        ('vendor', 'Vendor'),
        ('customer', 'Customer'),
    ]

    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    phone = models.CharField(max_length=15, blank=True, null=True)
    email = models.EmailField(blank=True, null=True)
    address = models.TextField(blank=True, null=True)
    bio = models.TextField(blank=True, null=True)
    role = models.CharField(max_length=10, choices=ROLE_CHOICES, default='customer')  
    is_admin = models.BooleanField(default=False)
    profile_image = models.ImageField(upload_to='profiles/', null=True, blank=True)  

    def __str__(self):
        return self.user.username

    def get_full_name(self):
        return f"{self.user.first_name} {self.user.last_name}".strip() or self.user.username
    
class Vendor(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE) 
    business_name = models.CharField(max_length=20, blank=True, null=True)
    description = models.TextField(blank=True, null=True)  
    brand_image = models.ImageField(upload_to='brand_images/', null=True, blank=True)

    def __str__(self):
        return f"{self.business_name or self.user.username}"
    
class Product(models.Model):
    name = models.CharField(max_length=100)
    species = models.CharField(max_length=100, null=True, blank=True)      
    food_type = models.CharField(max_length=100, null=True, blank=True)     
    tags = models.CharField(max_length=500, null=True, blank=True)
    description = models.TextField(null=True, blank=True)
    price = models.DecimalField(max_digits=8, decimal_places=2, null=True, blank=True)
    stock = models.IntegerField(default=0, null=True, blank=True)
    image = models.ImageField(upload_to='products_images/', null=True, blank=True)
    views = models.IntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    vendor = models.ForeignKey(Vendor, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return self.name

    
class Order(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    full_name = models.CharField(max_length=255)
    phone = models.CharField(max_length=20)
    address = models.TextField()
    note = models.TextField(blank=True, null=True)
    total = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=50, default="Pending")
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Order #{self.id} by {self.user.username}"
    
class OrderStatusHistory(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    status = models.CharField(max_length=50)
    updated_at = models.DateTimeField(auto_now_add=True)

class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='items')
    product = models.ForeignKey(Product, on_delete=models.SET_NULL, null=True)
    quantity = models.PositiveIntegerField(default=1)
    price = models.DecimalField(max_digits=8, decimal_places=2, null=True, blank=True)

    def subtotal(self):
        return self.quantity * self.price

    def __str__(self):
        return f"{self.quantity} x {self.product.name} in Order #{self.order.id}"
    
class CartItem(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)

    def subtotal(self):
        return self.product.price * self.quantity

class Feedback(models.Model):
    product = models.ForeignKey(Product, related_name='feedbacks', on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    comment = models.TextField()
    sentiment = models.CharField(max_length=20, blank=True, null=True) 
    created_at = models.DateTimeField(default=timezone.now)  

    def __str__(self):
        return f"{self.user.username} on {self.product.name}"
    
class Delivery(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='deliveries')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    company = models.CharField(max_length=20, blank=True, null=True) 
    pick_up_time = models.DateTimeField(default=timezone.now)
    eta = models.DateTimeField(default=timezone.now)
    actual_delivery_time = models.DateTimeField(default=timezone.now)
    tracking_url = models.URLField(blank=True, null=True)

    def __str__(self):
        return f"{self.user.username} - Order #{self.order.id}"

