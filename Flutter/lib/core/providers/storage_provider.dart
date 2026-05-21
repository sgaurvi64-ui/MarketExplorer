import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/local_storage_service.dart';
import '../services/secure_storage_service.dart';

final localStorageProvider = Provider((ref) => LocalStorageService.instance);
final secureStorageProvider = Provider((ref) => SecureStorageService.instance);
