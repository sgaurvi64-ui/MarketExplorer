from django.urls import path
from . import views

urlpatterns = [
    path('', views.leaderboard_home, name='leaderboard-home'),
    path('rankings/', views.rankings, name='leaderboard-rankings'),
]
