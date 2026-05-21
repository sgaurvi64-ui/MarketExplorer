import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../../../core/providers/storage_provider.dart';
import '../../../../core/providers/firebase_auth_provider.dart';
import '../../../../core/providers/firestore_provider.dart';
import '../../../../data/datasources/local/auth_local_data_source.dart';
import '../../../../data/datasources/remote/auth_remote_data_source.dart';
import '../../../../data/repositories/auth_repository_impl.dart';

class AuthController extends StateNotifier<bool> {
  AuthController(this._repository) : super(false) {
    _init();
  }

  final AuthRepositoryImpl _repository;

  Future<void> _init() async {
    state = await _repository.isLoggedIn();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _repository.login(email: email, password: password);
    state = true;
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await _repository.register(name: name, email: email, password: password);
    state = true;
  }

  Future<void> logout() async {
    await _repository.logout();
    state = false;
  }
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.watch(dioProvider));
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSource(ref.watch(secureStorageProvider));
});

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(
    ref.watch(authRemoteDataSourceProvider),
    ref.watch(authLocalDataSourceProvider),
    ref.watch(firebaseAuthServiceProvider),
    ref.watch(firestoreServiceProvider),
  );
});

final userProfileProvider = FutureProvider((ref) {
  return ref.watch(authRepositoryProvider).getProfile();
});

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(ref.watch(authRepositoryProvider));
});
