from django.contrib import admin
from .models import Stock, StockCandle


@admin.register(Stock)
class StockAdmin(admin.ModelAdmin):
    list_display = ('symbol', 'company_name', 'current_price', 'change_percent', 'is_active')
    list_filter = ('is_active', 'sector')
    search_fields = ('symbol', 'company_name')


@admin.register(StockCandle)
class StockCandleAdmin(admin.ModelAdmin):
    list_display = ('stock', 'interval', 'close_price', 'recorded_at')
    list_filter = ('interval',)
    search_fields = ('stock__symbol',)
