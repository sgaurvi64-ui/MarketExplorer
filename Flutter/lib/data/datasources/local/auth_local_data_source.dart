import '../../../app/constants/storage_keys.dart';
import '../../../core/services/secure_storage_service.dart';

class AuthLocalDataSource {
  AuthLocalDataSource(this._secureStorageService);

  final SecureStorageService _secureStorageService;

  Future<void> saveToken(String token) {
    return _secureStorageService.write(StorageKeys.authToken, token);
  }

  Future<String?> getToken() {
    return _secureStorageService.read(StorageKeys.authToken);
  }

  Future<void> clearToken() {
    return _secureStorageService.delete(StorageKeys.authToken);
  }
}
