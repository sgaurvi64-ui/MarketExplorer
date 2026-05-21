import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TradeConfirmationPage extends StatelessWidget {
  const TradeConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trade Confirmation')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle, size: 48, color: Colors.green),
            const SizedBox(height: 12),
            Text(
              'Order placed successfully',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            const Card(
              child: ListTile(
                title: Text('RELIANCE - Buy'),
                subtitle: Text('Qty 12 - Market order'),
                trailing: Text('Rs 2,950'),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Order ID: ORD-2026-0410-001'),
            const Text('Estimated fees: Rs 12'),
            const Text('Total value: Rs 35,412'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.go('/portfolio'),
                child: const Text('View portfolio'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
