import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  static final List<Map<String, String>> _faqs = [
    {
      'q': 'Is this real trading?',
      'a': 'No. This is a paper trading simulator with virtual money.',
    },
    {
      'q': 'How accurate are ML insights?',
      'a': 'Insights are probabilistic and for learning only.',
    },
    {
      'q': 'Can I reset my portfolio?',
      'a': 'Yes, reset can be added from settings in future versions.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQ')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _faqs.map((item) {
          return Card(
            child: ExpansionTile(
              title: Text(item['q'] ?? ''),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(item['a'] ?? ''),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
