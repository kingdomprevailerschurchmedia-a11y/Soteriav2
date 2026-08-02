import 'package:firebase_auth/firebase_auth.dart';

sealed class SoteriaFirebaseException implements Exception {
  final String message;
  final String? code;

  const SoteriaFirebaseException(this.message, {this.code});

  @override
  String toString() => 'SoteriaFirebaseException: $message (code: $code)';
}

class AuthException extends SoteriaFirebaseException {
  const AuthException(super.message, {super.code});
}

class DatabaseException extends SoteriaFirebaseException {
  const DatabaseException(super.message, {super.code});
}

class StorageException extends SoteriaFirebaseException {
  const StorageException(super.message, {super.code});
}

class MessagingException extends SoteriaFirebaseException {
  const MessagingException(super.message, {super.code});
}

class NetworkException extends SoteriaFirebaseException {
  const NetworkException(super.message, {super.code});
}

class FirebaseExceptionMapper {
  static SoteriaFirebaseException map(dynamic error) {
    if (error is FirebaseAuthException) {
      return AuthException(
        error.message ?? 'Authentication failed',
        code: error.code,
      );
    }

    if (error is FirebaseException) {
      if (error.code == 'network-request-failed') {
        return NetworkException('Network connection lost', code: error.code);
      }
      if (error.plugin == 'cloud_firestore') {
        return DatabaseException(
          error.message ?? 'Database operation failed',
          code: error.code,
        );
      }
      if (error.plugin == 'firebase_storage') {
        return StorageException(
          error.message ?? 'Storage operation failed',
          code: error.code,
        );
      }
      return DatabaseException(
        error.message ?? 'Firebase error',
        code: error.code,
      );
    }

    return DatabaseException(error.toString());
  }
}
