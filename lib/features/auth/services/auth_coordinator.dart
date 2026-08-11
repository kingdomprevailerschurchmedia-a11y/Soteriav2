import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import '../domain/use_cases/check_auth_state_use_case.dart';
import '../domain/use_cases/logout_use_case.dart';
import '../../../core/identity/providers/identity_providers.dart';
import '../../../core/identity/models/user_session.dart';
import '../../../core/logging/logger_service.dart';
import '../../player/providers/player_providers.dart';
import '../models/verification_state.dart';
import '../models/verification_type.dart';
import '../providers/verification_notifier.dart';

class AuthCoordinator {
  final Ref _ref;
  final CheckAuthStateUseCase _checkAuth;
  final LogoutUseCase _logout;

  StreamSubscription<String?>? _authSubscription;
  Timer? _verificationTimer;

  AuthCoordinator(this._ref, this._checkAuth, this._logout);

  void startListening() {
    if (_authSubscription != null) {
      LoggerService.d('AuthCoordinator already listening', feature: 'Auth');
      return;
    }

    LoggerService.i('AuthCoordinator starting to listen', feature: 'Auth');
    _authSubscription = _checkAuth.execute().listen((uid) async {
      final currentSession = _ref.read(sessionProvider);

      if (uid == null) {
        if (currentSession.status != SessionStatus.guest) {
          LoggerService.i('User signed out, clearing session', feature: 'Auth');
          // We only call logout if the session isn't already guest
          _ref.read(sessionProvider.notifier).logout();
        }
        _stopVerificationCheck();
      } else {
        if (currentSession.uid != uid || !currentSession.isAuthenticated) {
          LoggerService.i('User authenticated: $uid', feature: 'Auth');
          await _handleAuthenticatedState(uid);
        }
      }
    });
  }

  Future<void> _handleAuthenticatedState(String uid) async {
    final isVerified = await _checkAuth.isEmailVerified();

    if (isVerified) {
      LoggerService.i('Email verified, bootstrapping player', feature: 'Auth');

      try {
        // Trigger Player Bootstrap
        await _ref.read(playerBootstrapStatusProvider.future);
        LoggerService.i('Player bootstrap successful', feature: 'Auth');
      } catch (e, st) {
        // We catch but don't rethrow to avoid blocking the login flow.
        // The Dashboard can handle a missing profile state.
        LoggerService.e(
          'Player bootstrap failed during login - Proceeding with limited session',
          error: e,
          stackTrace: st,
          feature: 'Auth',
        );
      }

      _ref
          .read(sessionProvider.notifier)
          .setSession(
            UserSession(uid: uid, status: SessionStatus.authenticated),
          );
      _stopVerificationCheck();
    } else {
      _ref
          .read(sessionProvider.notifier)
          .setSession(
            UserSession(
              uid: uid,
              status: SessionStatus.guest, // Restrict access
            ),
          );
      _startVerificationCheck();
    }
  }

  void _startVerificationCheck() {
    _verificationTimer?.cancel();
    _verificationTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      final isVerified = await _checkAuth.isEmailVerified();
      if (isVerified) {
        final uid = _checkAuth.currentUserId;
        if (uid != null) {
          // Notify the verification UI if it's active
          _ref
              .read(
                verificationProvider(
                  VerificationType.emailVerification,
                ).notifier,
              )
              .setStep(VerificationStep.success);
          await _handleAuthenticatedState(uid);
        }
      }
    });
  }

  void _stopVerificationCheck() {
    _verificationTimer?.cancel();
    _verificationTimer = null;
  }

  Future<void> signOut() async {
    await _logout.execute();
  }

  void dispose() {
    _authSubscription?.cancel();
    _stopVerificationCheck();
  }
}

final authCoordinatorProvider = Provider<AuthCoordinator>((ref) {
  final coordinator = AuthCoordinator(
    ref,
    ref.watch(checkAuthStateUseCaseProvider),
    ref.watch(logoutUseCaseProvider),
  );

  // Start listening automatically on instantiation
  coordinator.startListening();

  ref.onDispose(coordinator.dispose);
  return coordinator;
});
