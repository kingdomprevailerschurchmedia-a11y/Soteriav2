import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/app/app.dart';
import 'package:soteria/core/errors/error_handler.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'package:soteria/core/services/diagnostics_service.dart';
import 'package:soteria/core/services/performance_service.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Parallelize Service Initialization
    await Future.wait([
      DiagnosticsService.init(),
      // Add other independent services here
    ]);

    PerformanceService.init();

    // Global Error Handling
    ErrorHandler.init();

    runApp(
      ProviderScope(
        observers: [SoteriaProviderObserver()],
        child: const SoteriaApp(),
      ),
    );
  }, (error, stack) {
    LoggerService.e('Uncaught Error', error: error, stackTrace: stack);
  });
}
