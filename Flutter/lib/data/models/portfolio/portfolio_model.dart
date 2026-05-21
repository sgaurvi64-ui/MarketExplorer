import 'holding_model.dart';

class PortfolioModel {
  const PortfolioModel({
    required this.cashBalance,
    required this.portfolioValue,
    required this.profitLoss,
    required this.holdings,
  });

  final double cashBalance;
  final double portfolioValue;
  final double profitLoss;
  final List<HoldingModel> holdings;
}
