import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/identity/models/user_profile.dart';
import '../../../features/player/domain/models/player_profile.dart';
import '../../../features/player/domain/repositories/profile_repository.dart';
import '../../../features/player/providers/player_providers.dart';
import '../../../features/player/presentation/screens/profile_information_screen.dart';
import '../../../core/identity/providers/identity_providers.dart';

class ProfileInformationPreviewPage extends StatelessWidget {
  const ProfileInformationPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        profileProvider.overrideWith(() => ProfileMock()),
        currentPlayerProvider.overrideWithValue(PlayerProfile(
          uid: 'preview_user',
          displayName: 'John Doe',
          username: 'johndoe',
          email: 'john.doe@example.com',
          createdAt: DateTime.now(),
          lastLogin: DateTime.now(),
          updatedAt: DateTime.now(),
        )),
        profileRepositoryProvider.overrideWithValue(FakeProfileRepository()),
      ],
      child: const ProfileInformationScreen(),
    );
  }
}

class ProfileMock extends ProfileNotifier {
  @override
  UserProfile? build() {
    return const UserProfile(
      firstName: 'John',
      lastName: 'Doe',
      displayName: 'John Doe',
      username: 'johndoe',
      email: 'john.doe@example.com',
      bio: 'Competitive scholar and logic master.',
      country: 'Nigeria',
    );
  }
}

class FakeProfileRepository implements ProfileRepository {
  @override
  Future<bool> checkUsernameAvailability(String username) async {
    await Future.delayed(const Duration(seconds: 1));
    return username != 'taken';
  }

  @override
  Future<void> updateProfile({
    required String userId,
    required UserProfile userProfile,
    required PlayerProfile playerProfile,
    String? oldUsername,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    if (userProfile.firstName == 'Error') {
      throw Exception('Network timeout');
    }
  }
}
