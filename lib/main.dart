import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/app/app.dart';
import 'package:soteria/core/errors/error_handler.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'package:soteria/core/services/diagnostics_service.dart';
import 'package:soteria/core/services/performance_service.dart';
import 'firebase_options.dart'; // Import your generated options file

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

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

      // 2. Defer heavy background diagnostics & error handling to post-startup
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.wait([DiagnosticsService.init()]);
        PerformanceService.init();
        ErrorHandler.init();
      });
    },
    (error, stack) {
      LoggerService.e('Uncaught Error', error: error, stackTrace: stack);
    },
  );
}
