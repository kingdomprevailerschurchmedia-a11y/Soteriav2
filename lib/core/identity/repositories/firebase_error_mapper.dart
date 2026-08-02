import 'package:firebase_auth/firebase_auth.dart';
import '../../../../features/auth/models/identity_exception.dart';

class FirebaseErrorMapper {
  static IdentityException mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return const IdentityException(IdentityExceptionType.invalidCredentials);
      case 'user-disabled':
        return const IdentityException(IdentityExceptionType.accountLocked);
      case 'too-many-requests':
        return const IdentityException(IdentityExceptionType.tooManyAttempts);
      case 'network-request-failed':
        return const IdentityException(IdentityExceptionType.networkUnavailable);
      case 'operation-not-allowed':
      case 'internal-error':
        return const IdentityException(IdentityExceptionType.serviceUnavailable);
      default:
        return IdentityException(IdentityExceptionType.unknown, e.message);
    }
  }
}
