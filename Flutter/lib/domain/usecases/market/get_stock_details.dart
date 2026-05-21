import '../../../data/models/stock/stock_model.dart';
import '../../repositories/market_repository.dart';

class GetStockDetails {
  const GetStockDetails(this.repository);

  final MarketRepository repository;

  Future<StockModel> call(String symbol) {
    return repository.getStockDetails(symbol);
  }
}
