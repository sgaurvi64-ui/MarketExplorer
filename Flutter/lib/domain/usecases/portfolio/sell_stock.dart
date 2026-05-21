import '../../repositories/portfolio_repository.dart';

class SellStock {
  const SellStock(this.repository);

  final PortfolioRepository repository;

  Future<void> call(String symbol, int quantity) {
    return repository.sellStock(symbol, quantity);
  }
}
