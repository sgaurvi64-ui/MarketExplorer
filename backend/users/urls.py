from django.urls import path
from . import views

urlpatterns = [
    path('', views.users_home, name='users-home'),
    path('register/', views.register_user, name='register-user'),
    path('login/', views.login_user, name='login-user'),
    path('profile/', views.user_profile, name='user-profile'),
]
