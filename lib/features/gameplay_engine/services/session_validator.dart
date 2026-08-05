import '../models/practice_session_config.dart';
import '../../player/domain/models/player_profile.dart';

class SessionValidator {
  String? validate(PracticeSessionConfig config, PlayerProfile? player) {
    if (config.category == null) {
      return 'Please select a category';
    }

    if (player == null) {
      return 'Player profile not found';
    }

    if (player.level < config.category!.minLevel) {
      return 'Level ${config.category!.minLevel} required for this category';
    }

    if (config.category!.isPremium && player.role != 'premium') {
      return 'Premium membership required for this category';
    }

    if (config.difficulty == PracticeDifficulty.advanced && player.level < 10) {
      return 'Level 10 required for Advanced difficulty';
    }

    return null; // Valid
  }
}
