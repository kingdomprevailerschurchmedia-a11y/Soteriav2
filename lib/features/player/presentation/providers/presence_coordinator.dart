import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/matchmaking/presentation/providers/match_lifecycle_providers.dart';
import 'package:soteria/core/logging/logger_service.dart';
import '../../domain/models/player_presence.dart';
import '../../domain/repositories/presence_repository.dart';
import 'presence_providers.dart';

class PresenceCoordinator extends WidgetsBindingObserver {
  final Ref _ref;
  Timer? _heartbeatTimer;
  bool _isBackgrounded = false;

  PresenceCoordinator(this._ref);

  void initialize() {
    LoggerService.i('PresenceCoordinator initializing', feature: 'Presence');
    WidgetsBinding.instance.addObserver(this);
    _startHeartbeat();
    _listenToMatchState();
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(minutes: 2), (_) {
      _sendHeartbeat();
    });
    _sendHeartbeat(); // Immediate heartbeat
  }

  void _sendHeartbeat() {
    final userId = _ref.read(authRepositoryProvider).currentUserId;
    if (userId == null || _isBackgrounded) return;

    _ref.read(presenceRepositoryProvider).updatePresence(
      userId,
      heartbeatOnly: true,
    );
  }

  void _listenToMatchState() {
    _ref.listen<String?>(activeMatchIdProvider, (prev, next) {
      final userId = _ref.read(authRepositoryProvider).currentUserId;
      if (userId == null) return;

      if (next != null) {
        LoggerService.d('User entered match: $next', feature: 'Presence');
        _ref.read(presenceRepositoryProvider).updatePresence(
          userId,
          status: PresenceStatus.inMatch,
          matchId: next,
        );
      } else {
        LoggerService.d('User left match', feature: 'Presence');
        _ref.read(presenceRepositoryProvider).updatePresence(
          userId,
          status: PresenceStatus.online,
        );
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final userId = _ref.read(authRepositoryProvider).currentUserId;
    if (userId == null) return;

    final repository = _ref.read(presenceRepositoryProvider);
    LoggerService.d('App lifecycle changed: $state', feature: 'Presence');

    switch (state) {
      case AppLifecycleState.resumed:
        _isBackgrounded = false;
        repository.updatePresence(userId, status: PresenceStatus.online);
        _startHeartbeat();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        _isBackgrounded = true;
        repository.updatePresence(userId, status: PresenceStatus.recentlyActive);
        _heartbeatTimer?.cancel();
        break;
      case AppLifecycleState.detached:
        repository.setOffline(userId);
        break;
    }
  }

  void dispose() {
    LoggerService.i('PresenceCoordinator disposing', feature: 'Presence');
    WidgetsBinding.instance.removeObserver(this);
    _heartbeatTimer?.cancel();
    
    final userId = _ref.read(authRepositoryProvider).currentUserId;
    if (userId != null) {
      _ref.read(presenceRepositoryProvider).setOffline(userId);
    }
  }
}

final presenceCoordinatorProvider = Provider<PresenceCoordinator>((ref) {
  final coordinator = PresenceCoordinator(ref);

  // Auto-initialize based on auth state
  final sub = ref.listen(authRepositoryProvider.select((s) => s.currentUserId),
      (prev, next) {
    if (next != null) {
      coordinator.initialize();
    } else {
      coordinator.dispose();
    }
  }, fireImmediately: true);

  ref.onDispose(() {
    sub.close();
    coordinator.dispose();
  });

  return coordinator;
});
