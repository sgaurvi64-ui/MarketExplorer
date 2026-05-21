import '../../data/models/portfolio/holding_model.dart';
import '../../data/models/portfolio/transaction_model.dart';

abstract class PortfolioRepository {
  Future<double> getCashBalance();
  Future<List<HoldingModel>> getHoldings();
  Future<List<TransactionModel>> getTransactions();
  Future<void> buyStock(String symbol, int quantity);
  Future<void> sellStock(String symbol, int quantity);
}
