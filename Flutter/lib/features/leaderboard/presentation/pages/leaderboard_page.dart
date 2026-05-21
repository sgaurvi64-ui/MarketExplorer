import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../providers/leaderboard_provider.dart';
import '../widgets/leaderboard_tile.dart';

class LeaderboardPage extends ConsumerWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardAsync = ref.watch(leaderboardProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: leaderboardAsync.when(
        data: (users) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly competition',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Weekly rankings compare paper trading performance across Indian market participants.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...users.map((user) => LeaderboardTile(user: user)),
            ],
          );
        },
        loading: () => const AppLoader(message: 'Loading leaderboard'),
        error: (error, _) => AppErrorView(message: error.toString()),
      ),
    );
  }
}
