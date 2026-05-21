import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firebase_service.dart';

final firebaseInitProvider = FutureProvider<bool>((ref) {
  return FirebaseService.initialize();
});
