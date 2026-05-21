import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Price Alerts')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _AlertTile(
            symbol: 'RELIANCE',
            condition: 'Above 2,950',
            status: 'Active',
          ),
          _AlertTile(
            symbol: 'TCS',
            condition: 'Below 4,050',
            status: 'Paused',
          ),
          _AlertTile(
            symbol: 'HDFCBANK',
            condition: 'Below 1,650',
            status: 'Active',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Alert creation flow will be wired next.'),
            ),
          );
        },
        child: const Icon(Icons.add_alert),
      ),
    );
  }
}

class _AlertTile extends StatelessWidget {
  const _AlertTile({
    required this.symbol,
    required this.condition,
    required this.status,
  });

  final String symbol;
  final String condition;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.notifications_active_outlined),
        title: Text('$symbol - $condition'),
        subtitle: Text('Status: $status'),
        trailing: Switch(
          value: status == 'Active',
          onChanged: (_) {},
        ),
      ),
    );
  }
}
