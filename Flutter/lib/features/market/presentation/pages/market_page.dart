import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/stock_list_tile.dart';
import '../providers/market_provider.dart';
import '../widgets/stock_card.dart';

class MarketPage extends ConsumerStatefulWidget {
  const MarketPage({super.key});

  @override
  ConsumerState<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends ConsumerState<MarketPage> {
  String _query = '';
  String _selectedSector = 'All';
  String _selectedTab = 'All';

  @override
  Widget build(BuildContext context) {
    final stocksAsync = ref.watch(marketStocksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              onChanged: (value) => setState(() => _query = value.trim()),
              decoration: const InputDecoration(
                hintText: 'Search stocks or companies',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: stocksAsync.when(
              data: (stocks) {
                final sectors = [
                  'All',
                  ...{
                    for (final stock in stocks)
                      if (stock.sector.trim().isNotEmpty) stock.sector.trim(),
                  }.toList()
                    ..sort(),
                ];

                final filtered = stocks.where((stock) {
                  final query = _query.toLowerCase();
                  final matchesQuery = stock.symbol.toLowerCase().contains(query) ||
                      stock.companyName.toLowerCase().contains(query);
                  final matchesSector =
                      _selectedSector == 'All' || stock.sector == _selectedSector;

                  if (!matchesQuery || !matchesSector) {
                    return false;
                  }

                  if (_selectedTab == 'Gainers') {
                    return stock.changePercent > 0;
                  }
                  if (_selectedTab == 'Losers') {
                    return stock.changePercent < 0;
                  }
                  return true;
                }).toList();

                final topGainers = [...stocks]
                  ..sort((a, b) => b.changePercent.compareTo(a.changePercent));
                final topLosers = [...stocks]
                  ..sort((a, b) => a.changePercent.compareTo(b.changePercent));

                return Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      const SizedBox(height: 8),
                      _FilterTabs(
                        selected: _selectedTab,
                        onSelected: (value) => setState(() => _selectedTab = value),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: sectors.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final sector = sectors[index];
                            final isSelected = sector == _selectedSector;
                            return ChoiceChip(
                              label: Text(sector),
                              selected: isSelected,
                              onSelected: (_) =>
                                  setState(() => _selectedSector = sector),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: StockCard(
                              stock: topGainers.first,
                              onTap: () =>
                                  context.push('/market/${topGainers.first.symbol}'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StockCard(
                              stock: topLosers.first,
                              onTap: () =>
                                  context.push('/market/${topLosers.first.symbol}'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'All stocks',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      ...filtered.map((stock) {
                        return StockListTile(
                          stock: stock,
                          onTap: () => context.push('/market/${stock.symbol}'),
                        );
                      }),
                      const SizedBox(height: 24),
                    ],
                  ),
                );
              },
              loading: () => const AppLoader(message: 'Loading market'),
              error: (error, _) => AppErrorView(message: error.toString()),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterTabs extends StatelessWidget {
  const _FilterTabs({
    required this.selected,
    required this.onSelected,
  });

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    const options = ['All', 'Gainers', 'Losers'];
    return Row(
      children: options.map((option) {
        final isActive = option == selected;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilledButton.tonal(
              onPressed: () => onSelected(option),
              style: FilledButton.styleFrom(
                backgroundColor: isActive ? null : const Color(0xFFF0F4F8),
              ),
              child: Text(option),
            ),
          ),
        );
      }).toList(),
    );
  }
}
