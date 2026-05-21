import '../datasources/remote/portfolio_remote_data_source.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../models/portfolio/holding_model.dart';
import '../models/portfolio/portfolio_model.dart';
import '../models/portfolio/transaction_model.dart';
import '../models/stock/stock_model.dart';
import 'market_repository_impl.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  PortfolioRepositoryImpl(this._marketRepository, this._remoteDataSource);

  final MarketRepositoryImpl _marketRepository;
  final PortfolioRemoteDataSource _remoteDataSource;

  double _cashBalance = 25000;
  

  final List<TransactionModel> _transactions = [
    TransactionModel(
      id: 'tx-1',
      symbol: 'RELIANCE',
      companyName: 'Reliance Industries Ltd.',
      type: 'BUY',
      quantity: 15,
      price: 2860.50,
      timestamp: DateTime.now().subtract(const Duration(days: 4)),
    ),
    TransactionModel(
      id: 'tx-2',
      symbol: 'TCS',
      companyName: 'Tata Consultancy Services',
      type: 'BUY',
      quantity: 6,
      price: 3988.00,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  PortfolioModel _buildLocalSummary(List<HoldingModel> holdings) {
    final portfolioValue =
        holdings.fold<double>(0, (sum, item) => sum + item.marketValue);
    final profitLoss =
        holdings.fold<double>(0, (sum, item) => sum + item.profitLoss);
    return PortfolioModel(
      cashBalance: _cashBalance,
      portfolioValue: portfolioValue,
      profitLoss: profitLoss,
      holdings: holdings,
    );
  }

  Future<List<HoldingModel>> _getLocalHoldings() async {
    final stocks = await _marketRepository.getStocks();
    final Map<String, ({int quantity, double totalCost})> summary = {};

    for (final tx in _transactions) {
      final current = summary[tx.symbol] ?? (quantity: 0, totalCost: 0.0);
      final delta = tx.type == 'BUY' ? tx.quantity : -tx.quantity;
      final costDelta = tx.type == 'BUY'
          ? tx.price * tx.quantity
          : -(tx.price * tx.quantity);

      summary[tx.symbol] = (
        quantity: current.quantity + delta,
        totalCost: current.totalCost + costDelta,
      );
    }

    return summary.entries
        .where((entry) => entry.value.quantity > 0)
        .map((entry) {
          final stock = stocks.firstWhere((item) => item.symbol == entry.key);
          return HoldingModel(
            stock: stock,
            quantity: entry.value.quantity,
            averagePrice: entry.value.totalCost / entry.value.quantity,
          );
        })
        .toList();
  }

  Future<PortfolioModel> fetchRemoteSummary() async {
    try {
      final data = await _remoteDataSource.fetchSummary();
      final holdings = List<Map<String, dynamic>>.from(
        data['holdings'] as List<dynamic>? ?? const [],
      ).map(HoldingModel.fromJson).toList();
      return PortfolioModel(
        cashBalance: (data['cash_balance'] ?? _cashBalance).toDouble(),
        portfolioValue: (data['portfolio_value'] ?? 0).toDouble(),
        profitLoss: (data['profit_loss'] ?? 0).toDouble(),
        holdings: holdings,
      );
    } catch (_) {
      final holdings = await _getLocalHoldings();
      return _buildLocalSummary(holdings);
    }
  }

  @override
  Future<void> buyStock(String symbol, int quantity) async {
    try {
      await _remoteDataSource.buy(symbol: symbol, quantity: quantity);
    } catch (_) {}
    final stock = await _marketRepository.getStockDetails(symbol);
    final cost = stock.price * quantity;
    if (cost > _cashBalance) {
      throw Exception('Not enough virtual cash for this order.');
    }

    _cashBalance -= cost;
    _transactions.insert(
      0,
      TransactionModel(
        id: 'tx-${DateTime.now().millisecondsSinceEpoch}',
        symbol: stock.symbol,
        companyName: stock.companyName,
        type: 'BUY',
        quantity: quantity,
        price: stock.price,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Future<double> getCashBalance() async {
    final summary = await fetchRemoteSummary();
    _cashBalance = summary.cashBalance;
    return _cashBalance;
  }

  @override
  Future<List<HoldingModel>> getHoldings() async {
    try {
      final summary = await fetchRemoteSummary();
      if (summary.holdings.isNotEmpty) {
        _cashBalance = summary.cashBalance;
        return summary.holdings;
      }
    } catch (_) {}
    return _getLocalHoldings();
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    try {
      final data = await _remoteDataSource.fetchTransactions();
      return data.map(TransactionModel.fromJson).toList();
    } catch (_) {
      return List.unmodifiable(_transactions);
    }
  }

  @override
  Future<void> sellStock(String symbol, int quantity) async {
    try {
      await _remoteDataSource.sell(symbol: symbol, quantity: quantity);
    } catch (_) {}
    final holdings = await getHoldings();
    final holding = holdings.firstWhere(
      (item) => item.stock.symbol == symbol,
      orElse: () => throw Exception('You do not own this stock yet.'),
    );

    if (quantity > holding.quantity) {
      throw Exception('Sell quantity is greater than holdings.');
    }

    final StockModel stock = await _marketRepository.getStockDetails(symbol);
    final proceeds = stock.price * quantity;
    _cashBalance += proceeds;

    _transactions.insert(
      0,
      TransactionModel(
        id: 'tx-${DateTime.now().millisecondsSinceEpoch}',
        symbol: stock.symbol,
        companyName: stock.companyName,
        type: 'SELL',
        quantity: quantity,
        price: stock.price,
        timestamp: DateTime.now(),
      ),
    );
  }
}
