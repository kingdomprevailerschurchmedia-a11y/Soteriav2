import 'package:firebase_auth/firebase_auth.dart';
import '../../../../features/auth/models/identity_exception.dart';

class FirebaseErrorMapper {
  static IdentityException mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
<<<<<<< HEAD
      case 'invalid-email':
        return const IdentityException(
          IdentityExceptionType.invalidCredentials,
        );
=======
        return const IdentityException(IdentityExceptionType.invalidCredentials);
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
      case 'user-disabled':
        return const IdentityException(IdentityExceptionType.accountLocked);
      case 'too-many-requests':
        return const IdentityException(IdentityExceptionType.tooManyAttempts);
      case 'network-request-failed':
<<<<<<< HEAD
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
=======
        return const IdentityException(IdentityExceptionType.networkUnavailable);
      case 'operation-not-allowed':
      case 'internal-error':
        return const IdentityException(IdentityExceptionType.serviceUnavailable);
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
      default:
        return IdentityException(IdentityExceptionType.unknown, e.message);
    }
  }
}
