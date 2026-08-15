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

      // Unified Formula: Level 2 needs 150 XP. Level 6 needs 1368 XP. Level 7 needs 1769 XP.
      final updated = progressionService.addXp(initial, 1500);

      expect(updated.currentLevel, 6);
      expect(updated.lifetimeXp, 1500);
      expect(updated.currentXp, 132); // 1500 - 1368
      expect(updated.xpProgress, closeTo(132 / 401, 0.01));
    });

    test('addXp should handle multi-level jumps', () {
      final initial = PlayerProgression.initial('user1', 'season1');

      // Level 13 needs 4757 XP. Level 14 needs 5337 XP.
      final updated = progressionService.addXp(initial, 5000);

      expect(updated.currentLevel, 13);
      expect(updated.lifetimeXp, 5000);
      expect(updated.currentXp, 244); // 5000 - 4756
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
