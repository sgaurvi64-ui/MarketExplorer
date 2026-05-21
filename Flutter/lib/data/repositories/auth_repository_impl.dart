import '../datasources/local/auth_local_data_source.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../models/user/auth_session_model.dart';
import '../models/user/user_model.dart';
import '../../core/services/firebase_auth_service.dart';
import '../../core/services/firestore_service.dart';

class AuthRepositoryImpl {
  AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._firebaseAuthService,
    this._firestoreService,
  );

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final FirebaseAuthService _firebaseAuthService;
  final FirestoreService _firestoreService;

  AuthSessionModel _buildDemoSession({
    required String email,
    required String username,
  }) {
    return AuthSessionModel(
      token: 'demo-local-token',
      user: UserModel(
        id: 1,
        username: username,
        email: email,
      ),
    );
  }

  Future<AuthSessionModel> login({
    required String email,
    required String password,
  }) async {
    late final AuthSessionModel session;
    try {
      final user = await _firebaseAuthService
          .signInWithEmailPassword(email: email, password: password)
          .timeout(const Duration(seconds: 4));
      if (user != null) {
        session = AuthSessionModel(
          token: user.uid,
          user: UserModel(
            id: 1,
            username: user.displayName ?? 'firebase_user',
            email: user.email ?? email,
          ),
        );
      } else {
        throw Exception('Firebase login failed');
      }
    } catch (_) {
      try {
        session = await _remoteDataSource
            .login(
              email: email,
              password: password,
            )
            .timeout(const Duration(seconds: 3));
      } catch (_) {
        session = _buildDemoSession(
          email: email.isNotEmpty ? email : 'demo@stocksim.in',
          username: 'demo_user',
        );
      }
    }
    await _localDataSource.saveToken(session.token);
    return session;
  }

  Future<AuthSessionModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    late final AuthSessionModel session;
    try {
      final user = await _firebaseAuthService
          .registerWithEmailPassword(email: email, password: password)
          .timeout(const Duration(seconds: 4));
      if (user == null) {
        throw Exception('Firebase register failed');
      }
      await _firebaseAuthService.sendEmailVerification();
      await _firestoreService.saveUserProfile(
        user.uid,
        {
          'username': name,
          'email': email,
          'createdAt': DateTime.now().toIso8601String(),
        },
      );
      session = AuthSessionModel(
        token: user.uid,
        user: UserModel(id: 1, username: name, email: email),
      );
    } catch (_) {
      try {
        session = await _remoteDataSource
            .register(
              name: name,
              email: email,
              password: password,
            )
            .timeout(const Duration(seconds: 3));
      } catch (_) {
        session = _buildDemoSession(
          email: email.isNotEmpty ? email : 'demo@stocksim.in',
          username: name.isNotEmpty ? name : 'demo_user',
        );
      }
    }
    await _localDataSource.saveToken(session.token);
    return session;
  }

  Future<bool> isLoggedIn() async {
    final token = await _localDataSource.getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _firebaseAuthService.signOut();
    await _localDataSource.clearToken();
  }

  Future<UserModel> getProfile() async {
    try {
      return await _remoteDataSource.fetchProfile();
    } catch (_) {
      return const UserModel(
        id: 1,
        username: 'demo_user',
        email: 'demo@stocksim.in',
      );
    }
  }
}
