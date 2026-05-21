import 'package:dio/dio.dart';
import '../../../app/constants/api_constants.dart';

class LeaderboardRemoteDataSource {
  LeaderboardRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<Map<String, dynamic>>> fetchRankings() async {
    final response = await _dio
        .get('${ApiConstants.leaderboard}/rankings/')
        .timeout(const Duration(seconds: 3));
    return List<Map<String, dynamic>>.from(
      response.data['results'] as List<dynamic>,
    );
  }
}
