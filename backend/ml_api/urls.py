from django.urls import path
from . import views

urlpatterns = [
    path('', views.ml_home, name='ml-home'),
    path('status/', views.engine_status, name='engine-status'),
    path('predict/<str:symbol>/', views.predict_stock, name='predict-stock'),
    path('recommend/', views.recommendation_summary, name='recommendation-summary'),
]
