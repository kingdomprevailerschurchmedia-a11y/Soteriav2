import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/gameplay_engine/providers/gameplay_providers.dart';
import 'package:soteria/core/app/app.dart';
import 'package:soteria/core/errors/error_handler.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'package:soteria/core/services/diagnostics_service.dart';
import 'package:soteria/core/services/performance_service.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      final sharedPrefs = await SharedPreferences.getInstance();

      // Enable Edge-to-Edge mode
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      );

      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // We no longer await Firebase.initializeApp here to get to runApp faster.
      // The initialization is now handled by the FirebaseBootstrapper.

      runApp(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(sharedPrefs),
          ],
          observers: [SoteriaProviderObserver()],
          child: const SoteriaApp(),
        ),
      );

      // 2. Defer all non-critical background services to post-startup
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initializeDeferredServices();
      });
    },
    (error, stack) {
      LoggerService.e('Uncaught Error', error: error, stackTrace: stack);
    },
  );
}

/// Initializes non-critical services after the initial UI has rendered.
Future<void> _initializeDeferredServices() async {
  try {
    // Parallelize services that return Futures
    await Future.wait([
      DiagnosticsService.init(),
      // Add other Future-returning startup services here
    ]);

    // Synchronous or non-Future initializations
    PerformanceService.init();
    ErrorHandler.init();

    LoggerService.i('Deferred services initialized', feature: 'Startup');
  } catch (e, st) {
    LoggerService.e('Deferred services failed', error: e, stackTrace: st);
  }
}
