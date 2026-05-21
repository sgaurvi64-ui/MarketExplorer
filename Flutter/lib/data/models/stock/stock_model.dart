class StockModel {
  const StockModel({
    required this.symbol,
    required this.companyName,
    required this.price,
    required this.change,
    required this.changePercent,
    required this.description,
    required this.sector,
    required this.dayHigh,
    required this.dayLow,
    required this.volume,
    required this.chartPoints,
  });

  final String symbol;
  final String companyName;
  final double price;
  final double change;
  final double changePercent;
  final String description;
  final String sector;
  final double dayHigh;
  final double dayLow;
  final int volume;
  final List<double> chartPoints;

  factory StockModel.fromJson(
    Map<String, dynamic> json, {
    List<double> chartPoints = const [],
  }) {
    return StockModel(
      symbol: json['symbol'] as String? ?? '',
      companyName: json['company_name'] as String? ?? '',
      price: (json['current_price'] ?? json['price'] ?? 0).toDouble(),
      change: (json['price_change'] ?? json['change'] ?? 0).toDouble(),
      changePercent:
          (json['change_percent'] ?? json['changePercent'] ?? 0).toDouble(),
      description: json['description'] as String? ?? '',
      sector: json['sector'] as String? ?? '',
      dayHigh: (json['day_high'] ?? json['dayHigh'] ?? 0).toDouble(),
      dayLow: (json['day_low'] ?? json['dayLow'] ?? 0).toDouble(),
      volume: ((json['volume'] ?? 0) as num).toInt(),
      chartPoints: chartPoints,
    );
  }
}
