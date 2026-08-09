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
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (newValue is AsyncError) {
      LoggerService.e(
        'Provider Error: ${provider.name ?? provider.runtimeType}',
        error: newValue.error,
        stackTrace: newValue.stackTrace,
        feature: 'Riverpod',
      );
    }
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    LoggerService.e(
      'Provider Failed: ${provider.name ?? provider.runtimeType}',
      error: error,
      stackTrace: stackTrace,
      feature: 'Riverpod',
    );
  }
}
