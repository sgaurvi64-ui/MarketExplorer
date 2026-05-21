from rest_framework import serializers
from .models import LeaderboardEntry


class LeaderboardEntrySerializer(serializers.ModelSerializer):
    name = serializers.CharField(source='user.username', read_only=True)

    class Meta:
        model = LeaderboardEntry
        fields = [
            'id',
            'rank',
            'name',
            'period_label',
            'portfolio_value',
            'returns_percent',
            'updated_at',
        ]
