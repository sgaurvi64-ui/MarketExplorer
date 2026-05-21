import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static Future<bool> initialize() async {
    if (Firebase.apps.isNotEmpty) {
      return true;
    }

    // This repository currently ships clear Firebase config only for
    // Android/iOS. On unsupported or partially configured targets,
    // fail fast instead of hanging app startup.
    if (!kIsWeb &&
        defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS &&
        defaultTargetPlatform != TargetPlatform.macOS) {
      return false;
    }

    try {
      await Firebase.initializeApp().timeout(const Duration(seconds: 5));
      return true;
    } catch (_) {
      return false;
    }
  }
}
