import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import '../../../../core/widgets/top_nav_scaffold.dart';

class LearningHubPage extends StatefulWidget {
  const LearningHubPage({super.key});

  @override
  State<LearningHubPage> createState() => _LearningHubPageState();
}

class _LearningHubPageState extends State<LearningHubPage> {
  String _activeChip = 'Knowledge Hub';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TopNavScaffold(
      activeTab: 'knowledgeHub',
      body: Scrollbar(
        thumbVisibility: true,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _ChipFilter(
                    label: 'Lecture',
                    isActive: _activeChip == 'Lecture',
                    onTap: () => setState(() => _activeChip = 'Lecture'),
                  ),
                  const SizedBox(width: 8),
                  _ChipFilter(
                    label: 'Knowledge Hub',
                    isActive: _activeChip == 'Knowledge Hub',
                    onTap: () => setState(() => _activeChip = 'Knowledge Hub'),
                  ),
                  const SizedBox(width: 8),
                  _ChipFilter(
                    label: 'Notes',
                    isActive: _activeChip == 'Notes',
                    onTap: () => setState(() => _activeChip = 'Notes'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (_activeChip == 'Knowledge Hub') ...[
              Text(
                'Educational modules and market insights to improve your paper trading skills.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              const _ModuleCard(
                title: 'Candlesticks 101',
                subtitle: 'Read price action and daily range',
                progress: 0.7,
              ),
              const SizedBox(height: 12),
              const _ModuleCard(
                title: 'Risk basics',
                subtitle: 'Position sizing and stop loss logic',
                progress: 0.35,
              ),
              const SizedBox(height: 12),
              const _ModuleCard(
                title: 'Market news',
                subtitle: 'How macro news affects price',
                progress: 0.15,
              ),
            ] else if (_activeChip == 'Lecture') ...[
              Text(
                'Lecture',
                style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Watch short lessons to improve your trading fundamentals.',
              ),
              const SizedBox(height: 16),
              const _LinkTile(
                title: 'Candlestick basics',
                subtitle: 'https://www.youtube.com/watch?v=eynxyoKgpng',
              ),
              const _LinkTile(
                title: 'Risk management in trading',
                subtitle: 'https://www.youtube.com/watch?v=7Uq6UpQn2fE',
              ),
              const _LinkTile(
                title: 'Support and resistance',
                subtitle: 'https://www.youtube.com/watch?v=0xJ7q7c2u7E',
              ),
            ] else ...[
              Text(
                'Notes',
                style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Quick reminders saved from your learning sessions.',
              ),
              const SizedBox(height: 16),
              const _NoteCard(
                title: 'Position sizing reminder',
                body:
                    'Risk 1-2 percent per trade. Use stop loss to control downside and keep drawdowns shallow.',
              ),
              const SizedBox(height: 12),
              const _NoteCard(
                title: 'Checklist before entry',
                body:
                    'Confirm trend, check volume, set entry and exit, and verify risk-to-reward before buying.',
              ),
              const SizedBox(height: 12),
              const _NoteCard(
                title: 'Weekly review',
                body:
                    'Review top winners and losers, note what worked, and document one improvement for next week.',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChipFilter extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ChipFilter({
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(12),
          color: isActive ? Colors.green.withValues(alpha: 0.12) : Colors.transparent,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.green[800],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.progress,
  });

  final String title;
  final String subtitle;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            Text(subtitle),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: LinearProgressIndicator(value: progress)),
                const SizedBox(width: 12),
                Text('$percent%'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  const _LinkTile({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.ondemand_video_outlined),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}
