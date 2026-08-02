import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import '../config/firebase_config.dart';
import '../services/firebase_services.dart';
import '../../logging/logger_service.dart';
import '../security/services/security_coordinator.dart';

class FirebaseInitializer {
  static Future<void> initializeCore(FirebaseConfig config) async {
    LoggerService.i(
      'Initializing Firebase Core for environment: ${config.environment.name}',
    );
    await Firebase.initializeApp(options: config.options);
  }

  static Future<void> initializeCrashlytics() async {
    LoggerService.i('Initializing Firebase Crashlytics');
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
      !kDebugMode,
    );

    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static Future<void> initializeAnalytics() async {
    LoggerService.i('Initializing Firebase Analytics');
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(!kDebugMode);
  }

  static Future<void> initializePerformance() async {
    LoggerService.i('Initializing Firebase Performance');
    await FirebasePerformance.instance.setPerformanceCollectionEnabled(
      !kDebugMode,
    );
  }

  static Future<void> initializeAppCheck(
    SecurityCoordinator securityCoordinator,
  ) async {
    await securityCoordinator.initialize();
  }

  static Future<void> configureFirestoreOffline() async {
    LoggerService.i('Configuring Firestore Offline Persistence');
    await FirestoreDatabaseService().enablePersistence();
  }
}
