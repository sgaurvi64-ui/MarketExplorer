from django.contrib import admin
from .models import Holding, Transaction


@admin.register(Holding)
class HoldingAdmin(admin.ModelAdmin):
    list_display = ('user', 'stock', 'quantity', 'average_price', 'updated_at')
    search_fields = ('user__username', 'stock__symbol')


@admin.register(Transaction)
class TransactionAdmin(admin.ModelAdmin):
    list_display = ('user', 'stock', 'order_type', 'quantity', 'price', 'executed_at')
    list_filter = ('order_type',)
    search_fields = ('user__username', 'stock__symbol')
