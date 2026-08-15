import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/core/firebase/config/models/app_configuration.dart';
import 'package:soteria/core/firebase/config/providers/configuration_providers.dart';
import 'package:soteria/features/dashboard/presentation/providers/pro_lobby_providers.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/pro_mode_repository.dart';
import 'package:soteria/features/gameplay_engine/models/competitive_session.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

class ManualMockProModeRepository implements ProModeRepository {
  @override
  Future<void> createCompetitiveSession(CompetitiveSession session) async {}

  @override
  Future<void> reserveEntryFee(String uid, String sessionId, int fee) async {}

  @override
  Future<bool> validateEntry(String uid, int fee) async => true;

  @override
  Future<int> getAvailableQuestionCount({
    String? categoryId,
    required Difficulty difficulty,
  }) async => 100;
}

void main() {
  group('ProLobbyNotifier Tests', () {
    late ManualMockProModeRepository mockRepo;
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
      mockRepo = ManualMockProModeRepository();
      container = ProviderContainer(
        overrides: [
          proModeRepositoryProvider.overrideWithValue(mockRepo),
          currentPlayerProvider.overrideWithValue(mockPlayer),
          configurationProvider.overrideWithValue(AppConfiguration.defaults()),
        ],
      );
    });

    test('initial state is correct', () {
      final state = container.read(proLobbyProvider);
      expect(state.config.entryFee, 100);
      expect(state.hasInsufficientCoins, false);
      expect(state.validationError, isNull);
    });

    test('updating question count updates fee', () {
      final notifier = container.read(proLobbyProvider.notifier);
      notifier.updateQuestionCount(30);

      final state = container.read(proLobbyProvider);
      expect(state.config.questionCount, 30);
      expect(state.config.entryFee, 500);
    });

    test('insufficient coins detection works', () {
      final lowCoinPlayer = mockPlayer.copyWith(coins: 50);
      final container2 = ProviderContainer(
        overrides: [
          proModeRepositoryProvider.overrideWithValue(mockRepo),
          currentPlayerProvider.overrideWithValue(lowCoinPlayer),
          configurationProvider.overrideWithValue(AppConfiguration.defaults()),
        ],
      );

      final state = container2.read(proLobbyProvider);
      expect(state.hasInsufficientCoins, true);
    });

    test('level requirement validation works', () {
      final lowLevelPlayer = mockPlayer.copyWith(level: 1);
      final container2 = ProviderContainer(
        overrides: [
          proModeRepositoryProvider.overrideWithValue(mockRepo),
          currentPlayerProvider.overrideWithValue(lowLevelPlayer),
          configurationProvider.overrideWithValue(AppConfiguration.defaults()),
        ],
      );

      final state = container2.read(proLobbyProvider);
      expect(state.validationError, contains('MINIMUM LEVEL'));
    });
  });
}
