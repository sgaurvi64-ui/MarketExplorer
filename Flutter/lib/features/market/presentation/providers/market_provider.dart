import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../../../data/repositories/watchlist_repository_impl.dart';
import '../../../../data/datasources/local/watchlist_local_data_source.dart';
import '../../../../data/datasources/remote/market_remote_data_source.dart';
import '../../../../data/datasources/remote/watchlist_remote_data_source.dart';
import '../../../../data/models/market/market_insight_model.dart';
import '../../../../data/models/market/quote_model.dart';
import '../../../../data/models/stock/stock_model.dart';
import '../../../../data/repositories/market_repository_impl.dart';

final marketRemoteDataSourceProvider = Provider<MarketRemoteDataSource>((ref) {
  return MarketRemoteDataSource(ref.watch(dioProvider));
});

final marketRepositoryProvider = Provider<MarketRepositoryImpl>((ref) {
  return MarketRepositoryImpl(ref.watch(marketRemoteDataSourceProvider));
});

final marketStocksProvider = FutureProvider<List<StockModel>>((ref) {
  return ref.watch(marketRepositoryProvider).getStocks();
});

final marketOverviewProvider =
    FutureProvider<({String marketStatus, List<QuoteModel> indices})>((ref) {
  return ref.watch(marketRemoteDataSourceProvider).fetchOverview();
});

final stockDetailsProvider =
    FutureProvider.family<StockModel, String>((ref, symbol) {
  return ref.watch(marketRepositoryProvider).getStockDetails(symbol);
});

final stockInsightProvider =
    FutureProvider.family<MarketInsightModel, String>((ref, symbol) {
  return ref.watch(marketRepositoryProvider).getInsight(symbol, horizon: 'short');
});

final stockInsightLongProvider =
    FutureProvider.family<MarketInsightModel, String>((ref, symbol) {
  return ref.watch(marketRepositoryProvider).getInsight(symbol, horizon: 'long');
});

final watchlistDataSourceProvider = Provider<WatchlistLocalDataSource>((ref) {
  return WatchlistLocalDataSource();
});

final watchlistRemoteDataSourceProvider =
    Provider<WatchlistRemoteDataSource>((ref) {
  return WatchlistRemoteDataSource(ref.watch(dioProvider));
});

final watchlistRepositoryProvider = Provider<WatchlistRepositoryImpl>((ref) {
  return WatchlistRepositoryImpl(
    ref.watch(watchlistDataSourceProvider),
    ref.watch(watchlistRemoteDataSourceProvider),
  );
});

class WatchlistController extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() {
    return ref.watch(watchlistRepositoryProvider).getWatchlist();
  }

  Future<void> toggle(String symbol) async {
    final repository = ref.read(watchlistRepositoryProvider);
    await repository.toggle(symbol);
    state = AsyncData(await repository.getWatchlist());
  }
}

final watchlistProvider =
    AsyncNotifierProvider<WatchlistController, List<String>>(
  WatchlistController.new,
);
