from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .helpers import get_demo_user
from .models import UserProfile
from .serializers import UserSerializer


@api_view(['GET'])
def users_home(request):
    return Response({
        'module': 'users',
        'status': 'ok',
        'message': 'Users API is ready.',
    })


@api_view(['POST'])
def register_user(request):
    first_name = request.data.get('first_name', '').strip()
    last_name = request.data.get('last_name', '').strip()
    name = request.data.get('name', 'Demo User').strip()
    email = request.data.get('email', 'demo@stocksim.in')
    username = (
        request.data.get('username')
        or request.data.get('user_id')
        or email.split('@')[0]
    )

    if not name:
        name = ' '.join(part for part in [first_name, last_name] if part).strip()
    if not name:
        name = 'Demo User'

    if not first_name:
        first_name = name

    defaults = {
        'email': email,
        'first_name': first_name,
        'last_name': last_name,
    }

    user, created = User.objects.get_or_create(
        username=username,
        defaults=defaults,
    )

    profile, _ = UserProfile.objects.get_or_create(
        user=user,
        defaults={
            'display_name': name,
            'virtual_balance': 1000000,
            'is_demo_account': True,
        },
    )

    if not created:
        user.email = email
        user.first_name = first_name
        user.last_name = last_name
        user.save(update_fields=['email', 'first_name', 'last_name'])
        profile.display_name = name
        profile.save(update_fields=['display_name', 'updated_at'])

    return Response({
        'message': 'Registration successful.',
        'user': UserSerializer(user).data,
    }, status=status.HTTP_201_CREATED if created else status.HTTP_200_OK)


@api_view(['POST'])
def login_user(request):
    email = request.data.get('email', 'demo@stocksim.in')
    user = User.objects.filter(email=email).first() or get_demo_user()

    return Response({
        'message': 'Login successful.',
        'token': 'demo-token-123',
        'user': UserSerializer(user).data,
    })


@api_view(['GET'])
def user_profile(request):
    user = get_demo_user()
    return Response(UserSerializer(user).data)
