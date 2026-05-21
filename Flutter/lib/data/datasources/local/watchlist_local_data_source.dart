class WatchlistLocalDataSource {
  final Set<String> _watchlist = {'RELIANCE', 'TCS'};

  Future<List<String>> getWatchlist() async {
    return _watchlist.toList()..sort();
  }

  Future<void> toggle(String symbol) async {
    if (_watchlist.contains(symbol)) {
      _watchlist.remove(symbol);
    } else {
      _watchlist.add(symbol);
    }
  }

  Future<bool> contains(String symbol) async {
    return _watchlist.contains(symbol);
  }
}
