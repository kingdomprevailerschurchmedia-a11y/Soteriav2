import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soteria/features/auth/data/mappers/identity_exception_mapper.dart';
import 'package:soteria/features/auth/models/identity_exception.dart';

void main() {
  group('IdentityExceptionMapper', () {
    test('should map invalid-email to invalidCredentials', () {
      final exception = FirebaseAuthException(code: 'invalid-email');
      final result = IdentityExceptionMapper.map(exception);
      expect(result.type, IdentityExceptionType.invalidCredentials);
    });

    test('should map user-disabled to accountLocked', () {
      final exception = FirebaseAuthException(code: 'user-disabled');
      final result = IdentityExceptionMapper.map(exception);
      expect(result.type, IdentityExceptionType.accountLocked);
    });

    test('should map too-many-requests to tooManyAttempts', () {
      final exception = FirebaseAuthException(code: 'too-many-requests');
      final result = IdentityExceptionMapper.map(exception);
      expect(result.type, IdentityExceptionType.tooManyAttempts);
    });
  });
}
