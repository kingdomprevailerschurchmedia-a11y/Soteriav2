import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart' as gsi;
import 'login_repository.dart';
import '../models/authentication_result.dart';
import '../../../core/identity/repositories/firebase_error_mapper.dart';
import '../../../core/logging/logger_service.dart';

class FirebaseLoginRepository implements LoginRepository {
  FirebaseLoginRepository({FirebaseAuth? auth, gsi.GoogleSignIn? googleSignIn})
    : _auth = auth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? gsi.GoogleSignIn.instance;

  final FirebaseAuth _auth;
  final gsi.GoogleSignIn _googleSignIn;

  @override
  Future<AuthenticationResult> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        if (!user.emailVerified) {
          return const AuthenticationResult.unverified();
        }
        return AuthenticationResult.success(user.uid);
      }
      return const AuthenticationResult.failure(null);
    } on FirebaseAuthException catch (e) {
      return AuthenticationResult.failure(
        FirebaseErrorMapper.mapFirebaseAuthException(e),
      );
    } catch (e) {
      return const AuthenticationResult.failure(null);
    }
  }

  @override
  Future<AuthenticationResult> loginWithGoogle() async {
    try {
      LoggerService.i('Starting Google Sign-In...', feature: 'Auth');

      // Initialize Google Sign In (Required in v7.x+)
      await _googleSignIn.initialize(
        serverClientId:
            '464470460254-iodgceppn2e0vjnpoq0nfo8ll90kpkm7.apps.googleusercontent.com',
      );

      final gsi.GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();

      if (googleUser == null) {
        LoggerService.i('Google Sign-In cancelled by user', feature: 'Auth');
        return const AuthenticationResult.failure(null);
      }

      LoggerService.i(
        'Google user authenticated: ${googleUser.email}',
        feature: 'Auth',
      );

      final gsi.GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      // In v7.x+, accessToken is retrieved via the authorizationClient.
      final gsi.GoogleSignInClientAuthorization authz = await googleUser
          .authorizationClient
          .authorizeScopes(['email', 'profile']);
      final String? accessToken = authz.accessToken;

      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        LoggerService.i(
          'Firebase login successful: ${user.uid}',
          feature: 'Auth',
        );
        return AuthenticationResult.success(user.uid);
      }
      return const AuthenticationResult.failure(null);
    } on FirebaseAuthException catch (e) {
      LoggerService.e(
        'Firebase Auth Exception during Google Sign-In',
        error: e,
        feature: 'Auth',
      );
      return AuthenticationResult.failure(
        FirebaseErrorMapper.mapFirebaseAuthException(e),
      );
    } catch (e, st) {
      LoggerService.e(
        'Unexpected error during Google Sign-In',
        error: e,
        stackTrace: st,
        feature: 'Auth',
      );
      return const AuthenticationResult.failure(null);
    }
  }

  @override
  Future<void> logout() async {
    await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
  }

  @override
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
