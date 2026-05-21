import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderPreviewPage extends StatelessWidget {
  const OrderPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Preview')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preview your order',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            const Card(
              child: ListTile(
                title: Text('RELIANCE - Buy'),
                subtitle: Text('Qty 12 - Market order'),
                trailing: Text('Rs 2,950'),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Estimated fees: Rs 12'),
            const Text('Estimated total: Rs 35,412'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.push('/trade-confirmation'),
                child: const Text('Confirm order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
