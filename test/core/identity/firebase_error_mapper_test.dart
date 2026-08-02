import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soteria/core/identity/repositories/firebase_error_mapper.dart';
import 'package:soteria/features/auth/models/identity_exception.dart';

void main() {
  group('FirebaseErrorMapper', () {
    test('maps user-not-found to invalidCredentials', () {
      final e = FirebaseAuthException(code: 'user-not-found');
      final result = FirebaseErrorMapper.mapFirebaseAuthException(e);
      expect(result.type, IdentityExceptionType.invalidCredentials);
    });

    test('maps network-request-failed to networkUnavailable', () {
      final e = FirebaseAuthException(code: 'network-request-failed');
      final result = FirebaseErrorMapper.mapFirebaseAuthException(e);
      expect(result.type, IdentityExceptionType.networkUnavailable);
    });
  });
}
