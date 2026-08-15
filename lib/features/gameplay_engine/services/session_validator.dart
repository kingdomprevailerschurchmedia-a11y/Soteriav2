import '../models/practice_session_config.dart';
import '../../player/domain/models/player_profile.dart';
import '../../question_content/domain/entities/difficulty.dart';

class SessionValidator {
  String? validate({
    required PracticeSessionConfig config,
    required PlayerProfile? player,
    required int level,
  }) {
    if (player == null) {
      return 'Player profile not found';
    }

    if (!config.useInterests &&
        config.category == null &&
        config.categoryIds.isEmpty) {
      return 'Please select at least one category';
    }

    if (config.category != null) {
      if (level < config.category!.minLevel) {
        return 'Level ${config.category!.minLevel} required for this category';
      }

      if (config.category!.isPremium && player.role != 'premium') {
        return 'Premium membership required for this category';
      }
    }

    if (config.difficulty == Difficulty.expert && level < 10) {
      return 'Level 10 required for Expert difficulty';
    }

    return null; // Valid
  }
}
