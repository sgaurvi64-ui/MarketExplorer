import 'package:flutter/material.dart';
import '../../../../core/widgets/top_nav_scaffold.dart';

class DailyMarketSummaryPage extends StatelessWidget {
  const DailyMarketSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopNavScaffold(
      activeTab: 'dailySummary',
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
                    'Today at a glance',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text('NIFTY closed higher, led by banks and IT.'),
                  const SizedBox(height: 12),
                  const Text('Top sector: Banking'),
                  const Text('Weak sector: FMCG'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const _SummaryTile(
            title: 'Market breadth',
            value: 'Advancers 32 - Decliners 18',
          ),
          const _SummaryTile(
            title: 'Volatility',
            value: 'Moderate, with steady intraday range',
          ),
          const _SummaryTile(
            title: 'Institutional flow',
            value: 'Net positive FII and DII activity',
          ),
        ],
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({required this.title, required this.value});

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
