import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../../../data/models/portfolio/holding_model.dart';
import '../../../../data/models/portfolio/portfolio_model.dart';
import '../../../../data/models/portfolio/transaction_model.dart';
import '../../../../data/datasources/remote/portfolio_remote_data_source.dart';
import '../../../../data/repositories/portfolio_repository_impl.dart';
import '../../../market/presentation/providers/market_provider.dart';

final portfolioRepositoryProvider = Provider<PortfolioRepositoryImpl>((ref) {
  return PortfolioRepositoryImpl(
    ref.watch(marketRepositoryProvider),
    PortfolioRemoteDataSource(ref.watch(dioProvider)),
  );
});

final cashBalanceProvider = FutureProvider<double>((ref) {
  return ref.watch(portfolioRepositoryProvider).getCashBalance();
});

final holdingsProvider = FutureProvider<List<HoldingModel>>((ref) {
  return ref.watch(portfolioRepositoryProvider).getHoldings();
});

final portfolioSummaryProvider = FutureProvider<PortfolioModel>((ref) {
  return ref.watch(portfolioRepositoryProvider).fetchRemoteSummary();
});

final transactionsProvider = FutureProvider<List<TransactionModel>>((ref) {
  return ref.watch(portfolioRepositoryProvider).getTransactions();
});

class PortfolioActions {
  const PortfolioActions(this.ref);

  final Ref ref;

  Future<void> buy(String symbol, int quantity) async {
    await ref.read(portfolioRepositoryProvider).buyStock(symbol, quantity);
    _refresh();
  }

  Future<void> sell(String symbol, int quantity) async {
    await ref.read(portfolioRepositoryProvider).sellStock(symbol, quantity);
    _refresh();
  }

  void _refresh() {
    ref.invalidate(cashBalanceProvider);
    ref.invalidate(holdingsProvider);
    ref.invalidate(portfolioSummaryProvider);
    ref.invalidate(transactionsProvider);
  }
}

final portfolioActionsProvider = Provider<PortfolioActions>((ref) {
  return PortfolioActions(ref);
});
