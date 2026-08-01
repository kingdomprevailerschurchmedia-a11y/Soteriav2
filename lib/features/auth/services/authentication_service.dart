import '../models/authentication_result.dart';
import '../models/identity_provider.dart';

abstract class AuthenticationService {
  Future<AuthenticationResult> signIn(IdentityProvider provider);
  Future<void> signOut();
  Stream<AuthenticationStatus> get authStatus;
}

class MockAuthenticationService implements AuthenticationService {
  @override
  Future<AuthenticationResult> signIn(IdentityProvider provider) async {
    await Future.delayed(const Duration(seconds: 1));
    return const AuthenticationResult.success('mock-id');
  }

  @override
  Future<void> signOut() async {}

  @override
  Stream<AuthenticationStatus> get authStatus => const Stream.empty();
}
