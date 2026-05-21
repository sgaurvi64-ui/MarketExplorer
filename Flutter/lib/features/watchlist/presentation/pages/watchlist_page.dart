import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../market/presentation/providers/market_provider.dart';
import '../widgets/watchlist_stock_tile.dart';

class WatchlistPage extends ConsumerWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlistAsync = ref.watch(watchlistProvider);
    final stocksAsync = ref.watch(marketStocksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: watchlistAsync.when(
        data: (watchlist) {
          return stocksAsync.when(
            data: (stocks) {
              final watchedStocks = stocks
                  .where((stock) => watchlist.contains(stock.symbol))
                  .toList();

              if (watchedStocks.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.bookmarks_outlined, size: 48),
                        SizedBox(height: 12),
                        Text(
                          'Watchlist is empty',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Add stocks from Market to build a personal shortlist you can revisit quickly.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: watchedStocks.length,
                  itemBuilder: (context, index) {
                    final stock = watchedStocks[index];
                    return WatchlistStockTile(
                      stock: stock,
                      onTap: () => context.push('/market/${stock.symbol}'),
                      onRemove: () {
                        ref.read(watchlistProvider.notifier).toggle(stock.symbol);
                      },
                    );
                  },
                ),
              );
            },
            loading: () => const AppLoader(message: 'Loading stocks'),
            error: (error, _) => AppErrorView(message: error.toString()),
          );
        },
        loading: () => const AppLoader(message: 'Loading watchlist'),
        error: (error, _) => AppErrorView(message: error.toString()),
      ),
    );
  }
}
