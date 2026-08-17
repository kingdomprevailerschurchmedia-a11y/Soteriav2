import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soteria/core/firebase/config/models/app_configuration.dart';
import 'package:soteria/core/firebase/config/providers/configuration_providers.dart';
import 'package:soteria/features/dashboard/presentation/providers/pro_lobby_providers.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/pro_mode_repository.dart';
import 'package:soteria/features/gameplay_engine/models/competitive_session.dart';
import 'package:soteria/features/gameplay_engine/models/pro_mode_access.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/question_content/domain/entities/category.dart';
import 'package:soteria/features/question_content/domain/repositories/category_repository.dart';
import 'package:soteria/features/question_content/presentation/providers/category_providers.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/player/presentation/providers/progression_providers.dart';

class MockProModeRepository extends Mock implements ProModeRepository {
  @override
  Future<int> getAvailableQuestionCount({
    List<String>? categoryIds,
    required Difficulty difficulty,
  }) => (super.noSuchMethod(
        Invocation.method(#getAvailableQuestionCount, [], {
          #categoryIds: categoryIds,
          #difficulty: difficulty,
        }),
        returnValue: Future<int>.value(0),
      ) as Future<int>);

  @override
  Future<bool> validateEntry(String uid, Difficulty difficulty) => (super.noSuchMethod(
        Invocation.method(#validateEntry, [uid, difficulty]),
        returnValue: Future<bool>.value(true),
      ) as Future<bool>);

  @override
  Future<void> reserveEntryFee(String uid, String sessionId, Difficulty difficulty, {bool isFree = false}) => (super.noSuchMethod(
        Invocation.method(#reserveEntryFee, [uid, sessionId, difficulty], {#isFree: isFree}),
        returnValue: Future<void>.value(),
      ) as Future<void>);

  @override
  Future<void> createCompetitiveSession(CompetitiveSession session) => (super.noSuchMethod(
        Invocation.method(#createCompetitiveSession, [session]),
        returnValue: Future<void>.value(),
      ) as Future<void>);
}

class MockCategoryRepository extends Mock implements CategoryRepository {
  @override
  Future<List<Category>> getCategories() => (super.noSuchMethod(
        Invocation.method(#getCategories, []),
        returnValue: Future<List<Category>>.value([]),
      ) as Future<List<Category>>);
}

void main() {
  group('ProLobbyNotifier Tests', () {
    late MockProModeRepository mockRepo;
    late MockCategoryRepository mockCategoryRepo;
    late ProviderContainer container;

    final mockPlayer = PlayerProfile(
      uid: 'uid123',
      displayName: 'Test Player',
      email: 'test@soteria.app',
      coins: 500,
      level: 10,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    setUp(() {
      mockRepo = MockProModeRepository();
      mockCategoryRepo = MockCategoryRepository();
      
      when(mockRepo.getAvailableQuestionCount(
        categoryIds: anyNamed('categoryIds'),
        difficulty: Difficulty.medium,
      )).thenAnswer((_) async => 100);

      when(mockCategoryRepo.getCategories()).thenAnswer((_) async => []);
    });

    ProviderContainer createContainer({PlayerProfile? player, ProModeRepository? repo, int level = 10}) {
      return ProviderContainer(
        overrides: [
          proModeRepositoryProvider.overrideWithValue(repo ?? mockRepo),
          currentPlayerProvider.overrideWithValue(player ?? mockPlayer),
          configurationProvider.overrideWithValue(AppConfiguration.defaults()),
          categoryRepositoryProvider.overrideWithValue(mockCategoryRepo),
          currentCompetitiveLevelProvider.overrideWithValue(level),
        ],
      );
    }

    test('initial availability check is performed on build', () async {
      container = createContainer();
      
      // Build the notifier
      container.read(proLobbyProvider);
      
      // Wait for microtask
      await Future.delayed(Duration.zero);

      final state = container.read(proLobbyProvider);
      expect(state.access.state, ProModeAccessState.available);
      verify(mockRepo.getAvailableQuestionCount(
        categoryIds: null,
        difficulty: Difficulty.medium,
      )).called(1);
    });

    test('insufficient content is detected on lobby entry', () async {
      when(mockRepo.getAvailableQuestionCount(
        categoryIds: anyNamed('categoryIds'),
        difficulty: Difficulty.medium,
      )).thenAnswer((_) async => 5);

      container = createContainer();
      container.read(proLobbyProvider);
      await Future.delayed(Duration.zero);

      final state = container.read(proLobbyProvider);
      expect(state.access.state, ProModeAccessState.insufficientContent);
      expect(state.validationError, contains('ONLY 5 QUESTIONS AVAILABLE'));
    });

    test('updating question count updates fee', () {
      container = createContainer();
      final notifier = container.read(proLobbyProvider.notifier);
      notifier.updateQuestionCount(30);

      final state = container.read(proLobbyProvider);
      expect(state.config.questionCount, 30);
      expect(state.config.entryFee, 500);
    });

    test('insufficient coins detection works', () {
      final lowCoinPlayer = mockPlayer.copyWith(coins: 50);
      container = createContainer(player: lowCoinPlayer);

      final state = container.read(proLobbyProvider);
      expect(state.hasInsufficientCoins, true);
    });

    test('level requirement validation works', () {
      container = createContainer(level: 1);

      final state = container.read(proLobbyProvider);
      expect(state.validationError, contains('MINIMUM LEVEL'));
    });

    test('validation error is cleared when switching question count (fee)', () async {
      final lowCoinPlayer = mockPlayer.copyWith(coins: 150);
      container = createContainer(player: lowCoinPlayer);
      
      final notifier = container.read(proLobbyProvider.notifier);
      
      // 1. Set to 20 questions (fee 250, player has 150)
      notifier.updateQuestionCount(20);
      var state = container.read(proLobbyProvider);
      expect(state.hasInsufficientCoins, true);
      
      // 2. Set back to 10 questions (fee 100)
      notifier.updateQuestionCount(10);
      state = container.read(proLobbyProvider);
      expect(state.hasInsufficientCoins, false);
      expect(state.validationError, isNull);
    });
  });
}
