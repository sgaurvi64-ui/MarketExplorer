import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key, required this.newsId});

  final String newsId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Detail')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Story $newsId',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const Text('Source: Market Desk - Published today'),
          const SizedBox(height: 16),
          const Text(
            'Today\'s market story highlights broad strength across banking and IT, '
            'with steady inflows and improving sentiment ahead of earnings season.',
          ),
          const SizedBox(height: 16),
          const Text(
            'Key takeaways:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('- Broader market sentiment remains positive'),
          const Text('- Sector rotation continues into banks and IT'),
          const Text('- Volatility remains in a healthy range'),
        ],
      ),
    );
  }
}
