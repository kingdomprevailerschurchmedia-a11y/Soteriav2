import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/core/logging/logger_service.dart';

void main() {
  group('LoggerService Security Audit', () {
    test('redacts sensitive info from messages', () {
      // We can't directly check the internal Logger state easily,
      // but we can listen to the logStream.

      final futureEntry = LoggerService.logStream.first;

      LoggerService.i('Attempting login with password: secret_password_123');

      futureEntry.then((entry) {
        expect(entry.message, contains('[REDACTED]'));
        expect(entry.message, isNot(contains('secret_password_123')));
      });
    });

    test('redacts sensitive info from metadata', () {
      final futureEntry = LoggerService.logStream.first;

      LoggerService.i(
        'Auth event',
        metadata: {'token': 'super_secret_token', 'public_info': 'hello'},
      );

      futureEntry.then((entry) {
        expect(entry.metadata!['token'], '[REDACTED]');
        expect(entry.metadata!['public_info'], 'hello');
      });
    });
  });
}
