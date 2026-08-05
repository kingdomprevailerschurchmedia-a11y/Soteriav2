import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_repository.dart';
import '../models/authentication_result.dart';
import '../../../core/identity/repositories/firebase_error_mapper.dart';
<<<<<<< HEAD
import '../../../core/logging/logger_service.dart';

class FirebaseLoginRepository implements LoginRepository {
  FirebaseLoginRepository({FirebaseAuth? auth, GoogleSignIn? googleSignIn})
    : _auth = auth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn.instance;
=======

class FirebaseLoginRepository implements LoginRepository {
  FirebaseLoginRepository({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance;
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

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
<<<<<<< HEAD

=======
      
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
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
<<<<<<< HEAD
      LoggerService.i('Starting Google Sign-In...', feature: 'Auth');
      // In v7.x+, authenticate() is the new standard for identity
      final googleUser = await _googleSignIn.authenticate();

      LoggerService.i(
        'Google user authenticated: ${googleUser.email}',
        feature: 'Auth',
      );
=======
      // In v7.x+, authenticate() is the new standard for identity
      final googleUser = await _googleSignIn.authenticate();
      
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
<<<<<<< HEAD

      if (user != null) {
        LoggerService.i(
          'Firebase login successful: ${user.uid}',
          feature: 'Auth',
        );
=======
      
      if (user != null) {
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
        return AuthenticationResult.success(user.uid);
      }
      return const AuthenticationResult.failure(null);
    } on FirebaseAuthException catch (e) {
<<<<<<< HEAD
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
=======
      return AuthenticationResult.failure(FirebaseErrorMapper.mapFirebaseAuthException(e));
    } catch (e) {
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
      return const AuthenticationResult.failure(null);
    }
  }

  @override
  Future<void> logout() async {
<<<<<<< HEAD
    await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
=======
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
  }

  @override
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
