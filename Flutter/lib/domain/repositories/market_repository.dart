import '../../data/models/stock/stock_model.dart';

abstract class MarketRepository {
  Future<List<StockModel>> getStocks();
  Future<StockModel> getStockDetails(String symbol);
}
