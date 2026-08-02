import '../models/authentication_result.dart';

abstract class LoginRepository {
  Future<AuthenticationResult> loginWithEmail({
    required String email,
    required String password,
  });

  Future<AuthenticationResult> loginWithGoogle();

  Future<void> logout();

  Future<void> resetPassword(String email);
}

class MockLoginRepository implements LoginRepository {
  @override
  Future<AuthenticationResult> loginWithEmail({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'error@soteria.com') {
      return const AuthenticationResult.failure(
        null,
      ); // Will map to unknown in UI or be specific
    }
    return const AuthenticationResult.success('mock-user-id');
  }

  @override
  Future<AuthenticationResult> loginWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    return const AuthenticationResult.success('mock-google-id');
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
