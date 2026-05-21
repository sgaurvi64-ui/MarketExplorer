import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/top_nav_scaffold.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  static const _notes = [
    {
      'title': 'Position sizing reminder',
      'body':
          'Risk 1-2 percent per trade. Use stop loss to control downside and keep drawdowns shallow.',
    },
    {
      'title': 'Checklist before entry',
      'body':
          'Confirm trend, check volume, set entry and exit, and verify risk-to-reward before buying.',
    },
    {
      'title': 'Weekly review',
      'body':
          'Review top winners and losers, note what worked, and document one improvement for next week.',
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
            'Quick reminders saved from your learning sessions.',
          ),
          const SizedBox(height: 16),
          ..._notes.map((note) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note['title']!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(note['body']!),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
