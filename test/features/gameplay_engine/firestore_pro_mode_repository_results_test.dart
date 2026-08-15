import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/player/domain/repositories/player_progression_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MockIDatabaseService extends Mock implements IDatabaseService {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}
class MockPlayerProgressionRepository extends Mock implements PlayerProgressionRepository {}

void main() {
  late MockIDatabaseService mockDatabase;
  late MockPlayerProgressionRepository mockProgressionRepo;
  late FirestoreProModeRepository repository;

  setUpAll(() {
    registerFallbackValue(GameState(playerId: '', sessionId: ''));
  });

  setUp(() {
    mockDatabase = MockIDatabaseService();
    mockProgressionRepo = MockPlayerProgressionRepository();
    repository = FirestoreProModeRepository(mockDatabase, mockProgressionRepo);
  });

  group('FirestoreProModeRepository Authoritative Results', () {
    test('completeSession calculates timing metrics correctly', () async {
      final startTime = DateTime(2026, 1, 1, 10, 0, 0);
      final gameState = GameState(
        playerId: 'test-player',
        sessionId: 'session-123',
        lifecycle: GameLifecycle.completed,
        startTime: startTime,
        lastAnswerTime: startTime.add(const Duration(seconds: 100)),
        questions: [
          Question(
            id: 'q1',
            text: 'Q1',
            difficulty: Difficulty.easy,
            categoryId: 'cat',
            type: QuestionType.multipleChoice,
            options: const [],
            correctOptionIds: const ['o1'],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            source: 'test',
          ),
        ],
        answerHistory: [
          AnswerResult(
            submissionId: 's1',
            questionId: 'q1',
            decision: AnswerDecision.correct,
            correctOptionIds: ['o1'],
            timestamp: startTime.add(const Duration(seconds: 10)),
            responseTime: const Duration(seconds: 10),
          ),
        ],
        score: 1000,
        xp: 100,
      );

      final mockFirestore = MockFirebaseFirestore();
      when(() => mockDatabase.instance).thenReturn(mockFirestore);
      
      final mockSessionRef = MockDocumentReference();
      final mockCollection = MockCollectionReference();

      when(() => mockDatabase.collection(any())).thenReturn(mockCollection);
      when(() => mockCollection.doc(any())).thenReturn(mockSessionRef);

      when(() => mockFirestore.runTransaction<dynamic>(any())).thenAnswer((invocation) async {
        return null;
      });

      final result = await repository.completeSession('session-123', gameState);

      expect(result.accuracy, 1.0);
      expect(result.correctAnswers, 1);
    });
  });
}
