import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart';
import '../../personalization/utils/personalization_bridge.dart';
import '../domain/models/player_profile.dart';
import '../domain/use_cases/load_player_profile_use_case.dart';
import '../domain/use_cases/create_player_profile_use_case.dart';
import '../domain/use_cases/update_player_profile_use_case.dart';
import '../../../core/logging/logger_service.dart';

class PlayerBootstrapService {
  final LoadPlayerProfileUseCase _loadProfile;
  final CreatePlayerProfileUseCase _createProfile;
  final UpdatePlayerProfileUseCase _updateProfile;

  static const _kPersonalizationKey = 'user_personalization';

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
      final localInterests = await _getInterestsFromLocal();

      if (existingProfile != null) {
        LoggerService.i(
          'Existing profile found, updating last login',
          feature: 'Player',
        );

        // Sync interests if remote profile is missing them but local has them
        List<String> mergedInterests = existingProfile.favoriteCategories;
        if (mergedInterests.isEmpty && localInterests.isNotEmpty) {
          mergedInterests = localInterests;
        }

        final updatedProfile = existingProfile.copyWith(
          lastLogin: DateTime.now(),
          updatedAt: DateTime.now(),
          favoriteCategories: mergedInterests,
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
          favoriteCategories: localInterests,
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

  Future<List<String>> _getInterestsFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_kPersonalizationKey);
      if (data == null) return [];

      final Map<String, dynamic> map = jsonDecode(data);
      final interests = (map['interests'] as List<dynamic>).cast<String>();
      
      return interests.map((label) => PersonalizationBridge.labelToCategoryId(label)).toList();
    } catch (e) {
      return [];
    }
  }
}
