import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/stock_list_tile.dart';
import '../../../../core/widgets/top_nav_scaffold.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../auth/presentation/providers/auth_state_provider.dart';
import '../providers/home_provider.dart';
import '../widgets/market_index_card.dart';
import '../widgets/portfolio_summary_card.dart';
import '../../../market/presentation/providers/market_provider.dart';
import '../../../portfolio/presentation/providers/portfolio_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocksAsync = ref.watch(marketStocksProvider);
    final holdingsAsync = ref.watch(holdingsProvider);
    final cashAsync = ref.watch(cashBalanceProvider);
    final backendHealthAsync = ref.watch(backendHealthProvider);
    final userProfileAsync = ref.watch(userProfileProvider);
    final marketOverviewAsync = ref.watch(marketOverviewProvider);
    final theme = Theme.of(context);

    return TopNavScaffold(
      activeTab: 'forYou',
      body: Scrollbar(
        thumbVisibility: true,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFF11212D), Color(0xFF253745)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 20,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: cashAsync.when(
                data: (cash) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      backendHealthAsync.when(
                        data: (isOnline) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 10,
                              color: isOnline ? Colors.greenAccent : Colors.orangeAccent,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isOnline ? 'Backend connected' : 'Using fallback data',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        loading: () => const SizedBox.shrink(),
                        error: (error, stackTrace) => const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        userProfileAsync.maybeWhen(
                          data: (user) => 'Welcome, ${user.username}',
                          orElse: () => 'Virtual balance',
                        ),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        CurrencyFormatter.format(cash),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Track your virtual capital, portfolio growth, and backend sync from one dashboard.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  );
                },
                loading: () => const AppLoader(message: 'Loading balance'),
                error: (error, _) => AppErrorView(message: error.toString()),
              ),
            ),
            const SizedBox(height: 16),
            SectionHeader(
              title: 'Indian market overview',
              actionLabel: marketOverviewAsync.maybeWhen(
                data: (overview) => overview.marketStatus,
                orElse: () => null,
              ),
            ),
            const SizedBox(height: 12),
            marketOverviewAsync.when(
              data: (overview) {
                return SizedBox(
                  height: 132,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: overview.indices.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return MarketIndexCard(index: overview.indices[index]);
                    },
                  ),
                );
              },
              loading: () => const AppLoader(message: 'Loading market overview'),
              error: (error, _) => AppErrorView(message: error.toString()),
            ),
            const SizedBox(height: 16),
            holdingsAsync.when(
              data: (holdings) {
                final invested = holdings.fold<double>(
                  0,
                  (total, item) => total + item.marketValue,
                );
                final profitLoss = holdings.fold<double>(
                  0,
                  (total, item) => total + item.profitLoss,
                );
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _StatBlock(
                                label: 'Invested',
                                value: CurrencyFormatter.format(invested),
                              ),
                            ),
                            Expanded(
                              child: _StatBlock(
                                label: 'P/L',
                                value:
                                    '${profitLoss >= 0 ? '+' : ''}${CurrencyFormatter.format(profitLoss)}',
                                valueColor:
                                    profitLoss >= 0 ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        cashAsync.when(
                          data: (cash) => PortfolioSummaryCard(
                            cashBalance: cash,
                            profitLoss: profitLoss,
                          ),
                          loading: () => const SizedBox.shrink(),
                          error: (error, stackTrace) =>
                              const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: AppLoader(message: 'Loading portfolio snapshot'),
              ),
              error: (error, _) => AppErrorView(message: error.toString()),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.emoji_events_outlined),
                title: const Text('Leaderboard'),
                subtitle: const Text('See top traders and your weekly rank'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/leaderboard'),
              ),
            ),
            const SizedBox(height: 16),
            SectionHeader(
              title: 'Trending stocks',
              actionLabel: 'See all',
              onActionTap: () => context.go('/market'),
            ),
            const SizedBox(height: 12),
            stocksAsync.when(
              data: (stocks) {
                return Column(
                  children: stocks.take(3).map((stock) {
                    return StockListTile(
                      stock: stock,
                      onTap: () => context.push('/market/${stock.symbol}'),
                    );
                  }).toList(),
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: AppLoader(message: 'Loading stocks'),
              ),
              error: (error, _) => AppErrorView(message: error.toString()),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  const _StatBlock({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
        ),
      ],
    );
  }
}
