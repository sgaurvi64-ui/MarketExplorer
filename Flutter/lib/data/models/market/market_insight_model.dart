class MarketInsightModel {
  const MarketInsightModel({
    required this.symbol,
    required this.prediction,
    required this.confidence,
    required this.riskScore,
    required this.source,
  });

  final String symbol;
  final String prediction;
  final double confidence;
  final double riskScore;
  final String source;

  static double _parseDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value) ?? 0;
    }
    return 0;
  }

  factory MarketInsightModel.fromJson(Map<String, dynamic> json) {
    return MarketInsightModel(
      symbol: json['symbol'] as String? ?? '',
      prediction: json['prediction'] as String? ?? 'HOLD',
      confidence: _parseDouble(json['confidence']),
      riskScore: _parseDouble(json['risk_score'] ?? json['riskScore']),
      source: json['source'] as String? ?? 'unknown',
    );
  }
}
