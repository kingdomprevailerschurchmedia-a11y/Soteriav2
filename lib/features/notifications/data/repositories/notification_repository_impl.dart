import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import '../../domain/models/app_notification.dart';
import '../../domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({required IMessagingService fcm}) : _fcm = fcm;

  final IMessagingService _fcm;
  static const _kNotificationsKey = 'soteria_notifications';

  @override
  Future<List<AppNotification>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_kNotificationsKey) ?? [];
    return jsonList
        .map((e) => AppNotification.fromJson(json.decode(e)))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<void> saveNotification(AppNotification notification) async {
    final notifications = await getNotifications();

    // Deduplication check
    final dedupeKey = notification.payload['deduplicationKey'];
    if (dedupeKey != null) {
      final exists = notifications.any(
        (n) => n.payload['deduplicationKey'] == dedupeKey,
      );
      if (exists) return;
    }

    notifications.add(notification);
    await _persist(notifications);
  }

  @override
  Future<void> markAsRead(String id) async {
    final notifications = await getNotifications();
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(read: true);
      await _persist(notifications);
    }
  }

  @override
  Future<void> deleteNotification(String id) async {
    final notifications = await getNotifications();
    notifications.removeWhere((n) => n.id == id);
    await _persist(notifications);
  }

  @override
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kNotificationsKey);
  }

  @override
  Future<String?> getFCMToken() => _fcm.getToken();

  @override
  Future<void> deleteFCMToken() => _fcm.instance.deleteToken();

  @override
  Stream<String> get onTokenRefresh => _fcm.instance.onTokenRefresh;

  Future<void> _persist(List<AppNotification> notifications) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = notifications.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(_kNotificationsKey, jsonList);
  }
}
