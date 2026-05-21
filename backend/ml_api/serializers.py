from rest_framework import serializers
from .models import PredictionSnapshot


class PredictionSnapshotSerializer(serializers.ModelSerializer):
    class Meta:
        model = PredictionSnapshot
        fields = [
            'id',
            'symbol',
            'prediction',
            'confidence',
            'risk_score',
            'source',
            'created_at',
        ]
