import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
          return const IdentityException(
            IdentityExceptionType.unknown,
            'Sign in cancelled.',
          );
        case 'google-sign-in-failed':
          return IdentityException(
            IdentityExceptionType.unknown,
            error.message ?? 'Google sign in failed.',
          );
        default:
          return IdentityException(
            IdentityExceptionType.unknown,
            error.message,
          );
      }
    }

    if (error is GoogleSignInException) {
      if (error.code.toString().contains('canceled')) {
        return const IdentityException(
          IdentityExceptionType.unknown,
          'Sign in cancelled.',
        );
      }
      return IdentityException(
        IdentityExceptionType.unknown,
        error.description,
      );
    }

    return IdentityException(IdentityExceptionType.unknown, error.toString());
  }
}
