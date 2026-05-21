from django.db import models


class PredictionSnapshot(models.Model):
    symbol = models.CharField(max_length=20)
    prediction = models.CharField(max_length=30)
    confidence = models.DecimalField(max_digits=5, decimal_places=2)
    risk_score = models.DecimalField(max_digits=5, decimal_places=2)
    source = models.CharField(max_length=100, default='mock-ml-engine')
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f'{self.symbol} - {self.prediction}'
