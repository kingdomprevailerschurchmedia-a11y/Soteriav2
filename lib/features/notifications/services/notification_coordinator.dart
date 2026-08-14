import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uuid/uuid.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/logging/logger_service.dart';
import '../domain/models/app_notification.dart';
import '../domain/repositories/notification_repository.dart';

class NotificationCoordinator {
  NotificationCoordinator(this._repository, this._fcm, this._navigation);

  final NotificationRepository _repository;
  final IMessagingService _fcm;
  final NavigationService _navigation;

  StreamSubscription<RemoteMessage>? _foregroundSubscription;
  StreamSubscription<RemoteMessage>? _interactionSubscription;

  Future<void> initialize() async {
    LoggerService.i(
      'Initializing NotificationCoordinator',
      feature: 'Notifications',
    );

    // 1. Request Permissions
    final settings = await _fcm.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    LoggerService.i(
      'Notification settings: ${settings.authorizationStatus}',
      feature: 'Notifications',
    );

    // 2. Register Device
    final token = await _repository.getFCMToken();
    LoggerService.i('FCM Token: $token', feature: 'Notifications');

    // 3. Listen for token refresh
    _repository.onTokenRefresh.listen((token) {
      LoggerService.i('FCM Token refreshed: $token', feature: 'Notifications');
      // TODO: Update backend with new token
    });

    // 4. Handle Foreground Messages
    _foregroundSubscription = FirebaseMessaging.onMessage.listen((message) {
      _handleRemoteMessage(message, isForeground: true);
    });

    // 5. Handle Interactions (Background -> Opened)
    _interactionSubscription = FirebaseMessaging.onMessageOpenedApp.listen((
      message,
    ) {
      _handleInteraction(message);
    });

    // 6. Handle Terminated state launch
    final initialMessage = await _fcm.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleInteraction(initialMessage);
    }
  }

  void _handleRemoteMessage(
    RemoteMessage message, {
    required bool isForeground,
  }) {
    LoggerService.i(
      'Notification received: ${message.notification?.title}',
      feature: 'Notifications',
    );

    final appNotification = AppNotification(
      id: message.messageId ?? const Uuid().v4(),
      title: message.notification?.title ?? 'Notification',
      body: message.notification?.body ?? '',
      type: NotificationType.fromString(message.data['type'] ?? 'announcement'),
      createdAt: DateTime.now(),
      payload: message.data,
      action: message.data['action'],
    );

    _repository.saveNotification(appNotification);

    // If foreground, we might want to show an in-app banner or update UI state
    // but the objective says "Persist notifications locally" which we just did.
  }

  void _handleInteraction(RemoteMessage message) {
    LoggerService.i(
      'Notification interaction: ${message.data['action']}',
      feature: 'Notifications',
    );

    final action = message.data['action'];
    if (action != null) {
      _routeByAction(action, message.data);
    }
  }

  void _routeByAction(String action, Map<String, dynamic> data) {
    switch (action) {
      case 'tournament':
        _navigation.go(SoteriaRoutes.tournaments);
        break;
      case 'practice':
        _navigation.go(SoteriaRoutes.practice);
        break;
      case 'leaderboard':
        _navigation.go(SoteriaRoutes.leaderboard);
        break;
      case 'achievements':
        _navigation.go(SoteriaRoutes.profile);
        break;
      case 'profile':
        _navigation.go(SoteriaRoutes.profile);
        break;
      case 'history':
        _navigation.go(SoteriaRoutes.competitiveHistory);
        break;
      case 'rewards':
        _navigation.go(SoteriaRoutes.wallet);
        break;
      case 'season':
        _navigation.go(SoteriaRoutes.season);
        break;
      case 'events':
        final eventId = data['eventId'];
        if (eventId != null) {
          _navigation.go(
            SoteriaRoutes.competitiveEventDetails.replaceAll(':id', eventId),
          );
        } else {
          _navigation.go(SoteriaRoutes.competitiveEvents);
        }
        break;
      case 'versus':
        _navigation.go(SoteriaRoutes.versus);
        break;
      default:
        _navigation.go(SoteriaRoutes.main);
    }
  }

  void dispose() {
    _foregroundSubscription?.cancel();
    _interactionSubscription?.cancel();
  }
}
