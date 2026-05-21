from django.urls import path
from . import views

urlpatterns = [
    path('', views.portfolio_home, name='portfolio-home'),
    path('summary/', views.portfolio_summary, name='portfolio-summary'),
    path('buy/', views.buy_stock, name='buy-stock'),
    path('sell/', views.sell_stock, name='sell-stock'),
    path('transactions/', views.transaction_history, name='transaction-history'),
]
