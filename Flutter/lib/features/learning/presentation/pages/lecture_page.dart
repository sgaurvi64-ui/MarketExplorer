import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/top_nav_scaffold.dart';

class LecturePage extends StatelessWidget {
  const LecturePage({super.key});

  static const _lectures = [
    {
      'title': 'Candlestick basics',
      'url': 'https://www.youtube.com/watch?v=eynxyoKgpng',
    },
    {
      'title': 'Risk management in trading',
      'url': 'https://www.youtube.com/watch?v=7Uq6UpQn2fE',
    },
    {
      'title': 'Support and resistance',
      'url': 'https://www.youtube.com/watch?v=0xJ7q7c2u7E',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return TopNavScaffold(
      activeTab: 'knowledgeHub',
      onBack: () => context.go('/learning'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Watch short lessons to improve your trading fundamentals.',
          ),
          const SizedBox(height: 16),
          ..._lectures.map((item) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.ondemand_video_outlined),
                title: Text(item['title']!),
                subtitle: Text(
                  item['url']!,
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
