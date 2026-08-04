import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/domain/services/progression_service.dart';

void main() {
  late ProgressionService progressionService;

  setUp(() {
    progressionService = ProgressionService();
  });

  group('ProgressionService - Level Calculations', () {
    test('should calculate Level 1 for 0 XP', () {
      final player = PlayerProfile(
        uid: '123',
        displayName: 'Test',
        email: 'test@soteria.com',
        xp: 0,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      final progression = progressionService.calculateProgression(player);
      
      expect(progression.level, 1);
      expect(progression.xpInCurrentLevel, 0);
      expect(progression.progressPercentage, 0.0);
    });

    test('should calculate Level 2 for 1000 XP', () {
      final player = PlayerProfile(
        uid: '123',
        displayName: 'Test',
        email: 'test@soteria.com',
        xp: 1000,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      final progression = progressionService.calculateProgression(player);
      
      expect(progression.level, 2);
      expect(progression.xpInCurrentLevel, 0);
    });

    test('should calculate Level 2 with 50% progress for 1500 XP', () {
      // Level 1 -> 2 needs 1000
      // Level 2 -> 3 needs 2000
      // 1500 XP = Level 1 (1000) + 500 into Level 2
      // Level 2 needs 2000 to reach Level 3
      // Progress = 500 / 2000 = 0.25? 
      // Wait, let's check formula: Level N needs 1000 * N XP.
      // Level 1 -> 2: 1000
      // Level 2 -> 3: 2000
      // So at 1500 XP:
      // Level 1 completed (1000 used)
      // Remaining 500 is in Level 2.
      // Level 2 needs 2000 to get to Level 3.
      // Progress = 500 / 2000 = 0.25.
      
      final player = PlayerProfile(
        uid: '123',
        displayName: 'Test',
        email: 'test@soteria.com',
        xp: 1500,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      final progression = progressionService.calculateProgression(player);
      
      expect(progression.level, 2);
      expect(progression.xpInCurrentLevel, 500);
      expect(progression.nextLevelXp, 2000);
      expect(progression.progressPercentage, 0.25);
    });
  });

  group('ProgressionService - Profile Completion', () {
    test('should calculate 20% completion for default profile (only email)', () {
      final player = PlayerProfile(
        uid: '123',
        displayName: 'Scholar',
        email: 'test@soteria.com',
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      final completion = progressionService.calculateProfileCompletion(player);
      
      // email is filled, displayName is 'Scholar' (ignored), others empty.
      // 1/5 = 0.2
      expect(completion, 0.2);
    });

    test('should calculate 100% completion when all fields filled', () {
      final player = PlayerProfile(
        uid: '123',
        displayName: 'Joseph',
        email: 'test@soteria.com',
        photoUrl: 'https://avatar.com',
        favoriteCategories: ['Security'],
        avatarFrame: 'premium_gold',
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      final completion = progressionService.calculateProfileCompletion(player);
      expect(completion, 1.0);
    });
  });
}
