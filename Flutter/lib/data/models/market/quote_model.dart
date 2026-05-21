class QuoteModel {
  const QuoteModel({
    required this.symbol,
    required this.price,
    required this.change,
    required this.changePercent,
  });

  final String symbol;
  final double price;
  final double change;
  final double changePercent;

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      symbol: json['symbol'] as String? ?? '',
      price: (json['price'] ?? 0).toDouble(),
      change: (json['change'] ?? 0).toDouble(),
      changePercent: (json['change_percent'] ?? 0).toDouble(),
    );
  }
}
