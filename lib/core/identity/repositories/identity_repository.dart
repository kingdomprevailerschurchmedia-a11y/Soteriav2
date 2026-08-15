import '../models/user_identity.dart';
import '../models/user_profile.dart';
import '../models/user_game_profile.dart';
import '../models/user_session.dart';

abstract class IdentityRepository {
  Stream<UserSession?> get sessionChanges;
  Future<UserSession?> getActiveSession();
  Future<UserIdentity?> getUserIdentity(String uid);
  Future<UserProfile?> getUserProfile(String uid);
  Future<UserGameProfile?> getUserGameProfile(String uid);
  Future<void> saveSession(UserSession session);
  Future<void> clearSession();
  Future<void> updateUserProfile(String uid, UserProfile profile);
  Future<void> updateUserGameProfile(String uid, UserGameProfile profile);
  Future<String> uploadProfilePicture(String uid, String filePath);
}

class MockIdentityRepository implements IdentityRepository {
  @override
  Stream<UserSession?> get sessionChanges => const Stream.empty();

  @override
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

  @override
  Future<void> updateUserProfile(String uid, UserProfile profile) async {}

  @override
  Future<void> updateUserGameProfile(String uid, UserGameProfile profile) async {}

  @override
  Future<String> uploadProfilePicture(String uid, String filePath) async => '';
}
