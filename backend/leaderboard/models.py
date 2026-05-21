from django.conf import settings
from django.db import models


class LeaderboardEntry(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='leaderboard_entries',
    )
    period_label = models.CharField(max_length=50, default='weekly')
    portfolio_value = models.DecimalField(max_digits=14, decimal_places=2, default=0)
    returns_percent = models.DecimalField(max_digits=8, decimal_places=2, default=0)
    rank = models.PositiveIntegerField(default=0)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['rank', '-portfolio_value']
        unique_together = ('user', 'period_label')

    def __str__(self):
        return f'{self.period_label} - {self.user.username} - #{self.rank}'
