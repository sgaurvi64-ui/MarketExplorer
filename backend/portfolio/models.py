from django.conf import settings
from django.db import models


class Holding(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='holdings',
    )
    stock = models.ForeignKey(
        'market.Stock',
        on_delete=models.CASCADE,
        related_name='holdings',
    )
    quantity = models.PositiveIntegerField(default=0)
    average_price = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ('user', 'stock')

    def __str__(self):
        return f'{self.user.username} - {self.stock.symbol}'


class Transaction(models.Model):
    class OrderType(models.TextChoices):
        BUY = 'BUY', 'Buy'
        SELL = 'SELL', 'Sell'

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='transactions',
    )
    stock = models.ForeignKey(
        'market.Stock',
        on_delete=models.CASCADE,
        related_name='transactions',
    )
    order_type = models.CharField(max_length=4, choices=OrderType.choices)
    quantity = models.PositiveIntegerField()
    price = models.DecimalField(max_digits=12, decimal_places=2)
    total_amount = models.DecimalField(max_digits=14, decimal_places=2)
    executed_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-executed_at']

    def __str__(self):
        return f'{self.order_type} {self.stock.symbol} x{self.quantity}'
