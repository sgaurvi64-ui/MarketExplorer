import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../../../data/datasources/remote/leaderboard_remote_data_source.dart';
import '../../../../data/models/leaderboard/leaderboard_user_model.dart';
import '../../../../data/repositories/leaderboard_repository_impl.dart';

final leaderboardRemoteDataSourceProvider =
    Provider<LeaderboardRemoteDataSource>((ref) {
  return LeaderboardRemoteDataSource(ref.watch(dioProvider));
});

final leaderboardRepositoryProvider = Provider<LeaderboardRepositoryImpl>((ref) {
  return LeaderboardRepositoryImpl(ref.watch(leaderboardRemoteDataSourceProvider));
});

final leaderboardProvider =
    FutureProvider<List<LeaderboardUserModel>>((ref) async {
  return ref.watch(leaderboardRepositoryProvider).getLeaderboard();
});
