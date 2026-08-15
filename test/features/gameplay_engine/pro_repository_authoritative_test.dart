import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FakeDatabaseService extends Fake implements IDatabaseService {
  @override
  ICollectionReference collection(String path) => FakeCollectionReference();

  @override
  FirebaseFirestore get instance => FakeFirebaseFirestore();
}

class FakeFirebaseFirestore extends Fake implements FirebaseFirestore {
  @override
  Future<T> runTransaction<T>(TransactionHandler<T> transactionHandler, {Duration timeout = const Duration(seconds: 30), int maxAttempts = 5}) async {
    return await transactionHandler(FakeTransaction());
  }
}

class FakeTransaction extends Fake implements Transaction {
  @override
  Future<DocumentSnapshot<T>> get<T>(DocumentReference<T> documentReference) async {
    return FakeDocumentSnapshot<T>();
  }

  @override
  void set<T>(DocumentReference<T> documentReference, T data, [SetOptions? options]) {}
  
  @override
  void update(DocumentReference<dynamic> documentReference, Map<String, dynamic> data) {}
}

class FakeDocumentSnapshot<T> extends Fake implements DocumentSnapshot<T> {
  @override
  bool get exists => true;
  @override
  Map<String, dynamic>? data() => {'uid': 'user-123'};
}

class FakeCollectionReference extends Fake implements ICollectionReference {
  @override
  IDocumentReference doc([String? path]) => FakeDocumentReference();
}

class FakeDocumentReference extends Fake implements IDocumentReference {
  @override
  Future<IDocumentSnapshot> get([GetOptions? options]) async => FakeIDocumentSnapshot();
}

class FakeIDocumentSnapshot extends Fake implements IDocumentSnapshot {
  @override
  bool get exists => true;
  @override
  Map<String, dynamic>? data() => {'uid': 'user-123'};
}

void main() {
  late FakeDatabaseService fakeDatabase;
  late FirestoreProModeRepository repository;

  setUp(() {
    fakeDatabase = FakeDatabaseService();
    repository = FirestoreProModeRepository(fakeDatabase);
  });

  group('FirestoreProModeRepository Authoritative Tests', () {
    test('completeSession recalculates score and XP independently of client input', () async {
      final now = DateTime.now();
      final question = Question(
        id: 'q1',
        text: 'Test',
        difficulty: Difficulty.hard,
        categoryId: 'cat1',
        type: QuestionType.multipleChoice,
        options: [],
        correctOptionIds: ['o1'],
        createdAt: now,
        updatedAt: now,
        source: 'test',
        estimatedTime: const Duration(seconds: 30),
      );

      final gameState = GameState(
        sessionId: 'session-123',
        questions: [question],
        answerHistory: [
          AnswerResult(
            submissionId: 's1',
            questionId: 'q1',
            decision: AnswerDecision.correct,
            selectedOptionIds: ['o1'],
            correctOptionIds: ['o1'],
            timestamp: now,
            responseTime: const Duration(seconds: 25), // No speed bonus
          ),
        ],
        score: 999999, // FAKE SCORE from client
        xp: 888888, // FAKE XP from client
        startTime: now.subtract(const Duration(minutes: 1)),
        lastAnswerTime: now,
      );

      final result = await repository.completeSession('session-123', gameState);

      // Verify that the finalScore is recalculated (should be 900 for Hard/Correct in Pro)
      expect(result.finalScore, equals(900));
      expect(result.finalScore, isNot(equals(999999)));
      
      // Verify XP (rewards.totalXP includes base + bonus)
      // Hard/Correct Pro XP = 33. Bonus = 900 * 0.05 = 45. Total = 78.
      expect(result.totalXP, equals(78));
      expect(result.totalXP, isNot(equals(888888)));
    });
  });
}
