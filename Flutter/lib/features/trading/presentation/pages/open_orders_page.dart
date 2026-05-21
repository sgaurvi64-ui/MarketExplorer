import 'package:flutter/material.dart';

class OpenOrdersPage extends StatelessWidget {
  const OpenOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Open Orders')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _OrderTile(
            symbol: 'RELIANCE',
            type: 'Limit Buy',
            status: 'Queued',
            detail: 'Price ₹2,930 • Qty 10',
          ),
          _OrderTile(
            symbol: 'TCS',
            type: 'Stop Loss',
            status: 'Active',
            detail: 'Stop ₹4,020 • Qty 4',
          ),
        ],
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({
    required this.symbol,
    required this.type,
    required this.status,
    required this.detail,
  });

  final String symbol;
  final String type;
  final String status;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('$symbol • $type'),
        subtitle: Text(detail),
        trailing: Text(status),
      ),
    );
  }
}
