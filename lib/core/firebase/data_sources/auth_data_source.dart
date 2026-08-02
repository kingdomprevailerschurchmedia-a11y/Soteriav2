import 'package:firebase_auth/firebase_auth.dart' as auth;

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
  FirebaseAuthDataSource({auth.FirebaseAuth? firebaseAuth, this._googleSignIn})
    : _auth = firebaseAuth ?? auth.FirebaseAuth.instance;

  final auth.FirebaseAuth _auth;
  final dynamic _googleSignIn;

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
    if (_googleSignIn == null) {
      throw auth.FirebaseAuthException(
        code: 'not-configured',
        message: 'Google Sign In not configured.',
      );
    }

    final dynamic googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw auth.FirebaseAuthException(
        code: 'google-sign-in-cancelled',
        message: 'The user cancelled the Google Sign-In flow.',
      );
    }

    final dynamic googleAuth = await googleUser.authentication;
    final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return _auth.signInWithCredential(credential);
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
