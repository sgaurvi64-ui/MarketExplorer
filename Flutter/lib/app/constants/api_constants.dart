import 'package:flutter/foundation.dart';

class ApiConstants {
  static const _overrideBaseUrl = String.fromEnvironment('API_BASE_URL');

  static String get baseUrl {
    if (_overrideBaseUrl.isNotEmpty) {
      return _overrideBaseUrl;
    }

    if (kIsWeb) {
      return 'http://127.0.0.1:8000/api';
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8000/api';
    }

    return 'http://127.0.0.1:8000/api';
  }

  static const users = '/users';
  static const market = '/market';
  static const portfolio = '/portfolio';
  static const watchlist = '/watchlist';
  static const leaderboard = '/leaderboard';
  static const ml = '/ml';
}
