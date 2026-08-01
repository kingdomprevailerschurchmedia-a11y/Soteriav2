import 'identity_exception.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unverified }

class AuthenticationResult {
  final AuthenticationStatus status;
  final IdentityException? error;
  final String? userId;

  const AuthenticationResult.success(this.userId)
      : status = AuthenticationStatus.authenticated,
        error = null;

  const AuthenticationResult.failure(this.error)
      : status = AuthenticationStatus.unauthenticated,
        userId = null;

  const AuthenticationResult.unverified()
      : status = AuthenticationStatus.unverified,
        error = null,
        userId = null;

  bool get isSuccess => status == AuthenticationStatus.authenticated;
}

class SessionPreference {
  final bool rememberMe;
  final String? lastEmail;

  const SessionPreference({this.rememberMe = false, this.lastEmail});
}
