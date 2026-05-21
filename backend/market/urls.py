from django.urls import path
from . import views

urlpatterns = [
    path('', views.market_home, name='market-home'),
    path('overview/', views.market_overview, name='market-overview'),
    path('stocks/', views.stock_list, name='stock-list'),
    path('stocks/<str:symbol>/', views.stock_details, name='stock-details'),
    path('stocks/<str:symbol>/chart/', views.stock_chart, name='stock-chart'),
]
