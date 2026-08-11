import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/services/progression_service.dart';
import 'package:soteria/features/player/domain/config/progression_config.dart';

void main() {
  late ProgressionService progressionService;

  setUp(() {
    progressionService = ProgressionService();
  });

  group('ProgressionService - New Level Logic', () {
    test('addXp should correctly increase level when threshold crossed', () {
      final initial = PlayerProgression.initial('user1', 'season1');

      // Level 1 -> 2 needs 1400 XP based on new formula
      final updated = progressionService.addXp(initial, 1500);

      expect(updated.currentLevel, 2);
      expect(updated.currentXp, 100); // 1500 - 1400
      expect(updated.lifetimeXp, 1500);
      expect(updated.xpProgress, closeTo(100 / (2800 - 1400), 0.01));
    });

    test('addXp should handle multi-level jumps', () {
      final initial = PlayerProgression.initial('user1', 'season1');

      // Level 1 -> 2: 1400
      // Level 2 -> 3: 1400 (Total 2800)
      // Level 3 -> 4: 1000 * 3 * 1.2 + 200 * 3 = 3600 + 600 = 4200

      final updated = progressionService.addXp(initial, 5000);

      expect(updated.currentLevel, 4);
      expect(updated.lifetimeXp, 5000);
      expect(updated.currentXp, 800); // 5000 - 4200
    });
  });

  group('ProgressionService - Rank Logic', () {
    test('should resolve correct rank tier for points', () {
      expect(progressionService.resolveRankTier(0).id, 'unranked');
      expect(progressionService.resolveRankTier(150).id, 'bronze');
      expect(progressionService.resolveRankTier(600).id, 'silver');
      expect(progressionService.resolveRankTier(1500).id, 'gold');
      expect(progressionService.resolveRankTier(8000).id, 'elite');
    });

    test('should calculate correct rank progress', () {
      final goldTier = ProgressionConfig.rankTiers.firstWhere(
        (t) => t.id == 'gold',
      );
      // Gold: 1000 - 1999 (Range 999)
      final progress = progressionService.calculateRankProgress(1500, goldTier);
      expect(progress, closeTo(500 / 999, 0.01));
    });
  });
}
