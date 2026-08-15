import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@GenerateNiceMocks([
  MockSpec<IDatabaseService>(),
  MockSpec<FirebaseFirestore>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<DocumentSnapshot<Map<String, dynamic>>>(),
])
import 'firestore_pro_mode_repository_results_test.mocks.dart';

void main() {
  late MockIDatabaseService mockDatabase;
  late FirestoreProModeRepository repository;

  setUp(() {
    mockDatabase = MockIDatabaseService();
    repository = FirestoreProModeRepository(mockDatabase);
  });

  group('FirestoreProModeRepository Authoritative Results', () {
    test('completeSession calculates timing metrics correctly', () async {
      final startTime = DateTime(2026, 1, 1, 10, 0, 0);
      final gameState = GameState(
        sessionId: 'session-123',
        lifecycle: GameLifecycle.completed,
        startTime: startTime,
        lastAnswerTime: startTime.add(const Duration(seconds: 100)),
        questions: [
          Question(id: 'q1', text: 'Q1', difficulty: Difficulty.easy, options: []),
          Question(id: 'q2', text: 'Q2', difficulty: Difficulty.medium, options: []),
          Question(id: 'q3', text: 'Q3', difficulty: Difficulty.hard, options: []),
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
          AnswerResult(
            submissionId: 's2',
            questionId: 'q2',
            decision: AnswerDecision.wrong,
            correctOptionIds: ['o2'],
            timestamp: startTime.add(const Duration(seconds: 40)),
            responseTime: const Duration(seconds: 30),
          ),
          AnswerResult(
            submissionId: 's3',
            questionId: 'q3',
            decision: AnswerDecision.correct,
            correctOptionIds: ['o3'],
            timestamp: startTime.add(const Duration(seconds: 60)),
            responseTime: const Duration(seconds: 20),
          ),
        ],
        score: 1000,
        xp: 100,
      );

      // Mock database calls for transaction
      final mockFirestore = MockFirebaseFirestore();
      when(mockDatabase.instance).thenReturn(mockFirestore);
      
      final mockSessionRef = MockDocumentReference();
      final mockResultRef = MockDocumentReference();
      final mockPlayerRef = MockDocumentReference();
      final mockCollection = MockCollectionReference();

      when(mockDatabase.collection('competitive_sessions')).thenReturn(mockCollection);
      when(mockDatabase.collection('pro_results')).thenReturn(mockCollection);
      when(mockDatabase.collection('players')).thenReturn(mockCollection);
      
      when(mockCollection.doc('session-123')).thenReturn(mockSessionRef);
      when(mockCollection.doc(any)).thenReturn(mockPlayerRef);

      // Mock transaction
      when(mockFirestore.runTransaction<dynamic>(any)).thenAnswer((invocation) async {
        // We just need it to not throw for this test focusing on calculation
        return null;
      });

      final result = await repository.completeSession('session-123', gameState);

      expect(result.accuracy, 2/3);
      expect(result.correctAnswers, 2);
      expect(result.wrongAnswers, 1);
      expect(result.fastestAnswerTime, const Duration(seconds: 10));
      expect(result.slowestAnswerTime, const Duration(seconds: 30));
      expect(result.avgResponseTime, const Duration(seconds: 20)); // (10+30+20)/3 = 20
    });
  });
}
