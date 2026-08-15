import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:soteria/features/player/domain/models/achievement.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/repositories/achievement_repository.dart';
import 'package:soteria/features/player/domain/repositories/player_progression_repository.dart';
import 'package:soteria/features/player/domain/repositories/player_repository.dart';
import 'package:soteria/features/player/domain/services/achievement_service.dart';

class MockAchievementRepository extends Mock implements AchievementRepository {}
class MockPlayerProgressionRepository extends Mock implements PlayerProgressionRepository {}
class MockPlayerRepository extends Mock implements PlayerRepository {}

void main() {
  late MockAchievementRepository mockAchievementRepo;
  late MockPlayerProgressionRepository mockProgressionRepo;
  late MockPlayerRepository mockPlayerRepo;
  late AchievementService service;

  setUp(() {
    mockAchievementRepo = MockAchievementRepository();
    mockProgressionRepo = MockPlayerProgressionRepository();
    mockPlayerRepo = MockPlayerRepository();
    service = AchievementService(
      achievementRepository: mockAchievementRepo,
      progressionRepository: mockProgressionRepo,
      playerRepository: mockPlayerRepo,
    );
  });

  group('AchievementService - Evaluation', () {
    test('should unlock newly completed achievements', () async {
      final userId = 'user1';
      final now = DateTime.now();
      
      final profile = PlayerProfile(
        uid: userId,
        displayName: 'Test',
        email: 'test@test.com',
        gamesPlayed: 1, // Matches 'first_game'
        createdAt: now,
        lastLogin: now,
        updatedAt: now,
      );

      final progression = PlayerProgression.initial(userId, 's1');

      when(() => mockPlayerRepo.getPlayerProfile(userId)).thenAnswer((_) async => profile);
      when(() => mockProgressionRepo.getProgression(userId)).thenAnswer((_) async => progression);
      when(() => mockAchievementRepo.watchPlayerAchievements(userId)).thenAnswer((_) => Stream.value([]));
      when(() => mockAchievementRepo.unlockAchievement(any(), any())).thenAnswer((_) async {});

      await service.evaluateAchievements(userId);

      // Verify 'first_game' was unlocked
      verify(() => mockAchievementRepo.unlockAchievement(userId, 'first_game')).called(1);
    });

    test('should NOT unlock already earned achievements', () async {
      final userId = 'user1';
      final now = DateTime.now();
      
      final profile = PlayerProfile(
        uid: userId,
        displayName: 'Test',
        email: 'test@test.com',
        gamesPlayed: 1,
        createdAt: now,
        lastLogin: now,
        updatedAt: now,
      );

      final progression = PlayerProgression.initial(userId, 's1');

      final earned = [
        PlayerAchievement(
          userId: userId,
          achievementId: 'first_game',
          status: AchievementStatus.unlocked,
          currentValue: 1.0,
          targetValue: 1.0,
        ),
      ];

      when(() => mockPlayerRepo.getPlayerProfile(userId)).thenAnswer((_) async => profile);
      when(() => mockProgressionRepo.getProgression(userId)).thenAnswer((_) async => progression);
      when(() => mockAchievementRepo.watchPlayerAchievements(userId)).thenAnswer((_) => Stream.value(earned));

      await service.evaluateAchievements(userId);

      verifyNever(() => mockAchievementRepo.unlockAchievement(any(), any()));
    });

    test('should unlock level milestone achievement', () async {
      final userId = 'user1';
      final now = DateTime.now();
      
      final profile = PlayerProfile(
        uid: userId,
        displayName: 'Test',
        email: 'test@test.com',
        createdAt: now,
        lastLogin: now,
        updatedAt: now,
      );

      final progression = PlayerProgression.initial(userId, 's1').copyWith(
        currentLevel: 10,
      );

      when(() => mockPlayerRepo.getPlayerProfile(userId)).thenAnswer((_) async => profile);
      when(() => mockProgressionRepo.getProgression(userId)).thenAnswer((_) async => progression);
      when(() => mockAchievementRepo.watchPlayerAchievements(userId)).thenAnswer((_) => Stream.value([]));
      when(() => mockAchievementRepo.unlockAchievement(any(), any())).thenAnswer((_) async {});

      await service.evaluateAchievements(userId);

      verify(() => mockAchievementRepo.unlockAchievement(userId, 'level_10')).called(1);
    });
  });
}
