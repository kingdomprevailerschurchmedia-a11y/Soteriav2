import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_policy.dart';

void main() {
  group('ProgressionPolicyResolver', () {
    test('should resolve Practice policy', () {
      final policy = ProgressionPolicyResolver.resolve(GameMode.practice);
      expect(policy, isA<PracticeProgressionPolicy>());
      expect(policy.xpPerCorrect, 10);
      expect(policy.xpMultiplier, 1.0);
    });

    test('should resolve Pro policy with default difficulty', () {
      final policy = ProgressionPolicyResolver.resolve(GameMode.pro);
      expect(policy, isA<ProProgressionPolicy>());
      expect(policy.xpMultiplier, 1.5);
    });

    test('should resolve VS policy with difficulty multiplier', () {
      final policy = ProgressionPolicyResolver.resolve(
        GameMode.versus,
        difficulty: 'expert',
      );
      expect(policy, isA<VSProgressionPolicy>());
      // Expert = 3.0. VS Base = 2.0. Result = 6.0? 
      // No, VSProgressionPolicy uses diffMultiplier which defaults to _getDifficultyMultiplier.
      // Expert -> 3.0. VS Base is 2.0. multiplier = 2.0 * 3.0 = 6.0.
      expect(policy.xpMultiplier, 6.0);
    });

    test('should resolve Tournament policy', () {
      final policy = ProgressionPolicyResolver.resolve(GameMode.tournament);
      expect(policy, isA<TournamentProgressionPolicy>());
      expect(policy.xpMultiplier, 2.5);
    });
    
    test('should use difficultyMultiplier if provided directly', () {
      final policy = ProgressionPolicyResolver.resolve(
        GameMode.versus,
        difficultyMultiplier: 5.0,
      );
      expect(policy.xpMultiplier, 10.0); // 2.0 * 5.0
    });
  });
}
