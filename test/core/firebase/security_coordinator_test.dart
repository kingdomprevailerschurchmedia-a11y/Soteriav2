import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/core/firebase/config/firebase_config.dart';
import 'package:soteria/core/firebase/security/services/security_coordinator.dart';

void main() {
  group('SecurityCoordinator', () {
    test('should initialize with correct environment and provider', () {
      final coordinator = SecurityCoordinator(FirebaseEnvironment.production);

      expect(
        coordinator.currentStatus.environment,
        FirebaseEnvironment.production,
      );
      expect(coordinator.currentStatus.providerName, contains('playIntegrity'));
    });

    test('should use debug provider for dev environment', () {
      final coordinator = SecurityCoordinator(FirebaseEnvironment.dev);

      expect(coordinator.currentStatus.environment, FirebaseEnvironment.dev);
      expect(coordinator.currentStatus.providerName, contains('debug'));
    });
  });
}
