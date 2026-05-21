from django.db import models


class Stock(models.Model):
    symbol = models.CharField(max_length=20, unique=True)
    company_name = models.CharField(max_length=255)
    sector = models.CharField(max_length=120, blank=True)
    description = models.TextField(blank=True)
    current_price = models.DecimalField(max_digits=12, decimal_places=2)
    price_change = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    change_percent = models.DecimalField(max_digits=8, decimal_places=2, default=0)
    day_high = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    day_low = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    volume = models.BigIntegerField(default=0)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['symbol']

    def __str__(self):
        return self.symbol


class StockCandle(models.Model):
    stock = models.ForeignKey(Stock, on_delete=models.CASCADE, related_name='candles')
    interval = models.CharField(max_length=20, default='1D')
    open_price = models.DecimalField(max_digits=12, decimal_places=2)
    high_price = models.DecimalField(max_digits=12, decimal_places=2)
    low_price = models.DecimalField(max_digits=12, decimal_places=2)
    close_price = models.DecimalField(max_digits=12, decimal_places=2)
    volume = models.BigIntegerField(default=0)
    recorded_at = models.DateTimeField()

    class Meta:
        ordering = ['recorded_at']

    def __str__(self):
        return f'{self.stock.symbol} {self.interval} {self.recorded_at.isoformat()}'
