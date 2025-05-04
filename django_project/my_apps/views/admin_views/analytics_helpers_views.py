from django.db.models import Sum
from django.db.models.functions import TruncDate
from my_apps.models import Order, OrderItem, Feedback

def generate_sales_data(role='admin'):
    daily_sales = (
        Order.objects
        .annotate(day=TruncDate('date'))
        .values('day')
        .annotate(total=Sum('total'))
        .order_by('day')
    )

    top_products = (
        OrderItem.objects
        .values('product__name')
        .annotate(quantity=Sum('quantity'))
        .order_by('-quantity')[:5]
    )

    feedback_counts = {
        'positive': Feedback.objects.filter(sentiment='positive').count(),
        'neutral': Feedback.objects.filter(sentiment='neutral').count(),
        'negative': Feedback.objects.filter(sentiment='negative').count(),
    }

    return {
        'role': role,
        'daily_sales': daily_sales,
        'top_products': top_products,
        'feedback_counts': feedback_counts,
    }
