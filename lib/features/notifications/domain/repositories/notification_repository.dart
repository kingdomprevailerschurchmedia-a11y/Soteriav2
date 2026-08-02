import '../models/app_notification.dart';

abstract interface class NotificationRepository {
  Future<List<AppNotification>> getNotifications();
  Future<void> saveNotification(AppNotification notification);
  Future<void> markAsRead(String id);
  Future<void> deleteNotification(String id);
  Future<void> clearAll();

  Future<String?> getFCMToken();
  Future<void> deleteFCMToken();
  Stream<String> get onTokenRefresh;
}
