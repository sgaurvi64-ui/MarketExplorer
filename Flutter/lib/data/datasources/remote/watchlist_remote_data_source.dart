import 'package:dio/dio.dart';
import '../../../app/constants/api_constants.dart';

class WatchlistRemoteDataSource {
  WatchlistRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<String>> fetchWatchlist() async {
    final response = await _dio
        .get('${ApiConstants.watchlist}/items/')
        .timeout(const Duration(seconds: 4));
    final results = List<Map<String, dynamic>>.from(
      response.data['results'] as List<dynamic>,
    );
    return results.map((item) => item['symbol'] as String? ?? '').toList();
  }

  Future<void> add(String symbol) async {
    await _dio
        .post(
          '${ApiConstants.watchlist}/add/',
          data: {'symbol': symbol},
        )
        .timeout(const Duration(seconds: 4));
  }

  Future<void> remove(String symbol) async {
    await _dio
        .post(
          '${ApiConstants.watchlist}/remove/',
          data: {'symbol': symbol},
        )
        .timeout(const Duration(seconds: 4));
  }
}
