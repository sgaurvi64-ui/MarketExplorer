import 'package:flutter/material.dart';

class StopLossPage extends StatelessWidget {
  const StopLossPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stopController = TextEditingController();
    final takeProfitController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Stop Loss / Take Profit')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Protect your position',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: stopController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Stop loss price'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: takeProfitController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Take profit price'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Risk orders saved')),
                  );
                },
                child: const Text('Save risk orders'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
