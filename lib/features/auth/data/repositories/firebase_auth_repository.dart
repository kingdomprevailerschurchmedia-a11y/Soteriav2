import 'dart:async';
import 'package:soteria/core/firebase/data_sources/auth_data_source.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../models/authentication_result.dart';
import '../mappers/identity_exception_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({required AuthDataSource dataSource})
      : _dataSource = dataSource;

  final AuthDataSource _dataSource;

  @override
  Stream<String?> get userIdChanges =>
      _dataSource.authStateChanges.map((user) => user?.uid);

  @override
  String? get currentUserId => _dataSource.currentUser?.uid;

  @override
  Future<AuthenticationResult> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final credential = await _dataSource.signInWithEmail(email, password);
      final user = credential.user;

      if (user != null) {
        if (!user.emailVerified) {
          return const AuthenticationResult.unverified();
        }
        return AuthenticationResult.success(user.uid);
      }
      return const AuthenticationResult.failure(null);
    } catch (e) {
      return AuthenticationResult.failure(IdentityExceptionMapper.map(e));
    }
  }

  @override
  Future<AuthenticationResult> signUpWithEmail(
    String email,
    String password,
  ) async {
    try {
      final credential = await _dataSource.signUpWithEmail(email, password);
      final user = credential.user;

      if (user != null) {
        // Automatically send verification email on sign up
        await _dataSource.sendEmailVerification();
        return AuthenticationResult.success(user.uid);
      }
      return const AuthenticationResult.failure(null);
    } catch (e) {
      return AuthenticationResult.failure(IdentityExceptionMapper.map(e));
    }
  }

  @override
  Future<AuthenticationResult> signInWithGoogle() async {
    try {
      final credential = await _dataSource.signInWithGoogle();
      final user = credential.user;

      if (user != null) {
        return AuthenticationResult.success(user.uid);
      }
      return const AuthenticationResult.failure(null);
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'google-sign-in-failed' &&
          e.message?.contains('canceled') == true) {
        return const AuthenticationResult.failure(null);
      }
      return AuthenticationResult.failure(IdentityExceptionMapper.map(e));
    } catch (e) {
      final identityException = IdentityExceptionMapper.map(e);
      if (identityException.userMessage == 'Sign in cancelled.') {
        return const AuthenticationResult.failure(null);
      }
      return AuthenticationResult.failure(identityException);
    }
  }

  @override
  Future<void> signOut() => _dataSource.signOut();

  @override
  Future<void> sendPasswordResetEmail(String email) =>
      _dataSource.sendPasswordResetEmail(email);

  @override
  Future<void> sendEmailVerification() => _dataSource.sendEmailVerification();

  @override
  Future<bool> isEmailVerified() async {
    await _dataSource.reloadUser();
    return _dataSource.currentUser?.emailVerified ?? false;
  }
}
