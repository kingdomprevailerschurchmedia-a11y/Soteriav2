import 'package:firebase_auth/firebase_auth.dart';
import '../../models/identity_exception.dart';

class IdentityExceptionMapper {
  static IdentityException map(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return const IdentityException(
            IdentityExceptionType.invalidCredentials,
          );
        case 'user-disabled':
          return const IdentityException(IdentityExceptionType.accountLocked);
        case 'network-request-failed':
          return const IdentityException(
            IdentityExceptionType.networkUnavailable,
          );
        case 'too-many-requests':
          return const IdentityException(IdentityExceptionType.tooManyAttempts);
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
        case 'google-sign-in-cancelled':
          // We'll handle this specially in the UseCase or Repository to avoid showing an error
          return const IdentityException(
            IdentityExceptionType.unknown,
            'Sign in cancelled.',
          );
        default:
          return IdentityException(
            IdentityExceptionType.unknown,
            error.message,
          );
      }
    }
    return IdentityException(IdentityExceptionType.unknown, error.toString());
  }
}
