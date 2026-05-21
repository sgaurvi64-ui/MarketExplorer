from django.contrib import admin
from .models import PredictionSnapshot


@admin.register(PredictionSnapshot)
class PredictionSnapshotAdmin(admin.ModelAdmin):
    list_display = ('symbol', 'prediction', 'confidence', 'risk_score', 'source', 'created_at')
    list_filter = ('source', 'prediction')
    search_fields = ('symbol',)
