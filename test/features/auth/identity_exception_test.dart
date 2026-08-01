import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/auth/models/identity_exception.dart';

void main() {
  group('IdentityException', () {
    test('maps types to correct user messages', () {
      const e1 = IdentityException(IdentityExceptionType.invalidCredentials);
      expect(e1.userMessage, contains('incorrect'));

      const e2 = IdentityException(IdentityExceptionType.networkUnavailable);
      expect(e2.userMessage, contains('connection'));

      const e3 = IdentityException(IdentityExceptionType.accountLocked);
      expect(e3.userMessage, contains('locked'));
    });

    test('unknown type returns default message', () {
      const e = IdentityException(IdentityExceptionType.unknown, 'Custom error');
      expect(e.userMessage, 'Custom error');
    });
  });
}
