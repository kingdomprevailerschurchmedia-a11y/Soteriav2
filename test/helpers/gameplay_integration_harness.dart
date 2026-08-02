import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';

class GameplayIntegrationHarness {
  static List<Question> generateMockQuestions(int count) {
    return List.generate(
      count,
      (index) => Question(
        id: 'q_$index',
        version: '1',
        text: 'Mock Question #$index',
        options: const [
          Answer(id: 'a', text: 'Option A (Correct)'),
          Answer(id: 'b', text: 'Option B'),
          Answer(id: 'c', text: 'Option C'),
          Answer(id: 'd', text: 'Option D'),
        ],
        correctAnswers: const ['a'],
        difficulty: QuestionDifficulty.medium,
        category: 'General',
        type: QuestionType.multipleChoice,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Mock',
        schemaVersion: 1,
        contentHash: 'hash_$index',
      ),
    );
  }

  static GameConfiguration createTestConfig({
    GameMode mode = GameMode.pro,
    Duration? questionTimer = const Duration(seconds: 30),
  }) {
    return GameConfiguration(
      mode: mode,
      initialLives: 3,
      questionTimer: questionTimer,
    );
  }
}
