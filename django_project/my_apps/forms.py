from django import forms
from .models import Product, Feedback

class ProductForm(forms.ModelForm):
    class Meta:
        model = Product
        fields = ['name', 'tags', 'category', 'description', 'price', 'stock', 'image']
        widgets = {
            'description': forms.Textarea(attrs={'rows': 3}),
            'tags': forms.TextInput(attrs={'placeholder': 'e.g. salmon,grilled,omega-3'}),
            'category': forms.Select(choices=[
                ('shellfish', 'Shellfish'),
                ('crustaceans', 'Crustaceans'),
                ('salmonids', 'Salmonids'),
                ('farmed-fish', 'Farmed Fish'),
                ('wild-caught fish', 'Wild-Caught Fish'),
                ('mollusck (squid and octopus)', 'Mollusck (Squid & Octopus)')
            ])
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