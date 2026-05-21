import 'package:flutter/material.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  static const _badges = [
    {
      'title': 'First Trade',
      'subtitle': 'Completed your first virtual order',
      'progress': 1.0,
    },
    {
      'title': 'Consistent Learner',
      'subtitle': 'Finished 5 learning lessons',
      'progress': 0.6,
    },
    {
      'title': 'Calm Under Pressure',
      'subtitle': 'Held a position for 10 days',
      'progress': 0.3,
    },
    {
      'title': 'Top 10 Percent',
      'subtitle': 'Ranked in top 10 percent this week',
      'progress': 0.1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Achievements')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your badge shelf',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Collect badges to track trading consistency and learning streaks.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ..._badges.map((badge) {
            final progress = badge['progress'] as double;
            final percent = (progress * 100).round();
            return Card(
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 22,
                  backgroundColor: Color(0xFFEFF6F2),
                  child: Icon(Icons.emoji_events_outlined),
                ),
                title: Text(badge['title'] as String),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(badge['subtitle'] as String),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: progress),
                  ],
                ),
                trailing: Text('$percent%'),
              ),
            );
          }),
        ],
      ),
    );
  }
}
