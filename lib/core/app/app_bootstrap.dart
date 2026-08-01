import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/core/logging/logger_service.dart';

enum BootstrapState { initial, loading, success, error }

class AppBootstrap {
  AppBootstrap(this.ref);
  final Ref ref;

  Future<void> initialize() async {
    try {
      LoggerService.i('Bootstrap: Starting initialization sequence...');
      
      // Parallel initialization for speed
      await Future.wait([
        _initLocalStorage(),
        _initConfiguration(),
        _initAnalytics(),
        _initFeatureFlags(),
      ]);

      LoggerService.i('Bootstrap: All systems healthy.');
    } catch (e, stack) {
      LoggerService.e('Bootstrap: Critical failure during initialization', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> _initLocalStorage() async {
    await SharedPreferences.getInstance();
    LoggerService.d('Bootstrap: Local storage ready.');
  }

  Future<void> _initConfiguration() async {
    // Placeholder for remote config/env loading
    await Future.delayed(const Duration(milliseconds: 100));
    LoggerService.d('Bootstrap: App configuration loaded.');
  }

  Future<void> _initAnalytics() async {
    // Placeholder for analytics abstraction
    LoggerService.d('Bootstrap: Analytics initialized.');
  }

  Future<void> _initFeatureFlags() async {
    // Placeholder for feature flag system
    LoggerService.d('Bootstrap: Feature flags synchronized.');
  }
}

// Removing the duplicate/typo provider
final bootstrapServiceProvider = Provider((ref) => AppBootstrap(ref));

class BootstrapNotifier extends Notifier<BootstrapState> {
  @override
  BootstrapState build() => BootstrapState.initial;

  Future<void> run() async {
    if (!ref.mounted) return;
    state = BootstrapState.loading;
    try {
      await ref.read(bootstrapServiceProvider).initialize();
      if (ref.mounted) state = BootstrapState.success;
    } catch (_) {
      if (ref.mounted) state = BootstrapState.error;
    }
  }
}

// Fixed the typo in provider name
final bootstrapStateProvider = NotifierProvider<BootstrapNotifier, BootstrapState>(BootstrapNotifier.new);
