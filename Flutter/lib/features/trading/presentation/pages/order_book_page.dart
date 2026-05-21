import 'package:flutter/material.dart';
import '../../../../core/widgets/top_nav_scaffold.dart';

class OrderBookPage extends StatelessWidget {
  const OrderBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bids = List.generate(6, (i) => 2840.0 + (i * 2));
    final asks = List.generate(6, (i) => 2852.0 + (i * 2));

    return TopNavScaffold(
      activeTab: 'orderBook',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: _OrderColumn(
                title: 'Buy Orders',
                color: Colors.green,
                levels: bids,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _OrderColumn(
                title: 'Sell Orders',
                color: Colors.red,
                levels: asks,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderColumn extends StatelessWidget {
  const _OrderColumn({
    required this.title,
    required this.color,
    required this.levels,
  });

  final String title;
  final Color color;
  final List<double> levels;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...levels.map((price) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price.toStringAsFixed(2),
                      style: TextStyle(color: color),
                    ),
                    Text('${(price % 9) + 12} lots'),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
