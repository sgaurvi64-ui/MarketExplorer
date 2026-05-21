import '../../domain/repositories/market_repository.dart';
import '../datasources/remote/market_remote_data_source.dart';
import '../models/market/market_insight_model.dart';
import '../models/stock/stock_model.dart';

class MarketRepositoryImpl implements MarketRepository {
  const MarketRepositoryImpl(this.remoteDataSource);

  final MarketRemoteDataSource remoteDataSource;

  @override
  Future<StockModel> getStockDetails(String symbol) {
    return remoteDataSource.fetchStockDetails(symbol);
  }

  @override
  Future<List<StockModel>> getStocks() {
    return remoteDataSource.fetchStocks();
  }

  Future<MarketInsightModel> getInsight(String symbol, {String horizon = 'short'}) {
    return remoteDataSource.fetchInsight(symbol, horizon: horizon);
  }
}
