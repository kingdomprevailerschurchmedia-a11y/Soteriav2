import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/app_notification.dart';
import '../providers/notification_providers.dart';
import '../screens/notification_center_screen.dart';
import '../widgets/notification_banner.dart';

class NotificationPreviewWrapper extends StatelessWidget {
  final List<AppNotification> notifications;
  final bool isLoading;

  const NotificationPreviewWrapper({
    super.key,
    required this.notifications,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        notificationListProvider.overrideWith(
          () => MockNotificationNotifier(notifications, isLoading),
        ),
      ],
      child: const NotificationCenterScreen(),
    );
  }
}

class MockNotificationNotifier extends NotificationListNotifier {
  final List<AppNotification> _mockNotifications;
  final bool _isLoading;

  MockNotificationNotifier(this._mockNotifications, this._isLoading);

  @override
  AsyncValue<List<AppNotification>> build() {
    return _isLoading
        ? const AsyncValue.loading()
        : AsyncValue.data(_mockNotifications);
  }
}

class NotificationPreviews {
  static List<AppNotification> mockNotifications() {
    final now = DateTime.now();
    return [
      AppNotification(
        id: '1',
        title: 'Promotion Achieved',
        body: 'You are now Diamond II.',
        type: NotificationType.promotion,
        createdAt: now.subtract(const Duration(minutes: 5)),
        read: false,
        action: 'profile',
      ),
      AppNotification(
        id: '2',
        title: 'Reward Received',
        body: 'You earned 500 XP.',
        type: NotificationType.rewardReceived,
        createdAt: now.subtract(const Duration(hours: 2)),
        read: true,
        action: 'rewards',
      ),
      AppNotification(
        id: '3',
        title: 'Achievement Unlocked',
        body: 'You completed a competitive milestone!',
        type: NotificationType.milestoneReached,
        createdAt: now.subtract(const Duration(days: 1)),
        read: true,
        action: 'achievements',
      ),
      AppNotification(
        id: '4',
        title: 'Season Ending Soon',
        body: 'Only 12 hours left in Season 5!',
        type: NotificationType.seasonEnding,
        createdAt: now.subtract(const Duration(days: 1, hours: 4)),
        read: false,
        action: 'history',
      ),
    ];
  }

  static Widget center() =>
      NotificationPreviewWrapper(notifications: mockNotifications());

  static Widget empty() => const NotificationPreviewWrapper(notifications: []);

  static Widget loading() =>
      const NotificationPreviewWrapper(notifications: [], isLoading: true);

  static Widget banner() {
    return Scaffold(
      body: Center(
        child: NotificationBanner(
          title: 'Achievement Unlocked',
          body: 'Diamond Soul milestone completed!',
          onDismiss: () {},
        ),
      ),
    );
  }
}
