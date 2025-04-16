from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from django.contrib.auth import views as django_auth_views

# General views
from .views import views

from .views.auth_views.auth_views import (
    register_user,
    get_profile,
    update_profile,
)

from .views.auth_views.password_views import (
    api_change_password,
)

# Product views
from .views.product_views import (
    product_detail_views,
    category_views,
    cart_views,
    product_views,
)

from my_apps.views.admin_views import (
    admin_views,
    user_account_management_views,
    product_management_views,
    order_management_views,
)

from my_apps.views.product_views.product_views import catalogue_list, product_list
from my_apps.views.product_views.product_detail_views import product_detail
from my_apps.views.product_views.cart_views import (
    cart_view, update_cart, remove_from_cart, checkout_view, add_to_cart
)
from my_apps.views.product_views.order_history_views import order_history, order_detail

# AI views
from my_apps.views.ai_views import ai_recommendations, chatbot_view

# Import admin_view modules
from .views.admin_views import (
    admin_views,
    product_management_views,
    user_account_management_views,
)

# Import auth_view modules
from .views.auth_views import (
    password_views,
    auth_views,
)

urlpatterns = [
    # General Pages
    path('api/home/', views.homepage, name='home'),
    path('api/about/', views.about_view, name='about'),
    path('api/contact/', views.contact_view, name='contact'),

    # Catalogue & Product
    path('api/catalogue/', catalogue_list, name='catalogue_list'),
    path('api/catalogue/all/', product_list, name='api_product_list'),
    path('api/catalogue/<int:product_id>/', product_detail, name='product_detail'),
    path('api/catalogue/<int:product_id>/add/', add_to_cart, name='add_to_cart'),

    # Product Feedback
    path('api/catalogue/<int:product_id>/feedback/', product_detail_views.get_product_feedback, name='get_product_feedback'),
    path('api/catalogue/<int:product_id>/feedback/submit/', product_detail_views.submit_feedback, name='submit_feedback'),

    # Category Filters
    path('api/category/farmed/', category_views.farmed_fish_view, name='farmed_fish'),
    path('api/category/crustaceans/', category_views.crustaceans_view, name='crustaceans'),
    path('api/category/mollusc/', category_views.mollusc_view, name='shellfish_mollusc'),
    path('api/category/salmon/', category_views.salmon_and_tuna_view, name='salmon_and_tuna'),  # 🛠️ fixed typo
    path('api/category/wild/', category_views.wild_caught_fish_view, name='wild_caught_fish'),

    # Cart
    path('api/cart/', cart_views.cart_view, name='cart'),
    path('api/cart/add/<int:product_id>/', cart_views.add_to_cart, name='add-to-cart'),
    path('api/cart/update/', cart_views.update_cart, name='update-cart'),
    path('api/cart/remove/<int:product_id>/', cart_views.remove_from_cart, name='remove-from-cart'),
    path('api/cart/checkout/', cart_views.checkout_view, name='checkout'),

    # Orders
    path('api/orders/', order_history, name='order_history'),
    path('api/orders/<int:order_id>/', order_detail, name='order_detail'),

    # AI Features
    path('api/ai/recommendations/', ai_recommendations, name='ai_recommendations'),
    path('api/ai/chatbot/', chatbot_view, name='chatbot'),

    # Authentication
    path('api/login/', auth_views.login_view, name='login'),
    path('api/logout/', auth_views.logout_view, name='logout'),
    path('api/register/', register_user, name='register'),
    path('api/profile/', get_profile, name='get_profile'),
    path('api/profile/update/', update_profile, name='update_profile'),
    path('api/csrf/', auth_views.get_csrf_token),
    path('api/user/', auth_views.current_user_view),

    # Password Flow (Custom)
    path('api/password/reset/', password_views.api_password_reset_request, name='api_password_reset'),
    path('api/password/reset-confirm/<uidb64>/<token>/', password_views.api_password_reset_confirm, name='api_password_reset_confirm'),
    path('api/password/change/', password_views.api_change_password, name='api_password_change'),

     # --------------------
    # Admin Dashboard & Core Pages
    # --------------------
    path('dashboard/login/', admin_views.admin_login_view, name='admin_login'),
    path('dashboard/logout/', admin_views.admin_logout, name='admin_logout'),
    path('dashboard/', admin_views.admin_dashboard, name='admin_dashboard'),
    path('dashboard/users/', admin_views.manage_users, name='manage_users'),
    path('dashboard/products/', product_management_views.manage_products, name='manage_products'),
    path('dashboard/orders/', order_management_views.order_list, name='admin_order_list'),
    path('dashboard/orders/<int:order_id>/', order_management_views.order_detail, name='admin_order_detail'),
    path('dashboard/products/<int:product_id>/update/', product_management_views.product_update, name='product_update'),

    # --------------------
    # User Account Management
    # --------------------
    path('dashboard/users/all/', user_account_management_views.user_list, name='user_list'),
    path('dashboard/users/<int:user_id>/', user_account_management_views.user_detail, name='user_detail'),
    path('dashboard/users/<int:user_id>/delete/', user_account_management_views.user_delete, name='user_delete'),

    # --------------------
    # Product Management (CRUD)
    # --------------------
    path('dashboard/products/all/', product_management_views.product_list, name='admin_product_list'),
    path('dashboard/products/create/', product_management_views.product_create, name='product_create'),
    path('dashboard/products/<int:product_id>/', product_management_views.product_detail, name='product_detail'),
    path('dashboard/products/<int:product_id>/delete/', product_management_views.product_delete, name='product_delete'),
    path('dashboard/products/<int:product_id>/edit/', product_management_views.product_update, name='product_update'),
    path('dashboard/products/add/', product_management_views.product_add_view, name='product_add'),

    # --------------------
    # Order Management (CRUD)
    # --------------------
    path('dashboard/orders/all/', order_management_views.order_list, name='order_list'),
    path('dashboard/orders/<int:order_id>/', order_management_views.order_detail, name='order_detail'),

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
