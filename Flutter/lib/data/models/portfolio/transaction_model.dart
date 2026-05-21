class TransactionModel {
  const TransactionModel({
    required this.id,
    required this.symbol,
    required this.companyName,
    required this.type,
    required this.quantity,
    required this.price,
    required this.timestamp,
  });

  final String id;
  final String symbol;
  final String companyName;
  final String type;
  final int quantity;
  final double price;
  final DateTime timestamp;

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'].toString(),
      symbol: json['symbol'] as String? ?? '',
      companyName: json['company_name'] as String? ?? '',
      type: json['order_type'] as String? ?? json['type'] as String? ?? 'BUY',
      quantity: json['quantity'] as int? ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      timestamp: DateTime.tryParse(
            json['executed_at'] as String? ?? json['timestamp'] as String? ?? '',
          ) ??
          DateTime.now(),
    );
  }
}
