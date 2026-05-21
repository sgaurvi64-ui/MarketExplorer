import 'package:flutter/material.dart';

class PerformanceTimelinePage extends StatelessWidget {
  const PerformanceTimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Performance Timeline')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Row(
            children: [
              _RangeChip(label: '1D', selected: false),
              _RangeChip(label: '1W', selected: false),
              _RangeChip(label: '1M', selected: true),
              _RangeChip(label: '1Y', selected: false),
            ],
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Portfolio curve'),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 160,
                    child: Center(
                      child: Text('Chart area ready for data'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          _StatTile(title: 'Net return', value: '+6.2%'),
          _StatTile(title: 'Max drawdown', value: '-3.1%'),
        ],
      ),
    );
  }
}

class _RangeChip extends StatelessWidget {
  const _RangeChip({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) {},
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
