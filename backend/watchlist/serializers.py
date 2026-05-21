from rest_framework import serializers
from .models import WatchlistItem


class WatchlistItemSerializer(serializers.ModelSerializer):
    symbol = serializers.CharField(source='stock.symbol', read_only=True)
    company_name = serializers.CharField(source='stock.company_name', read_only=True)
    current_price = serializers.DecimalField(
        source='stock.current_price',
        max_digits=12,
        decimal_places=2,
        read_only=True,
    )

    class Meta:
        model = WatchlistItem
        fields = [
            'id',
            'symbol',
            'company_name',
            'current_price',
            'created_at',
        ]
