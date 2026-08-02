import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import '../domain/models/app_notification.dart';
import '../domain/repositories/notification_repository.dart';
import '../data/repositories/notification_repository_impl.dart';
import '../services/notification_coordinator.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(fcm: ref.watch(fcmServiceProvider));
});

final notificationCoordinatorProvider = Provider<NotificationCoordinator>((
  ref,
) {
  final coordinator = NotificationCoordinator(
    ref.watch(notificationRepositoryProvider),
    ref.watch(fcmServiceProvider),
    ref.watch(navigationServiceProvider),
  );

  ref.onDispose(coordinator.dispose);
  return coordinator;
});

class NotificationListNotifier
    extends Notifier<AsyncValue<List<AppNotification>>> {
  @override
  AsyncValue<List<AppNotification>> build() {
    _load();
    return const AsyncValue.loading();
  }

  Future<void> _load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(notificationRepositoryProvider).getNotifications(),
    );
  }

  Future<void> markAsRead(String id) async {
    await ref.read(notificationRepositoryProvider).markAsRead(id);
    _load();
  }

  Future<void> delete(String id) async {
    await ref.read(notificationRepositoryProvider).deleteNotification(id);
    _load();
  }

  Future<void> clearAll() async {
    await ref.read(notificationRepositoryProvider).clearAll();
    _load();
  }
}

final notificationListProvider =
    NotifierProvider<
      NotificationListNotifier,
      AsyncValue<List<AppNotification>>
    >(NotificationListNotifier.new);

final unreadCountProvider = Provider<int>((ref) {
  final notifications = ref.watch(notificationListProvider).value ?? [];
  return notifications.where((n) => !n.read).length;
});
