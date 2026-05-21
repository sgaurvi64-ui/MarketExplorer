import 'package:flutter/material.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../data/models/market/quote_model.dart';

class MarketIndexCard extends StatelessWidget {
  const MarketIndexCard({
    super.key,
    required this.index,
  });

  final QuoteModel index;

  @override
  Widget build(BuildContext context) {
    final isPositive = index.change >= 0;
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            index.symbol,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(CurrencyFormatter.format(index.price)),
          const SizedBox(height: 6),
          Text(
            '${isPositive ? '+' : ''}${index.changePercent.toStringAsFixed(2)}%',
            style: TextStyle(
              color: isPositive ? Colors.green : Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
