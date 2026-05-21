from django.conf import settings
from django.db import models


class WatchlistItem(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='watchlist_items',
    )
    stock = models.ForeignKey(
        'market.Stock',
        on_delete=models.CASCADE,
        related_name='watchlisted_by',
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'stock')
        ordering = ['-created_at']

    def __str__(self):
        return f'{self.user.username} - {self.stock.symbol}'
