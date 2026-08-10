import 'dart:async';
import 'package:firebase_app_check/firebase_app_check.dart';
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
      await FirebaseAppCheck.instance.activate(
        androidProvider: _getAndroidProvider(_env),
        appleProvider: AppleProvider.debug,
      );
    } catch (e) {
      rethrow;
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
      LoggerService.e(
        'Failed to activate App Check',
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
