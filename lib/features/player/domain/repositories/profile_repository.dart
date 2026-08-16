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
}
