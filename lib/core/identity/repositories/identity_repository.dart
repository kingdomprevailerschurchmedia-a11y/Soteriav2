import '../models/user_identity.dart';
import '../models/user_profile.dart';
import '../models/user_game_profile.dart';
import '../models/user_session.dart';

abstract class IdentityRepository {
<<<<<<< HEAD
  Stream<UserSession?> get sessionChanges;
=======
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
  Future<UserSession?> getActiveSession();
  Future<UserIdentity?> getUserIdentity(String uid);
  Future<UserProfile?> getUserProfile(String uid);
  Future<UserGameProfile?> getUserGameProfile(String uid);
<<<<<<< HEAD

=======
  
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
  Future<void> saveSession(UserSession session);
  Future<void> clearSession();
}

class MockIdentityRepository implements IdentityRepository {
  @override
<<<<<<< HEAD
  Stream<UserSession?> get sessionChanges => const Stream.empty();

  @override
=======
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
  Future<UserSession?> getActiveSession() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return null; // Force first launch/onboarding for now
  }

  @override
  Future<UserIdentity?> getUserIdentity(String uid) async => null;

  @override
  Future<UserProfile?> getUserProfile(String uid) async => null;

  @override
  Future<UserGameProfile?> getUserGameProfile(String uid) async => null;

  @override
  Future<void> saveSession(UserSession session) async {}

  @override
  Future<void> clearSession() async {}
}
