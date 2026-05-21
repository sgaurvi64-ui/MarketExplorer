import '../stock/stock_model.dart';

class HoldingModel {
  const HoldingModel({
    required this.stock,
    required this.quantity,
    required this.averagePrice,
  });

  final StockModel stock;
  final int quantity;
  final double averagePrice;

  double get marketValue => quantity * stock.price;
  double get investedValue => quantity * averagePrice;
  double get profitLoss => marketValue - investedValue;

  factory HoldingModel.fromJson(Map<String, dynamic> json) {
    return HoldingModel(
      stock: StockModel(
        symbol: json['symbol'] as String? ?? '',
        companyName: json['company_name'] as String? ?? '',
        price: (json['current_price'] ?? 0).toDouble(),
        change: 0,
        changePercent: 0,
        description: '',
        sector: '',
        dayHigh: 0,
        dayLow: 0,
        volume: 0,
        chartPoints: const [],
      ),
      quantity: json['quantity'] as int? ?? 0,
      averagePrice: (json['average_price'] ?? 0).toDouble(),
    );
  }
}
