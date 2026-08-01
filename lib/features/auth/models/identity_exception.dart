enum IdentityExceptionType {
  invalidCredentials,
  networkUnavailable,
  accountLocked,
  emailNotVerified,
  tooManyAttempts,
  serviceUnavailable,
  unknown,
}

class IdentityException implements Exception {
  final IdentityExceptionType type;
  final String? message;

  const IdentityException(this.type, [this.message]);

  String get userMessage {
    switch (type) {
      case IdentityExceptionType.invalidCredentials:
        return 'The email or password you entered is incorrect.';
      case IdentityExceptionType.networkUnavailable:
        return 'Please check your internet connection and try again.';
      case IdentityExceptionType.accountLocked:
        return 'Your account has been temporarily locked for security reasons.';
      case IdentityExceptionType.emailNotVerified:
        return 'Please verify your email address before signing in.';
      case IdentityExceptionType.tooManyAttempts:
        return 'Too many failed attempts. Please try again later.';
      case IdentityExceptionType.serviceUnavailable:
        return 'Our identity servers are currently undergoing maintenance.';
      case IdentityExceptionType.unknown:
        return message ?? 'An unexpected identity error occurred.';
    }
  }

  @override
  String toString() => 'IdentityException: $type - $message';
}
