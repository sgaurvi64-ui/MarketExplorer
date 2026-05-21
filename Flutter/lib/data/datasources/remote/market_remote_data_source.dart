import 'package:dio/dio.dart';
import '../../../app/constants/api_constants.dart';
import '../../models/market/market_insight_model.dart';
import '../../models/market/quote_model.dart';
import '../../models/stock/stock_model.dart';

class MarketRemoteDataSource {
  MarketRemoteDataSource(this._dio);

  final Dio _dio;

  Future<({String marketStatus, List<QuoteModel> indices})> fetchOverview() async {
    try {
      final response = await _dio
          .get('${ApiConstants.market}/overview/')
          .timeout(const Duration(seconds: 3));
      final indices = List<Map<String, dynamic>>.from(
        response.data['indices'] as List<dynamic>,
      ).map(QuoteModel.fromJson).toList();
      return (
        marketStatus: response.data['market_status'] as String? ?? 'Open',
        indices: indices,
      );
    } catch (_) {
      return (
        marketStatus: 'Open',
        indices: const [
          QuoteModel(
            symbol: 'NIFTY 50',
            price: 22435.75,
            change: 182.10,
            changePercent: 0.82,
          ),
          QuoteModel(
            symbol: 'SENSEX',
            price: 73890.14,
            change: 516.32,
            changePercent: 0.70,
          ),
          QuoteModel(
            symbol: 'BANK NIFTY',
            price: 48240.30,
            change: -126.55,
            changePercent: -0.26,
          ),
        ],
      );
    }
  }

  Future<List<StockModel>> fetchStocks() async {
    try {
      final response = await _dio
          .get('${ApiConstants.market}/stocks/')
          .timeout(const Duration(seconds: 3));
      final results = List<Map<String, dynamic>>.from(
        response.data['results'] as List<dynamic>,
      );
      return results.map(StockModel.fromJson).toList();
    } catch (_) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return _fallbackStocks;
    }
  }

  Future<StockModel> fetchStockDetails(String symbol) async {
    try {
      final response = await _dio
          .get('${ApiConstants.market}/stocks/$symbol/')
          .timeout(const Duration(seconds: 3));
      final chartResponse = await _dio
          .get('${ApiConstants.market}/stocks/$symbol/chart/')
          .timeout(const Duration(seconds: 3));
      final points = List<dynamic>.from(chartResponse.data['points'] as List<dynamic>)
          .map((item) => (item as num).toDouble())
          .toList();
      return StockModel.fromJson(
        Map<String, dynamic>.from(response.data as Map),
        chartPoints: points,
      );
    } catch (_) {
      final stocks = await fetchStocks();
      return stocks.firstWhere((stock) => stock.symbol == symbol);
    }
  }

  Future<MarketInsightModel> fetchInsight(String symbol, {String horizon = 'short'}) async {
    try {
      final response = await _dio
          .get(
            '${ApiConstants.ml}/predict/$symbol/',
            queryParameters: {'horizon': horizon},
          )
          .timeout(const Duration(seconds: 3));
      return MarketInsightModel.fromJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    } catch (_) {
      final normalized = symbol.toUpperCase();
      const fallback = <String, (String prediction, double confidence, double risk)>{
        'RELIANCE': ('UP', 0.76, 0.32),
        'TCS': ('UP', 0.81, 0.28),
        'INFY': ('HOLD', 0.63, 0.44),
        'HDFCBANK': ('UP', 0.71, 0.26),
      };
      final preset = fallback[normalized] ?? ('HOLD', 0.55, 0.40);
      return MarketInsightModel(
        symbol: normalized,
        prediction: preset.$1,
        confidence: preset.$2,
        riskScore: preset.$3,
        source: horizon == 'long' ? 'flutter-fallback-long' : 'flutter-fallback-short',
      );
    }
  }

  static const List<StockModel> _fallbackStocks = [
      StockModel(
        symbol: 'RELIANCE',
        companyName: 'Reliance Industries Ltd.',
        price: 2946.20,
        change: 28.10,
        changePercent: 1.14,
        description: 'Conglomerate spanning energy, telecom, and retail businesses.',
        sector: 'Conglomerate',
        dayHigh: 2968.40,
        dayLow: 2912.10,
        volume: 78421000,
        chartPoints: [2850, 2872, 2898, 2886, 2915, 2931, 2946],
      ),
      StockModel(
        symbol: 'TCS',
        companyName: 'Tata Consultancy Services',
        price: 4128.75,
        change: 46.35,
        changePercent: 1.14,
        description: 'Leading Indian IT services and consulting company.',
        sector: 'Information Technology',
        dayHigh: 4150.00,
        dayLow: 4072.20,
        volume: 65432000,
        chartPoints: [3985, 4012, 4040, 4068, 4095, 4111, 4129],
      ),
      StockModel(
        symbol: 'INFY',
        companyName: 'Infosys Ltd.',
        price: 1518.30,
        change: -12.40,
        changePercent: -0.81,
        description: 'Global IT services and digital transformation company.',
        sector: 'Information Technology',
        dayHigh: 1536.00,
        dayLow: 1508.15,
        volume: 42987000,
        chartPoints: [1562, 1551, 1540, 1534, 1528, 1522, 1518],
      ),
      StockModel(
        symbol: 'HDFCBANK',
        companyName: 'HDFC Bank Ltd.',
        price: 1682.55,
        change: 9.85,
        changePercent: 0.59,
        description: 'Large private sector bank with strong retail and corporate banking presence.',
        sector: 'Banking',
        dayHigh: 1694.20,
        dayLow: 1669.80,
        volume: 38241000,
        chartPoints: [1628, 1641, 1650, 1662, 1670, 1677, 1683],
      ),
    ];
}
