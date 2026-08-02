import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/core/utils/identity_validator.dart';

void main() {
  group('IdentityValidator', () {
    test('isValidEmail validates email formats', () {
      expect(IdentityValidator.isValidEmail('test@example.com'), true);
      expect(IdentityValidator.isValidEmail('test.name@domain.org'), true);
      expect(IdentityValidator.isValidEmail('invalid-email'), false);
      expect(IdentityValidator.isValidEmail('test@domain'), false);
    });

    test('isValidUsername validates username rules', () {
      expect(IdentityValidator.isValidUsername('user_123'), true);
      expect(IdentityValidator.isValidUsername('abc'), true);
      expect(IdentityValidator.isValidUsername('ab'), false); // Too short
      expect(IdentityValidator.isValidUsername('a' * 21), false); // Too long
      expect(
        IdentityValidator.isValidUsername('user name'),
        false,
      ); // No spaces
    });

    test('getPasswordStrength calculates correctly', () {
      expect(IdentityValidator.getPasswordStrength(''), 0.0);
      expect(
        IdentityValidator.getPasswordStrength('password'),
        0.4,
      ); // min length + lowercase
      expect(
        IdentityValidator.getPasswordStrength('Password123!'),
        1.0,
      ); // all met
    });
  });
}
