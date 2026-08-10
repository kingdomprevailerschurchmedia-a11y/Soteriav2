import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:soteria/core/app/app.dart';
import 'package:soteria/core/errors/error_handler.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'package:soteria/core/services/diagnostics_service.dart';
import 'package:soteria/core/services/performance_service.dart';
import 'package:soteria/core/firebase/initializer/firebase_initializer.dart';
import 'firebase_options.dart'; // Import your generated options file

void main() {
  runZonedGuarded(
    () async {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // 1. Essential core init only
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      runApp(
        ProviderScope(
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
      FirebaseInitializer.initializePerformance(),
      // Add other Future-returning startup services here
    ]);

    // Synchronous or non-Future initializations
    DiagnosticsService.init();
    PerformanceService.init();
    ErrorHandler.init();

    LoggerService.i('Deferred services initialized', feature: 'Startup');
  } catch (e, st) {
    LoggerService.e('Deferred services failed', error: e, stackTrace: st);
  }
}
