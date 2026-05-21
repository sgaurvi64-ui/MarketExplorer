from django.contrib.auth.models import User
from .models import UserProfile


def get_demo_user():
    user, created = User.objects.get_or_create(
        username='demo_user',
        defaults={
            'email': 'demo@stocksim.in',
            'first_name': 'Demo',
            'last_name': 'User',
        },
    )

    if created:
        user.set_password('password123')
        user.save()

    UserProfile.objects.get_or_create(
        user=user,
        defaults={
            'display_name': 'Demo Investor',
            'virtual_balance': 1000000,
            'is_demo_account': True,
        },
    )

    return user
