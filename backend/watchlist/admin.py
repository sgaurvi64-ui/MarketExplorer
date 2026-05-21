from django.contrib import admin
from .models import WatchlistItem


@admin.register(WatchlistItem)
class WatchlistItemAdmin(admin.ModelAdmin):
    list_display = ('user', 'stock', 'created_at')
    search_fields = ('user__username', 'stock__symbol')
