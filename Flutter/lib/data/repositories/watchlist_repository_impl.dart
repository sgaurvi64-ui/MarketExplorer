import '../datasources/local/watchlist_local_data_source.dart';
import '../datasources/remote/watchlist_remote_data_source.dart';

class WatchlistRepositoryImpl {
  WatchlistRepositoryImpl(this._localDataSource, this._remoteDataSource);

  final WatchlistLocalDataSource _localDataSource;
  final WatchlistRemoteDataSource _remoteDataSource;

  Future<List<String>> getWatchlist() async {
    try {
      final remoteItems = await _remoteDataSource.fetchWatchlist();
      for (final symbol in remoteItems) {
        final contains = await _localDataSource.contains(symbol);
        if (!contains) {
          await _localDataSource.toggle(symbol);
        }
      }
    } catch (_) {}
    return _localDataSource.getWatchlist();
  }

  Future<void> toggle(String symbol) async {
    final contains = await _localDataSource.contains(symbol);
    if (contains) {
      try {
        await _remoteDataSource.remove(symbol);
      } catch (_) {}
    } else {
      try {
        await _remoteDataSource.add(symbol);
      } catch (_) {}
    }
    await _localDataSource.toggle(symbol);
  }
}
