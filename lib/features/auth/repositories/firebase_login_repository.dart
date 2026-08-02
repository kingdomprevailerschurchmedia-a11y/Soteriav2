import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_repository.dart';
import '../models/authentication_result.dart';
import '../../../core/identity/repositories/firebase_error_mapper.dart';

class FirebaseLoginRepository implements LoginRepository {
  FirebaseLoginRepository({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

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
      // In v7.x+, authenticate() is the new standard for identity
      final googleUser = await _googleSignIn.authenticate();
      
      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      
      if (user != null) {
        return AuthenticationResult.success(user.uid);
      }
      return const AuthenticationResult.failure(null);
    } on FirebaseAuthException catch (e) {
      return AuthenticationResult.failure(FirebaseErrorMapper.mapFirebaseAuthException(e));
    } catch (e) {
      return const AuthenticationResult.failure(null);
    }
  }

  @override
  Future<void> logout() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  @override
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
