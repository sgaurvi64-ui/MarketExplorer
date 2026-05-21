from rest_framework import serializers
from .models import Holding, Transaction


class HoldingSerializer(serializers.ModelSerializer):
    symbol = serializers.CharField(source='stock.symbol', read_only=True)
    company_name = serializers.CharField(source='stock.company_name', read_only=True)
    current_price = serializers.DecimalField(
        source='stock.current_price',
        max_digits=12,
        decimal_places=2,
        read_only=True,
    )

    class Meta:
        model = Holding
        fields = [
            'id',
            'symbol',
            'company_name',
            'quantity',
            'average_price',
            'current_price',
            'updated_at',
        ]


class TransactionSerializer(serializers.ModelSerializer):
    symbol = serializers.CharField(source='stock.symbol', read_only=True)
    company_name = serializers.CharField(source='stock.company_name', read_only=True)

    class Meta:
        model = Transaction
        fields = [
            'id',
            'symbol',
            'company_name',
            'order_type',
            'quantity',
            'price',
            'total_amount',
            'executed_at',
        ]
