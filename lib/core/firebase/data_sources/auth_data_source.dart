import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart' as gsi;

abstract interface class AuthDataSource {
  Stream<auth.User?> get authStateChanges;
  auth.User? get currentUser;

  Future<auth.UserCredential> signInWithEmail(String email, String password);
  Future<auth.UserCredential> signUpWithEmail(String email, String password);
  Future<auth.UserCredential> signInWithGoogle();

  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> sendEmailVerification();
  Future<void> reloadUser();
}

class FirebaseAuthDataSource implements AuthDataSource {
  FirebaseAuthDataSource({
    auth.FirebaseAuth? firebaseAuth,
    this._googleSignIn,
  }) : _auth = firebaseAuth ?? auth.FirebaseAuth.instance;

  final auth.FirebaseAuth _auth;
  final gsi.GoogleSignIn? _googleSignIn;

  @override
  Stream<auth.User?> get authStateChanges => _auth.authStateChanges();

  @override
  auth.User? get currentUser => _auth.currentUser;

  @override
  Future<auth.UserCredential> signInWithEmail(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<auth.UserCredential> signUpWithEmail(String email, String password) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<auth.UserCredential> signInWithGoogle() async {
    final gsi.GoogleSignIn? googleSignIn = _googleSignIn;
    if (googleSignIn == null) {
      throw auth.FirebaseAuthException(
        code: 'not-configured',
        message: 'Google Sign In not configured.',
      );
    }

    try {
      // Initialize Google Sign In (Required in v7.x+)
      await googleSignIn.initialize(
        serverClientId:
            '464470460254-iodgceppn2e0vjnpoq0nfo8ll90kpkm7.apps.googleusercontent.com',
      );

      final gsi.GoogleSignInAccount googleUser = await googleSignIn
          .authenticate();

      final gsi.GoogleSignInAuthentication googleAuth =
          googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      // In v7.x+, accessToken is retrieved via the authorizationClient.
      // We request basic identity scopes to obtain the token.
      final gsi.GoogleSignInClientAuthorization authz = await googleUser
          .authorizationClient
          .authorizeScopes(['email', 'profile']);
      final String accessToken = authz.accessToken;

      if (idToken == null && accessToken == null) {
        throw auth.FirebaseAuthException(
          code: 'missing-tokens',
          message: 'Google ID Token and Access Token are missing.',
        );
      }

      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );

      return _auth.signInWithCredential(credential);
    } on gsi.GoogleSignInException catch (e) {
      if (e.code == gsi.GoogleSignInExceptionCode.canceled) {
        throw auth.FirebaseAuthException(
          code: 'google-sign-in-cancelled',
          message: 'User cancelled Google Sign In.',
        );
      }
      throw auth.FirebaseAuthException(
        code: 'google-sign-in-failed',
        message: e.description,
      );
    } catch (e) {
      throw auth.FirebaseAuthException(
        code: 'google-sign-in-failed',
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    if (_googleSignIn != null) {
      await _googleSignIn.signOut();
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  @override
  Future<void> reloadUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.reload();
    }
  }
}
