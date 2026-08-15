import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soteria/core/firebase/config/models/app_configuration.dart';
import 'package:soteria/core/firebase/config/providers/configuration_providers.dart';
import 'package:soteria/features/dashboard/presentation/providers/pro_lobby_providers.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/pro_mode_repository.dart';
import 'package:soteria/features/gameplay_engine/models/competitive_session.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/pro_mode_result.dart';
import 'package:soteria/features/gameplay_engine/models/pro_mode_access.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

class MockProModeRepository extends Mock implements ProModeRepository {
  @override
  Future<int> getAvailableQuestionCount({
    String? categoryId,
    required Difficulty difficulty,
  }) => (super.noSuchMethod(
        Invocation.method(#getAvailableQuestionCount, [], {
          #categoryId: categoryId,
          #difficulty: difficulty,
        }),
        returnValue: Future<int>.value(0),
      ) as Future<int>);
}

void main() {
  group('ProLobbyNotifier Tests', () {
    late MockProModeRepository mockRepo;
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
      
      when(mockRepo.getAvailableQuestionCount(
        categoryId: anyNamed('categoryId'),
        difficulty: Difficulty.medium,
      )).thenAnswer((_) async => 100);
    });

    ProviderContainer createContainer({PlayerProfile? player, ProModeRepository? repo}) {
      return ProviderContainer(
        overrides: [
          proModeRepositoryProvider.overrideWithValue(repo ?? mockRepo),
          currentPlayerProvider.overrideWithValue(player ?? mockPlayer),
          configurationProvider.overrideWithValue(AppConfiguration.defaults()),
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
        categoryId: null,
        difficulty: Difficulty.medium,
      )).called(1);
    });

    test('insufficient content is detected on lobby entry', () async {
      when(mockRepo.getAvailableQuestionCount(
        categoryId: anyNamed('categoryId'),
        difficulty: Difficulty.medium,
      )).thenAnswer((_) async => 5);

      container = createContainer();
      container.read(proLobbyProvider);
      await Future.delayed(Duration.zero);

      final state = container.read(proLobbyProvider);
      expect(state.access.state, ProModeAccessState.insufficientContent);
      expect(state.validationError, contains('Not enough questions'));
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
      final lowLevelPlayer = mockPlayer.copyWith(level: 1);
      container = createContainer(player: lowLevelPlayer);

      final state = container.read(proLobbyProvider);
      expect(state.validationError, contains('MINIMUM LEVEL'));
    });
  });
}
