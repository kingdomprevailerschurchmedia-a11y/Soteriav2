import '../../models/authentication_result.dart';

abstract interface class AuthRepository {
  Stream<String?> get userIdChanges;

  Future<AuthenticationResult> signInWithEmail(String email, String password);
  Future<AuthenticationResult> signUpWithEmail(String email, String password);
  Future<AuthenticationResult> signInWithGoogle();

  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> sendEmailVerification();
  Future<bool> isEmailVerified();

  String? get currentUserId;
}
