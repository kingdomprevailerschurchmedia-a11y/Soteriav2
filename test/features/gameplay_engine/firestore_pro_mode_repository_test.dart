import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/player/domain/repositories/player_progression_repository.dart';
import 'package:soteria/features/player/domain/models/xp_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

class MockDatabaseService extends Mock implements IDatabaseService {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}
class MockPlayerProgressionRepository extends Mock implements PlayerProgressionRepository {
  @override
  Future<void> applyXpTransaction(XpTransaction transaction) async {}
}

void main() {
  late FirestoreProModeRepository repository;
  late MockDatabaseService mockDatabase;
  late MockFirebaseFirestore mockFirestore;
  late MockPlayerProgressionRepository mockProgressionRepo;

  setUp(() {
    mockDatabase = MockDatabaseService();
    mockFirestore = MockFirebaseFirestore();
    mockProgressionRepo = MockPlayerProgressionRepository();
    repository = FirestoreProModeRepository(mockDatabase, mockProgressionRepo);
    
    when(() => mockDatabase.instance).thenReturn(mockFirestore);
  });

  group('FirestoreProModeRepository.completeSession', () {
    test('calculates timing metrics correctly from answer history', () async {
      final startTime = DateTime(2026, 8, 14, 10, 0, 0);
      final lastAnswerTime = DateTime(2026, 8, 14, 10, 5, 0);
      
      final gameState = GameState(
        playerId: 'test-player',
      sessionId: 'test-session',
        startTime: startTime,
        lastAnswerTime: lastAnswerTime,
        score: 1000,
        xp: 100,
        streak: 5,
        answerHistory: [
          AnswerResult(
            submissionId: 's1',
            questionId: 'q1',
            decision: AnswerDecision.correct,
            correctOptionIds: ['o1'],
            timestamp: startTime.add(const Duration(seconds: 10)),
            responseTime: const Duration(seconds: 5),
          ),
          AnswerResult(
            submissionId: 's2',
            questionId: 'q2',
            decision: AnswerDecision.wrong,
            correctOptionIds: ['o2'],
            timestamp: startTime.add(const Duration(seconds: 30)),
            responseTime: const Duration(seconds: 15),
          ),
          AnswerResult(
            submissionId: 's3',
            questionId: 'q3',
            decision: AnswerDecision.correct,
            correctOptionIds: ['o3'],
            timestamp: startTime.add(const Duration(seconds: 60)),
            responseTime: const Duration(seconds: 10),
          ),
        ],
        questions: List.generate(5, (index) => Question(
          id: 'q$index',
          text: 'T$index',
          difficulty: Difficulty.medium,
          categoryId: 'c',
          type: QuestionType.multipleChoice,
          options: [],
          correctOptionIds: [],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          source: 's',
        )), // 5 total, 3 answered, 2 skipped
      );

      // We need to mock the transaction to test the persistence part, 
      // but here we focus on the result calculation logic.
      // Since completeSession is async and calls runTransaction, we need to mock that.
      
      when(() => mockFirestore.runTransaction<dynamic>(any())).thenAnswer((invocation) async {
        return null;
      });

      final result = await repository.completeSession('test-session', gameState);

      expect(result.avgResponseTime.inSeconds, 10); // (5 + 15 + 10) / 3 = 10
      expect(result.fastestAnswerTime.inSeconds, 5);
      expect(result.slowestAnswerTime.inSeconds, 15);
      expect(result.correctAnswers, 2);
      expect(result.wrongAnswers, 1);
      expect(result.skippedQuestions, 2);
      expect(result.totalQuestions, 5);
      expect(result.accuracy, 0.4); // 2 / 5
    });
  });
}

class MockQuestion extends Mock implements dynamic {
  // Mock properties if needed, but GameState only needs them for length here
}
