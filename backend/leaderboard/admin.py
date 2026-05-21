from django.contrib import admin
from .models import LeaderboardEntry


@admin.register(LeaderboardEntry)
class LeaderboardEntryAdmin(admin.ModelAdmin):
    list_display = ('rank', 'user', 'period_label', 'portfolio_value', 'returns_percent', 'updated_at')
    list_filter = ('period_label',)
    search_fields = ('user__username',)
