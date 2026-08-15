import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'package:soteria/core/widgets/errors/error_screens.dart';

class ErrorHandler {
  static void init() {
    // Flutter framework errors
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      LoggerService.e(
        'Flutter Framework Error',
        error: details.exception,
        stackTrace: details.stack,
        feature: 'Framework',
      );
    };

    // Platform/Async errors
    PlatformDispatcher.instance.onError = (error, stack) {
      LoggerService.critical(
        'Uncaught Platform Error',
        error: error,
        stackTrace: stack,
        feature: 'Platform',
      );
      return true;
    };
  }

  static Widget errorWidgetBuilder(FlutterErrorDetails details) {
    return PremiumErrorScreen(
      exception: details.exception,
      stackTrace: details.stack,
      isUnexpected: true,
    );
  }
}

base class SoteriaProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (newValue is AsyncError) {
      LoggerService.e(
        'Provider Error: ${context.provider.name ?? context.provider.runtimeType}',
        error: newValue.error,
        stackTrace: newValue.stackTrace,
        feature: 'Riverpod',
      );
    }
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    LoggerService.e(
      'Provider Failed: ${context.provider.name ?? context.provider.runtimeType}',
      error: error,
      stackTrace: stackTrace,
      feature: 'Riverpod',
    );
  }
}
