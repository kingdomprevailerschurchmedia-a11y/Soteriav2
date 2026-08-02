import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:soteria/features/notifications/domain/models/app_notification.dart';

@GenerateMocks([IMessagingService])
import 'notification_repository_test.mocks.dart';

void main() {
  late NotificationRepositoryImpl repository;
  late MockIMessagingService mockFCM;

  setUp(() {
    mockFCM = MockIMessagingService();
    repository = NotificationRepositoryImpl(fcm: mockFCM);
    SharedPreferences.setMockInitialValues({});
  });

  group('NotificationRepository', () {
    test('saveNotification should persist notification locally', () async {
      final notification = AppNotification(
        id: '1',
        title: 'Test',
        body: 'Body',
        type: NotificationType.announcement,
        createdAt: DateTime.now(),
      );

      await repository.saveNotification(notification);
      final list = await repository.getNotifications();

      expect(list.length, 1);
      expect(list.first.id, '1');
    });

    test('markAsRead should update read status', () async {
      final notification = AppNotification(
        id: '1',
        title: 'Test',
        body: 'Body',
        type: NotificationType.announcement,
        createdAt: DateTime.now(),
      );

      await repository.saveNotification(notification);
      await repository.markAsRead('1');

      final list = await repository.getNotifications();
      expect(list.first.read, true);
    });
  });
}
