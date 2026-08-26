import '../../../../core/identity/models/user_profile.dart';
import '../models/player_profile.dart';

abstract interface class ProfileRepository {
  Future<bool> checkUsernameAvailability(String username);
  Future<void> updateProfile({
    required String userId,
    required UserProfile userProfile,
    required PlayerProfile playerProfile,
    String? oldUsername,
  });

  /// Synchronizes the public competitive profile for a user.
  /// This ensures that the user is discoverable and their stats are visible to others.
  Future<void> syncPublicProfile(String userId);
}
