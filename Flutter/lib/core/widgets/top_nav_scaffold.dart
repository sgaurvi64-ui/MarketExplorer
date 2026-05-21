import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';

class TopNavScaffold extends StatelessWidget {
  const TopNavScaffold({
    super.key,
    required this.activeTab,
    required this.body,
    this.onBack,
  });

  final String activeTab;
  final Widget body;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56,
        leading: onBack == null
            ? Center(
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
                  child: Icon(Icons.show_chart, color: theme.colorScheme.primary),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBack,
              ),
        title: SizedBox(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search stocks...',
              prefixIcon: const Icon(Icons.search, size: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: theme.colorScheme.surface,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30),
            onPressed: () => context.push('/profile'),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(54),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Row(
              children: [
                _TopNavTab(
                  label: 'For you',
                  isActive: activeTab == 'forYou',
                  onTap: () => context.go('/home'),
                ),
                const SizedBox(width: 8),
                _TopNavTab(
                  label: 'Market news',
                  isActive: activeTab == 'marketNews',
                  onTap: () => context.go('/news'),
                ),
                const SizedBox(width: 8),
                _TopNavTab(
                  label: 'Knowledge hub',
                  isActive: activeTab == 'knowledgeHub',
                  onTap: () => context.go('/learning'),
                ),
                const SizedBox(width: 8),
                _TopNavTab(
                  label: 'Daily summary',
                  isActive: activeTab == 'dailySummary',
                  onTap: () => context.go('/market-summary'),
                ),
                const SizedBox(width: 8),
                _TopNavTab(
                  label: 'Order book',
                  isActive: activeTab == 'orderBook',
                  onTap: () => context.go('/order-book'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: body,
    );
  }
}

class _TopNavTab extends StatelessWidget {
  const _TopNavTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : Colors.grey[600];
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
