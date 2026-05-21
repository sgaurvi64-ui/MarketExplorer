import 'package:flutter/material.dart';
import '../../../../core/utils/currency_formatter.dart';

class PortfolioSummaryCard extends StatelessWidget {
  const PortfolioSummaryCard({
    super.key,
    required this.cashBalance,
    required this.profitLoss,
  });

  final double cashBalance;
  final double profitLoss;

  @override
  Widget build(BuildContext context) {
    final isPositive = profitLoss >= 0;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available cash',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(CurrencyFormatter.format(cashBalance)),
            const SizedBox(height: 8),
            Text(
              'Today P/L ${isPositive ? '+' : ''}${CurrencyFormatter.format(profitLoss)}',
              style: TextStyle(
                color: isPositive ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
