from decimal import Decimal
from rest_framework.decorators import api_view
from rest_framework.response import Response
from users.helpers import get_demo_user
from .models import LeaderboardEntry
from .serializers import LeaderboardEntrySerializer


@api_view(['GET'])
def leaderboard_home(request):
    return Response({
        'module': 'leaderboard',
        'status': 'ok',
        'message': 'Leaderboard API is ready.',
    })


@api_view(['GET'])
def rankings(request):
    get_demo_user()
    if not LeaderboardEntry.objects.exists():
        from django.contrib.auth.models import User

        demo_users = [
            ('aarav_capital', 'Aarav', 'Capital', Decimal('1242500.12'), Decimal('24.20'), 1),
            ('market_maven', 'Market', 'Maven', Decimal('1181040.44'), Decimal('18.80'), 2),
            ('demo_user', 'Demo', 'User', Decimal('1128880.18'), Decimal('12.60'), 3),
        ]

        for username, first_name, last_name, value, returns, rank in demo_users:
            user, _ = User.objects.get_or_create(
                username=username,
                defaults={'first_name': first_name, 'last_name': last_name},
            )
            LeaderboardEntry.objects.update_or_create(
                user=user,
                period_label='weekly',
                defaults={
                    'portfolio_value': value,
                    'returns_percent': returns,
                    'rank': rank,
                },
            )

    entries = LeaderboardEntry.objects.filter(period_label='weekly').select_related('user')
    return Response({
        'results': LeaderboardEntrySerializer(entries, many=True).data,
    })
