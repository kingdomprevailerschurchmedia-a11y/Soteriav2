import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/player/domain/repositories/player_progression_repository.dart';
import 'package:soteria/features/player/domain/models/xp_transaction.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import 'package:soteria/features/player/domain/repositories/player_repository.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/domain/models/rank_change.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FakeDatabaseService extends Fake implements IDatabaseService {
  @override
  CollectionReference<Map<String, dynamic>> collection(String path) => FakeCollectionReference();

  @override
  FirebaseFirestore get instance => FakeFirebaseFirestore();
  
  @override
  DocumentReference<Map<String, dynamic>> doc(String path) => FakeDocumentReference();
  
  @override
  Future<void> enablePersistence() async {}
}

class FakeFirebaseFirestore extends Fake implements FirebaseFirestore {
  @override
  Future<T> runTransaction<T>(TransactionHandler<T> transactionHandler, {Duration timeout = const Duration(seconds: 30), int maxAttempts = 5}) async {
    return await transactionHandler(FakeTransaction());
  }
  
  @override
  CollectionReference<Map<String, dynamic>> collection(String path) => FakeCollectionReference();
}

class FakeTransaction extends Fake implements Transaction {
  @override
  Future<DocumentSnapshot<T>> get<T>(DocumentReference<T> documentReference) async {
    return FakeDocumentSnapshot<T>();
  }

  @override
  Transaction set<T>(DocumentReference<T> documentReference, T data, [SetOptions? options]) {
    return this;
  }
  
  @override
  Transaction update(DocumentReference<dynamic> documentReference, Map<Object, Object?> data) {
    return this;
  }
  
  @override
  Transaction delete(DocumentReference<dynamic> documentReference) {
    return this;
  }
}

class FakeDocumentSnapshot<T> extends Fake implements DocumentSnapshot<T> {
  @override
  bool get exists => true;
  @override
  T? data() => {
    'uid': 'user-123',
    'config': {
      'difficulty': 'hard',
      'questionCount': 10,
    },
    'reservedFee': 1000,
  } as T?;
}

class FakeCollectionReference extends Fake implements CollectionReference<Map<String, dynamic>> {
  @override
  DocumentReference<Map<String, dynamic>> doc([String? path]) => FakeDocumentReference();
  
  @override
  AggregateQuery count() => FakeAggregateQuery();
}

class FakeAggregateQuery extends Fake implements AggregateQuery {
  @override
  Future<AggregateQuerySnapshot> get({AggregateSource source = AggregateSource.server}) async => FakeAggregateQuerySnapshot();
}

class FakeAggregateQuerySnapshot extends Fake implements AggregateQuerySnapshot {
  @override
  int? get count => 10;
}

class FakeDocumentReference extends Fake implements DocumentReference<Map<String, dynamic>> {
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> get([GetOptions? options]) async => FakeDocumentSnapshot<Map<String, dynamic>>();
  
  @override
  String get id => 'fake-id';
}

class FakePlayerProgressionRepository extends Fake implements PlayerProgressionRepository {
  @override
  Future<void> applyXpTransaction(XpTransaction transaction) async {}

  @override
  Future<PlayerProgression?> getProgression(String userId) async => null;

  @override
  Future<void> updateProgression(PlayerProgression progression) async {}

  @override
  Future<void> processXpTransaction(dynamic tx, XpTransaction transaction) async {}

  @override
  Future<RankChange> applyCompetitiveResultInTransaction(
    dynamic transaction,
    CompetitiveResult result, {
    PlayerProfile? profile,
  }) async {
    return RankChange(
      changeId: 'id',
      userId: result.userId,
      seasonId: result.seasonId,
      referenceResultId: result.resultId,
      previousRankPoints: 1000,
      changeAmount: 10,
      newRankPoints: 1010,
      previousRank: 'Gold',
      newRank: 'Gold',
      type: RankChangeType.increase,
      createdAt: DateTime.now(),
    );
  }
}

class FakePlayerRepository extends Fake implements PlayerRepository {
  @override
  Future<PlayerProfile?> getPlayerProfile(String uid) async {
    return PlayerProfile(
      uid: uid,
      displayName: 'Test',
      email: 'test@example.com',
      photoUrl: '',
      registrationOrder: 1,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      updatedAt: DateTime.now(),
      coins: 1000,
      xp: 100,
      level: 1,
    );
  }
}

void main() {
  late FakeDatabaseService fakeDatabase;
  late FakePlayerProgressionRepository fakeProgressionRepo;
  late FakePlayerRepository fakePlayerRepo;
  late FirestoreProModeRepository repository;

  setUp(() {
    fakeDatabase = FakeDatabaseService();
    fakeProgressionRepo = FakePlayerProgressionRepository();
    fakePlayerRepo = FakePlayerRepository();
    repository = FirestoreProModeRepository(fakeDatabase, fakeProgressionRepo, fakePlayerRepo);
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
        playerId: 'test-player',
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
      // Hard/Correct Pro XP = 45. Bonus = 900 * 0.05 = 45. Total = 90.
      expect(result.totalXP, equals(90));
      expect(result.totalXP, isNot(equals(888888)));
    });
  });
}
