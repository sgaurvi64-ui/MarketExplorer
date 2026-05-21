import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/constants/api_constants.dart';
import '../../../auth/presentation/providers/auth_state_provider.dart';
import '../../../home/presentation/providers/home_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backendHealthAsync = ref.watch(backendHealthProvider);
    final userProfileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Scrollbar(
        thumbVisibility: true,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 24, 16), // Extra right padding for scroller
          children: [
            Card(
              child: Column(
                children: [
                  userProfileAsync.when(
                    data: (user) => _SettingsTile(
                      icon: Icons.account_circle_outlined,
                      title: user.username,
                      subtitle: user.email,
                    ),
                    loading: () => const _SettingsTile(
                      icon: Icons.account_circle_outlined,
                      title: 'Loading account',
                      subtitle: 'Fetching profile information',
                    ),
                    error: (error, stackTrace) => const _SettingsTile(
                      icon: Icons.account_circle_outlined,
                      title: 'Demo account',
                      subtitle: 'Profile unavailable',
                    ),
                  ),
                  const Divider(height: 1),
                  const _SettingsTile(
                    icon: Icons.notifications_none,
                    title: 'Alerts',
                    subtitle: 'Notification hooks are ready for later integration',
                  ),
                  const Divider(height: 1),
                  const _SettingsTile(
                    icon: Icons.palette_outlined,
                    title: 'Theme',
                    subtitle: 'Light theme is active for the current build',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  _SettingsNavTile(
                    icon: Icons.newspaper_outlined,
                    title: 'Market news',
                    subtitle: 'Latest market headlines',
                    onTap: () => context.push('/news'),
                  ),
                  const Divider(height: 1),
                _SettingsNavTile(
                  icon: Icons.school_outlined,
                  title: 'Knowledge hub',
                  subtitle: 'Short lessons on trading',
                  onTap: () => context.push('/learning'),
                ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.insights_outlined,
                    title: 'Daily market summary',
                    subtitle: 'Quick wrap of the session',
                    onTap: () => context.push('/market-summary'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle: 'Price alerts and updates',
                    onTap: () => context.push('/notifications'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  _SettingsNavTile(
                    icon: Icons.view_list_outlined,
                    title: 'Order book',
                    subtitle: 'Buy/sell depth view',
                    onTap: () => context.push('/order-book'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.edit_outlined,
                    title: 'Limit order',
                    subtitle: 'Place a price-triggered order',
                    onTap: () => context.push('/limit-order'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.shield_outlined,
                    title: 'Stop loss / take profit',
                    subtitle: 'Risk controls for open trades',
                    onTap: () => context.push('/stop-loss'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.pending_actions_outlined,
                    title: 'Open orders',
                    subtitle: 'Queued and active trades',
                    onTap: () => context.push('/open-orders'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.receipt_long_outlined,
                    title: 'Order preview',
                    subtitle: 'Review before placing',
                    onTap: () => context.push('/order-preview'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.check_circle_outline,
                    title: 'Trade confirmation',
                    subtitle: 'Detailed execution summary',
                    onTap: () => context.push('/trade-confirmation'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  _SettingsNavTile(
                    icon: Icons.help_outline,
                    title: 'Help & support',
                    subtitle: 'Guides and support',
                    onTap: () => context.push('/help'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.question_answer_outlined,
                    title: 'FAQ',
                    subtitle: 'Common questions',
                    onTap: () => context.push('/faq'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.feedback_outlined,
                    title: 'Feedback',
                    subtitle: 'Report an issue or suggestion',
                    onTap: () => context.push('/feedback'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.info_outline,
                    title: 'About app',
                    subtitle: 'App version and disclaimer',
                    onTap: () => context.push('/about'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  _SettingsNavTile(
                    icon: Icons.analytics_outlined,
                    title: 'Portfolio analytics',
                    subtitle: 'Performance and holdings breakdown',
                    onTap: () => context.push('/analytics'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.show_chart_outlined,
                    title: 'Performance timeline',
                    subtitle: 'Returns across timeframes',
                    onTap: () => context.push('/performance'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.shield_outlined,
                    title: 'Risk analysis',
                    subtitle: 'Concentration and volatility insights',
                    onTap: () => context.push('/risk'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.add_alert_outlined,
                    title: 'Price alerts',
                    subtitle: 'Create and track alerts',
                    onTap: () => context.push('/alerts'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.emoji_events_outlined,
                    title: 'Challenges & missions',
                    subtitle: 'Gamified trading goals',
                    onTap: () => context.push('/challenges'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  _SettingsNavTile(
                    icon: Icons.person_outline,
                    title: 'Trader profile',
                    subtitle: 'Public stats and badges',
                    onTap: () => context.push('/profile'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.emoji_events_outlined,
                    title: 'Achievements',
                    subtitle: 'Badges and milestones',
                    onTap: () => context.push('/achievements'),
                  ),
                  const Divider(height: 1),
                  _SettingsNavTile(
                    icon: Icons.local_fire_department_outlined,
                    title: 'Trading streak',
                    subtitle: 'Consistency tracker',
                    onTap: () => context.push('/streaks'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Branding space',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Use this area for app branding, highlights, or premium features.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Environment',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text('API Base URL'),
                    const SizedBox(height: 4),
                    Text(ApiConstants.baseUrl),
                    const SizedBox(height: 12),
                    backendHealthAsync.when(
                      data: (isOnline) => Text(
                        isOnline
                            ? 'Backend status: Connected'
                            : 'Backend status: Fallback mode enabled',
                      ),
                      loading: () => const Text('Backend status: Checking...'),
                      error: (error, stackTrace) =>
                          const Text('Backend status: Unknown'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: () async {
                await ref.read(authControllerProvider.notifier).logout();
                if (!context.mounted) {
                  return;
                }
                context.go('/login');
              },
              child: const Text('Log out'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}

class _SettingsNavTile extends StatelessWidget {
  const _SettingsNavTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
