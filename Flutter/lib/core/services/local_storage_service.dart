class LocalStorageService {
  LocalStorageService._();

  static final LocalStorageService instance = LocalStorageService._();

  final Map<String, dynamic> _memory = <String, dynamic>{};

  T? read<T>(String key) => _memory[key] as T?;

  Future<void> write<T>(String key, T value) async {
    _memory[key] = value;
  }

  Future<void> remove(String key) async {
    _memory.remove(key);
  }
}
