import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import 'package:soteria/features/quiz/domain/models/quiz_session.dart';
import 'package:soteria/features/quiz/presentation/providers/quiz_providers.dart';

void main() {
  group('QuizSessionPersistence Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() => container.dispose());

    test('Saves and loads a quiz session correctly', () async {
      final repository = container.read(quizSessionRepositoryProvider);

      final session = QuizSession(
        sessionId: 's1',
        playerId: 'p1',
        gameMode: GameMode.practice,
        category: 'Science',
        difficulty: Difficulty.easy,
        startedTime: DateTime.now(),
        sessionStatus: SessionStatus.active,
        questionIds: ['q1', 'q2'],
      );

      await repository.saveSession(session);

      final loaded = await repository.loadSession('s1');
      expect(loaded, isNotNull);
      expect(loaded!.sessionId, equals('s1'));
      expect(loaded.playerId, equals('p1'));
      expect(loaded.questionIds, contains('q1'));
    });

    test('Loads active session for a specific player', () async {
      final repository = container.read(quizSessionRepositoryProvider);

      final session = QuizSession(
        sessionId: 's2',
        playerId: 'p2',
        gameMode: GameMode.practice,
        category: 'History',
        difficulty: Difficulty.medium,
        startedTime: DateTime.now(),
        sessionStatus: SessionStatus.active,
      );

      await repository.saveSession(session);

      final active = await repository.loadActiveSession('p2');
      expect(active, isNotNull);
      expect(active!.sessionId, equals('s2'));
    });

    test('Deletes a session correctly', () async {
      final repository = container.read(quizSessionRepositoryProvider);

      final session = QuizSession(
        sessionId: 's3',
        playerId: 'p3',
        gameMode: GameMode.practice,
        category: 'Math',
        difficulty: Difficulty.hard,
        startedTime: DateTime.now(),
      );

      await repository.saveSession(session);
      await repository.deleteSession('s3');

      final loaded = await repository.loadSession('s3');
      expect(loaded, isNull);
    });
  });
}
