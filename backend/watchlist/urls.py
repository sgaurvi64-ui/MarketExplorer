from django.urls import path
from . import views

urlpatterns = [
    path('', views.watchlist_home, name='watchlist-home'),
    path('items/', views.watchlist_items, name='watchlist-items'),
    path('add/', views.add_to_watchlist, name='add-to-watchlist'),
    path('remove/', views.remove_from_watchlist, name='remove-from-watchlist'),
]
