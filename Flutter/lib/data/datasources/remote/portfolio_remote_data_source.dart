import 'package:dio/dio.dart';
import '../../../app/constants/api_constants.dart';

class PortfolioRemoteDataSource {
  PortfolioRemoteDataSource(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> fetchSummary() async {
    final response = await _dio
        .get('${ApiConstants.portfolio}/summary/')
        .timeout(const Duration(seconds: 4));
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<List<Map<String, dynamic>>> fetchTransactions() async {
    final response = await _dio
        .get('${ApiConstants.portfolio}/transactions/')
        .timeout(const Duration(seconds: 4));
    return List<Map<String, dynamic>>.from(
      response.data['results'] as List<dynamic>,
    );
  }

  Future<void> buy({
    required String symbol,
    required int quantity,
  }) async {
    await _dio
        .post(
          '${ApiConstants.portfolio}/buy/',
          data: {'symbol': symbol, 'quantity': quantity},
        )
        .timeout(const Duration(seconds: 4));
  }

  Future<void> sell({
    required String symbol,
    required int quantity,
  }) async {
    await _dio
        .post(
          '${ApiConstants.portfolio}/sell/',
          data: {'symbol': symbol, 'quantity': quantity},
        )
        .timeout(const Duration(seconds: 4));
  }
}
