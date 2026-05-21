from rest_framework import serializers
from .models import Stock, StockCandle


class StockSerializer(serializers.ModelSerializer):
    class Meta:
        model = Stock
        fields = [
            'id',
            'symbol',
            'company_name',
            'sector',
            'description',
            'current_price',
            'price_change',
            'change_percent',
            'day_high',
            'day_low',
            'volume',
            'is_active',
        ]


class StockCandleSerializer(serializers.ModelSerializer):
    class Meta:
        model = StockCandle
        fields = [
            'id',
            'interval',
            'open_price',
            'high_price',
            'low_price',
            'close_price',
            'volume',
            'recorded_at',
        ]
