import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/core/firebase/config/firebase_config.dart';

void main() {
  group('FirebaseConfig', () {
    test('should resolve environment from string', () {
      expect(FirebaseEnvironment.fromString('dev'), FirebaseEnvironment.dev);
      expect(
        FirebaseEnvironment.fromString('production'),
        FirebaseEnvironment.production,
      );
      expect(
        FirebaseEnvironment.fromString('unknown'),
        FirebaseEnvironment.dev,
      );
    });

    test('should disable emulator in production', () {
      final config = FirebaseConfig(
        environment: FirebaseEnvironment.production,
      );
      expect(config.useEmulator, false);
    });
  });
}
