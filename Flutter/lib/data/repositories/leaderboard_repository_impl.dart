import '../datasources/remote/leaderboard_remote_data_source.dart';
import '../models/leaderboard/leaderboard_user_model.dart';

class LeaderboardRepositoryImpl {
  LeaderboardRepositoryImpl(this._remoteDataSource);

  final LeaderboardRemoteDataSource _remoteDataSource;

  Future<List<LeaderboardUserModel>> getLeaderboard() async {
    try {
      final results = await _remoteDataSource.fetchRankings();
      return results.map(LeaderboardUserModel.fromJson).toList();
    } catch (_) {
      return const [
        LeaderboardUserModel(
          rank: 1,
          name: 'Aarav Capital',
          totalValue: 38940.12,
          returnsPercent: 24.2,
          isCurrentUser: false,
        ),
        LeaderboardUserModel(
          rank: 2,
          name: 'Market Maven',
          totalValue: 36210.44,
          returnsPercent: 18.8,
          isCurrentUser: false,
        ),
        LeaderboardUserModel(
          rank: 3,
          name: 'Demo User',
          totalValue: 31880.18,
          returnsPercent: 12.6,
          isCurrentUser: true,
        ),
      ];
    }
  }
}
