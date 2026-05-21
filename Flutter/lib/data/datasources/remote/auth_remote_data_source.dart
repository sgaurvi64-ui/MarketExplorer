import 'package:dio/dio.dart';
import '../../../app/constants/api_constants.dart';
import '../../models/user/auth_session_model.dart';
import '../../models/user/user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AuthSessionModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '${ApiConstants.users}/login/',
      data: {
        'email': email,
        'password': password,
      },
    );
    return AuthSessionModel.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }

  Future<AuthSessionModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '${ApiConstants.users}/register/',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    final data = Map<String, dynamic>.from(response.data as Map);
    data['token'] ??= 'demo-token-123';
    return AuthSessionModel.fromJson(data);
  }

  Future<UserModel> fetchProfile() async {
    final response = await _dio.get('${ApiConstants.users}/profile/');
    return UserModel.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }
}
