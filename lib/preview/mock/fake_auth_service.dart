import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../../core/firebase/services/firebase_interfaces.dart';

class FakeAuthService implements IAuthService {
  auth.User? _currentUser;
  final _controller = StreamController<auth.User?>.broadcast();

  FakeAuthService() {
    _currentUser = null;
  }

  @override
  auth.User? get currentUser => _currentUser;

  @override
  Stream<auth.User?> get authStateChanges => _controller.stream;

  @override
  auth.FirebaseAuth get instance =>
      throw UnimplementedError('Raw SDK instance not available in Preview');

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _controller.add(null);
  }

  // Helper for tests/previews to "login"
  void setMockUser(auth.User? user) {
    _currentUser = user;
    _controller.add(user);
  }
}
