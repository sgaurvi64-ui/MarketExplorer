import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';

final backendHealthProvider = FutureProvider<bool>((ref) async {
  final dio = ref.watch(dioProvider);
  try {
    final response = await dio.get('/').timeout(const Duration(seconds: 2));
    return response.statusCode == 200;
  } on DioException {
    return false;
  } catch (_) {
    return false;
  }
});
