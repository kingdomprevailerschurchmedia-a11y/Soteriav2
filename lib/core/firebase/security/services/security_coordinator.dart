import 'dart:async';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/services.dart';
import '../../config/firebase_config.dart';
import '../models/security_status.dart';
import '../../../logging/logger_service.dart';

class SecurityCoordinator {
  final FirebaseEnvironment _env;
  late final StreamController<SecurityStatus> _statusController;
  SecurityStatus _currentStatus;

  SecurityCoordinator(this._env)
    : _currentStatus = SecurityStatus(
        environment: _env,
        providerName: _getProviderName(_env),
      ) {
    _statusController = StreamController<SecurityStatus>.broadcast();
    _statusController.add(_currentStatus);
  }

  Stream<SecurityStatus> get statusStream => _statusController.stream;
  SecurityStatus get currentStatus => _currentStatus;

  Future<void> initialize() async {
    LoggerService.i(
      'Initializing SecurityCoordinator for environment: ${_env.name}',
      feature: 'Security',
    );

    try {
      // ignore: deprecated_member_use
      await FirebaseAppCheck.instance.activate(
        androidProvider: _getAndroidProvider(_env),
        appleProvider: AppleProvider.debug,
      );

      // Log the current token for easy access during development
      if (_env != FirebaseEnvironment.production) {
        // Wait a few seconds to ensure App Check provider is fully registered on the device
        await Future.delayed(const Duration(seconds: 3));
        
        final token = await FirebaseAppCheck.instance.getToken();
        
        // TEMPORARY: Copy to clipboard if on a physical device without ADB
        if (token != null) {
          await Clipboard.setData(ClipboardData(text: token));
          LoggerService.i(
            'App Check Debug Token copied to clipboard automatically.',
            feature: 'Security',
          );
        }

        LoggerService.i(
          'App Check Debug Token: $token',
          feature: 'Security',
        );
      }

      _updateStatus(
        _currentStatus.copyWith(
          isInitialized: true,
          tokenState: AppCheckTokenState.valid,
          lastRefreshTime: DateTime.now(),
        ),
      );

      FirebaseAppCheck.instance.onTokenChange.listen((token) {
        _updateStatus(
          _currentStatus.copyWith(
            tokenState: AppCheckTokenState.valid,
            lastRefreshTime: DateTime.now(),
          ),
        );
      });
    } catch (e, st) {
      final consoleLink = 'https://console.firebase.google.com/project/${FirebaseConfig.fromEnvironment().options.projectId}/appcheck/apps';
      LoggerService.e(
        'Failed to activate App Check. If you are using an emulator, ensure the debug token is registered in the Firebase Console: $consoleLink',
        error: e,
        stackTrace: st,
        feature: 'Security',
      );
      _updateStatus(
        _currentStatus.copyWith(
          tokenState: AppCheckTokenState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _updateStatus(SecurityStatus newStatus) {
    _currentStatus = newStatus;
    _statusController.add(_currentStatus);
  }

  static AndroidProvider _getAndroidProvider(FirebaseEnvironment env) {
    switch (env) {
      case FirebaseEnvironment.production:
        return AndroidProvider.playIntegrity;
      default:
        return AndroidProvider.debug;
    }
  }

  static String _getProviderName(FirebaseEnvironment env) {
    return _getAndroidProvider(env).name;
  }

  void dispose() {
    _statusController.close();
  }
}
