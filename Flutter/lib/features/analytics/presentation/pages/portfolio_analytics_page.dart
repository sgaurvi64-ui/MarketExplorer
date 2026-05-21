import 'package:flutter/material.dart';
import '../../../../core/utils/currency_formatter.dart';

class PortfolioAnalyticsPage extends StatelessWidget {
  const PortfolioAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Portfolio Analytics')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Performance overview',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text('Total value ${CurrencyFormatter.format(275000)}'),
                  const SizedBox(height: 6),
                  const Text('Return +8.4% • Last 30 days'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const _StatTile(
            title: 'Best performer',
            value: 'TCS +12.6%',
          ),
          const _StatTile(
            title: 'Worst performer',
            value: 'HDFCBANK -3.2%',
          ),
          const _StatTile(
            title: 'Realized P/L',
            value: '₹12,450',
          ),
          const _StatTile(
            title: 'Unrealized P/L',
            value: '₹9,880',
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
