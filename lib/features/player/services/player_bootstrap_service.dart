import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../domain/models/player_profile.dart';
import '../domain/use_cases/load_player_profile_use_case.dart';
import '../domain/use_cases/create_player_profile_use_case.dart';
import '../domain/use_cases/update_player_profile_use_case.dart';
import '../../../core/logging/logger_service.dart';

class PlayerBootstrapService {
  final LoadPlayerProfileUseCase _loadProfile;
  final CreatePlayerProfileUseCase _createProfile;
  final UpdatePlayerProfileUseCase _updateProfile;

  PlayerBootstrapService(
    this._loadProfile,
    this._createProfile,
    this._updateProfile,
  );

  Future<PlayerProfile> bootstrap(auth.User user) async {
    LoggerService.i(
      'Bootstrapping player profile for: ${user.uid}',
      feature: 'Player',
    );

    try {
      final existingProfile = await _loadProfile.execute(user.uid);

      if (existingProfile != null) {
        LoggerService.i(
          'Existing profile found, updating last login',
          feature: 'Player',
        );
        final updatedProfile = existingProfile.copyWith(
          lastLogin: DateTime.now(),
          updatedAt: DateTime.now(),
          // Self-healing: Ensure email is sync'd if it changed in Auth
          // (Though in Soteria email is immutable after verification usually)
        );
        await _updateProfile.execute(updatedProfile);
        return updatedProfile;
      } else {
        LoggerService.i(
          'No profile found, creating initial profile',
          feature: 'Player',
        );
        final now = DateTime.now();
        final newProfile = PlayerProfile(
          uid: user.uid,
          displayName: user.displayName ?? 'Scholar',
          email: user.email ?? '',
          photoUrl: user.photoURL ?? '',
          createdAt: now,
          lastLogin: now,
          updatedAt: now,
        );
        await _createProfile.execute(newProfile);
        return newProfile;
      }
    } catch (e, st) {
      LoggerService.e(
        'Player bootstrap failed',
        error: e,
        stackTrace: st,
        feature: 'Player',
      );
      rethrow;
    }
  }
}
