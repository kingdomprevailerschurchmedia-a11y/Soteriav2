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
      // 1. Initialize Core (Redundant if done in main, but safe)
      await FirebaseInitializer.initializeCore(config);

      // 2. Parallelize essential services
      await Future.wait([
        FirebaseInitializer.initializeCrashlytics(),
        FirebaseInitializer.initializeAppCheck(securityCoordinator),
      ]);

      // 3. Essential initialization that must be awaited for plugin stability
      await FirebaseInitializer.initializeGoogleSignIn();

      // 4. Defer non-critical services (don't await them here)
      unawaited(FirebaseInitializer.initializeAnalytics());
      unawaited(FirebaseInitializer.initializePerformance());
      unawaited(FirebaseInitializer.configureFirestoreOffline());

      _status = BootstrapperStatus.success;
      LoggerService.i('Firebase Bootstrap successful');
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
