import 'package:flutter/material.dart';

class LimitOrderPage extends StatelessWidget {
  const LimitOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final priceController = TextEditingController();
    final quantityController = TextEditingController(text: '10');

    return Scaffold(
      appBar: AppBar(title: const Text('Limit Order')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Place a limit order',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Limit price'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Limit order queued')),
                  );
                },
                child: const Text('Place limit order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
