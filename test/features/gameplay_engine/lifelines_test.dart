import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/lifelines/services/fifty_fifty_engine.dart';
import 'package:soteria/features/gameplay_engine/lifelines/services/audience_simulation_strategy.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';

void main() {
  final mockQuestion = Question(
    id: 'q1',
    version: '1',
    text: 'Test?',
    difficulty: QuestionDifficulty.easy,
    category: 'C',
    type: QuestionType.multipleChoice,
    options: const [
      Answer(id: 'a', text: 'Ans A'),
      Answer(id: 'b', text: 'Ans B'),
      Answer(id: 'c', text: 'Ans C'),
      Answer(id: 'd', text: 'Ans D'),
    ],
    correctAnswers: const ['a'],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    source: 'S',
    schemaVersion: 1,
    contentHash: 'H',
  );

  group('FiftyFiftyEngine Tests', () {
    test('removes exactly two incorrect answers', () async {
      final engine = FiftyFiftyEngine();
      final hiddenIds = await engine.activate(question: mockQuestion);

      expect(hiddenIds.length, 2);
      expect(hiddenIds, isNot(contains('a'))); // Correct answer remains
      expect(['b', 'c', 'd'], containsAll(hiddenIds));
    });

    test('is deterministic for the same question ID', () async {
      final engine = FiftyFiftyEngine();
      final hiddenIds1 = await engine.activate(question: mockQuestion);
      final hiddenIds2 = await engine.activate(question: mockQuestion);

      expect(hiddenIds1, equals(hiddenIds2));
    });
  });

  group('DifficultyBasedSimulationStrategy Tests', () {
    test('easy questions have high audience accuracy', () {
      final strategy = DifficultyBasedSimulationStrategy();
      final results = strategy.simulate(mockQuestion); // Easy

      expect(results['a'], greaterThanOrEqualTo(0.85));
      expect(results['a'], lessThanOrEqualTo(0.95));
    });

    test('is deterministic for the same question ID', () {
      final strategy = DifficultyBasedSimulationStrategy();
      final results1 = strategy.simulate(mockQuestion);
      final results2 = strategy.simulate(mockQuestion);

      expect(results1, equals(results2));
    });

    test('expert questions have lower audience accuracy', () {
      final strategy = DifficultyBasedSimulationStrategy();
      final expertQuestion = Question(
        id: 'q_expert',
        version: '1',
        text: 'Expert?',
        difficulty: QuestionDifficulty.expert,
        category: 'C',
        type: QuestionType.multipleChoice,
        options: mockQuestion.options,
        correctAnswers: ['a'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'S',
        schemaVersion: 1,
        contentHash: 'H',
      );

      final results = strategy.simulate(expertQuestion);
      expect(results['a'], greaterThanOrEqualTo(0.30));
      expect(results['a'], lessThanOrEqualTo(0.50));
    });
  });
}
