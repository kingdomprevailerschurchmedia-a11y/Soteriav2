import 'dart:async';
import '../config/firebase_config.dart';
import 'firebase_initializer.dart';
import '../../logging/logger_service.dart';
import '../exceptions/firebase_exceptions.dart';

import '../security/services/security_coordinator.dart';

enum BootstrapperStatus { initial, initializing, success, failure }

class FirebaseBootstrapper {
  static final FirebaseBootstrapper _instance = FirebaseBootstrapper._();
  FirebaseBootstrapper._();
  factory FirebaseBootstrapper() => _instance;

  BootstrapperStatus _status = BootstrapperStatus.initial;
  BootstrapperStatus get status => _status;

  Object? _error;
  Object? get error => _error;

  Future<void> init(SecurityCoordinator securityCoordinator) async {
    if (_status == BootstrapperStatus.initializing ||
        _status == BootstrapperStatus.success)
      return;

    _status = BootstrapperStatus.initializing;
    final config = FirebaseConfig.fromEnvironment();

    try {
      // 1. Initialize Core with a timeout to prevent hanging the entire app
      LoggerService.i('Firebase Bootstrap: Initializing Core...', feature: 'Firebase');
      await FirebaseInitializer.initializeCore(config).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw TimeoutException('Firebase Core initialization timed out'),
      );

      // 2. Essential initialization only
      LoggerService.i('Firebase Bootstrap: Initializing Crashlytics...', feature: 'Firebase');
      await FirebaseInitializer.initializeCrashlytics().timeout(
        const Duration(seconds: 5),
        onTimeout: () => LoggerService.w('Crashlytics initialization timed out, continuing...', feature: 'Firebase'),
      );

      // 3. Defer non-critical services (don't await them here)
      LoggerService.i('Firebase Bootstrap: Initializing background services...', feature: 'Firebase');
      unawaited(FirebaseInitializer.initializeAppCheck(securityCoordinator));
      unawaited(FirebaseInitializer.initializeGoogleSignIn());
      unawaited(FirebaseInitializer.initializeAnalytics());
      unawaited(FirebaseInitializer.initializePerformance());
      unawaited(FirebaseInitializer.configureFirestoreOffline());

      _status = BootstrapperStatus.success;
      LoggerService.i('Firebase Bootstrap successful. Project: ${FirebaseInitializer.getProjectId()}', feature: 'Firebase');
    } catch (e, st) {
      _status = BootstrapperStatus.failure;
      _error = e;
      LoggerService.e('Firebase Bootstrap failed', error: e, stackTrace: st);
      throw FirebaseExceptionMapper.map(e);
    }
  }

  void reset() {
    _status = BootstrapperStatus.initial;
    _error = null;
  }
}
