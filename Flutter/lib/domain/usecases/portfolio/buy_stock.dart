import '../../repositories/portfolio_repository.dart';

class BuyStock {
  const BuyStock(this.repository);

  final PortfolioRepository repository;

  Future<void> call(String symbol, int quantity) {
    return repository.buyStock(symbol, quantity);
  }
}
