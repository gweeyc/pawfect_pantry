from django import forms
from .models import Product, Feedback, Vendor, UserProfile
from django.contrib.auth.models import User

class CSVUploadForm(forms.Form):
    csv_file = forms.FileField()

class ProductForm(forms.ModelForm):
    class Meta:
        model = Product
        fields = ['name', 'tags', 'species', 'food_type', 'description', 'price', 'stock', 'image']
        widgets = {
            'description': forms.Textarea(attrs={'rows': 3, 'class': 'form-control'}),
            'tags': forms.TextInput(attrs={'placeholder': 'e.g. salmon,grilled,omega-3', 'class': 'form-control'}),
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'species': forms.TextInput(attrs={'class': 'form-control'}),
            'food_type': forms.TextInput(attrs={'class': 'form-control'}),
            'price': forms.NumberInput(attrs={'class': 'form-control'}),
            'stock': forms.NumberInput(attrs={'class': 'form-control'}),
            'image': forms.ClearableFileInput(attrs={'class': 'form-control'}),
        }

class FeedbackForm(forms.ModelForm):
    class Meta:
        model = Feedback
        fields = ['comment']
        widgets = {
            'comment': forms.Textarea(attrs={
                'class': 'form-control',
                'rows': 3,
                'placeholder': 'Write your feedback here...'
            }),
        }

class VendorCreationForm(forms.ModelForm):
    # User fields
    username = forms.CharField()
    email = forms.EmailField()
    password = forms.CharField(widget=forms.PasswordInput)
    
    # Vendor fields
    business_name = forms.CharField(required=True)
    description = forms.CharField(widget=forms.Textarea, required=False)

    class Meta:
        model = Vendor
        fields = ['business_name', 'description']

    def save(self, commit=True):
        # Create the user first
        user = User.objects.create_user(
            username=self.cleaned_data['username'],
            email=self.cleaned_data['email'],
            password=self.cleaned_data['password']
        )

        # Create user profile
        profile = UserProfile.objects.create(user=user, role='vendor')

        # Create vendor linked to user
        vendor = Vendor(
            user=user,
            business_name=self.cleaned_data['business_name'],
            description=self.cleaned_data['description']
        )
        if commit:
            vendor.save()
        return vendor
    
class VendorInfoForm(forms.ModelForm):
    class Meta:
        model = Vendor  # ✅ Not UserProfile
        fields = ['business_name', 'description', 'brand_image']

class VendorAccountForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'email']

class VendorProfileForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        fields = ['profile_image', 'bio', 'phone', 'address']
