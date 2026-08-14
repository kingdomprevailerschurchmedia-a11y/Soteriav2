import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/providers/competitive_gameplay_providers.dart';

import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

class MockGameEngine extends GameEngine {
  MockGameEngine(GameState initialState)
    : super(config: const GameConfiguration(mode: GameMode.pro)) {
    state = initialState;
  }
}

void main() {
  group('CompetitiveRewardProvider Tests', () {
    test('calculates rewards correctly for expert match', () {
      final config = const GameConfiguration(
        mode: GameMode.pro,
        difficultyMultiplier: 2.0,
      );

      final state = GameState(
        sessionId: 'test',
        score: 1000,
        questions: List.generate(
          10,
          (i) => Question(
            id: '$i',
            version: '1',
            text: 'T',
            options: [
              const Answer(id: 'o1', text: 'A'),
              const Answer(id: 'o2', text: 'B'),
            ],
            correctOptionIds: ['o1'],
            difficulty: Difficulty.easy,
            categoryId: 'C',
            type: QuestionType.multipleChoice,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            source: 'S',
            schemaVersion: 1,
            contentHash: 'H',
          ),
        ),
        metadata: {'reservedFee': 500},
      );

      final container = ProviderContainer(
        overrides: [
          gameEngineProvider(
            config,
          ).overrideWith((ref) => MockGameEngine(state)),
        ],
      );

      final rewards = container.read(competitiveRewardProvider(config));

      // Potential = (500 * 2 * 2.0 * 1.2) = 2400
      expect(rewards['potentialReward'], 2400);
      expect(rewards['coinsAtRisk'], 500);
      expect(rewards['isWinZone'], true);
    });
  });
}
