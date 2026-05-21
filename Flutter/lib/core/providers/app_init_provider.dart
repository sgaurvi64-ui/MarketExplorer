import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/notification_service.dart';

final appInitProvider = FutureProvider<void>((ref) async {
  final notificationService = NotificationService();
  await notificationService.initialize();
});
