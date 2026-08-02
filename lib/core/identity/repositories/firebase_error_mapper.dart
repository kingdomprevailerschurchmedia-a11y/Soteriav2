import 'package:firebase_auth/firebase_auth.dart';
import '../../../../features/auth/models/identity_exception.dart';

class FirebaseErrorMapper {
  static IdentityException mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
      case 'invalid-email':
        return const IdentityException(
          IdentityExceptionType.invalidCredentials,
        );
      case 'user-disabled':
        return const IdentityException(IdentityExceptionType.accountLocked);
      case 'too-many-requests':
        return const IdentityException(IdentityExceptionType.tooManyAttempts);
      case 'network-request-failed':
        return const IdentityException(
          IdentityExceptionType.networkUnavailable,
        );
      case 'email-already-in-use':
        return const IdentityException(
          IdentityExceptionType.unknown,
          'This email is already registered.',
        );
      case 'weak-password':
        return const IdentityException(
          IdentityExceptionType.unknown,
          'The password provided is too weak.',
        );
      case 'operation-not-allowed':
      case 'internal-error':
        return const IdentityException(
          IdentityExceptionType.serviceUnavailable,
        );
      default:
        return IdentityException(IdentityExceptionType.unknown, e.message);
    }
  }
}
