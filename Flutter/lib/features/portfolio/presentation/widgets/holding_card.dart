import 'package:flutter/material.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../data/models/portfolio/holding_model.dart';

class HoldingCard extends StatelessWidget {
  const HoldingCard({
    super.key,
    required this.holding,
  });

  final HoldingModel holding;

  @override
  Widget build(BuildContext context) {
    final isPositive = holding.profitLoss >= 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFD9F6EA),
                  child: Text(holding.stock.symbol.substring(0, 1)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        holding.stock.symbol,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(holding.stock.companyName),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      CurrencyFormatter.format(holding.marketValue),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '${isPositive ? '+' : ''}${CurrencyFormatter.format(holding.profitLoss)}',
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _HoldingStat(
                    label: 'Qty',
                    value: '${holding.quantity}',
                  ),
                ),
                Expanded(
                  child: _HoldingStat(
                    label: 'Avg price',
                    value: CurrencyFormatter.format(holding.averagePrice),
                  ),
                ),
                Expanded(
                  child: _HoldingStat(
                    label: 'Live price',
                    value: CurrencyFormatter.format(holding.stock.price),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HoldingStat extends StatelessWidget {
  const _HoldingStat({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
