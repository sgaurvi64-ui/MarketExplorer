import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../providers/portfolio_provider.dart';
import '../widgets/allocation_chart.dart';
import '../widgets/holding_card.dart';
import '../widgets/transaction_tile.dart';

class PortfolioPage extends ConsumerWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final holdingsAsync = ref.watch(holdingsProvider);
    final transactionsAsync = ref.watch(transactionsProvider);
    final summaryAsync = ref.watch(portfolioSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            summaryAsync.when(
              data: (summary) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current holdings',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          CurrencyFormatter.format(summary.portfolioValue),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Cash available ${CurrencyFormatter.format(summary.cashBalance)} - P/L ${summary.profitLoss >= 0 ? '+' : ''}${CurrencyFormatter.format(summary.profitLoss)}',
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: AppLoader(message: 'Loading holdings'),
              ),
              error: (error, _) => AppErrorView(message: error.toString()),
            ),
            const SizedBox(height: 16),
            const SectionHeader(title: 'Open positions'),
            const SizedBox(height: 12),
            holdingsAsync.when(
              data: (holdings) {
                if (holdings.isEmpty) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('No holdings yet. Buy a stock from Market to start.'),
                    ),
                  );
                }

                return Column(
                  children: holdings.map((holding) {
                    return HoldingCard(holding: holding);
                  }).toList(),
                );
              },
              loading: () => const AppLoader(message: 'Loading positions'),
              error: (error, _) => AppErrorView(message: error.toString()),
            ),
            const SizedBox(height: 16),
            const SectionHeader(title: 'Allocation'),
            const SizedBox(height: 12),
            holdingsAsync.when(
              data: (holdings) {
                if (holdings.isEmpty) {
                  return const SizedBox.shrink();
                }

                final totalValue = holdings.fold<double>(
                  0,
                  (sum, item) => sum + item.marketValue,
                );
                final sorted = [...holdings]
                  ..sort((a, b) => b.marketValue.compareTo(a.marketValue));
                final topHolding = sorted.first;
                final concentration = totalValue == 0
                    ? 0
                    : (topHolding.marketValue / totalValue) * 100;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AllocationChart(holdings: holdings),
                    const SizedBox(height: 12),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Risk summary',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Top holding: ${topHolding.stock.symbol} (${concentration.toStringAsFixed(1)}% of portfolio)',
                            ),
                            const SizedBox(height: 6),
                            Text(
                              concentration >= 35
                                  ? 'High concentration risk. Consider diversifying.'
                                  : 'Diversification looks healthy.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (error, _) => AppErrorView(message: error.toString()),
            ),
            const SizedBox(height: 16),
            SectionHeader(
              title: 'Transaction history',
              actionLabel: 'View all',
              onActionTap: () => context.push('/transactions'),
            ),
            const SizedBox(height: 12),
            transactionsAsync.when(
              data: (transactions) {
                return Column(
                  children: transactions
                      .take(3)
                      .map((tx) => TransactionTile(transaction: tx))
                      .toList(),
                );
              },
              loading: () => const AppLoader(message: 'Loading transactions'),
              error: (error, _) => AppErrorView(message: error.toString()),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
