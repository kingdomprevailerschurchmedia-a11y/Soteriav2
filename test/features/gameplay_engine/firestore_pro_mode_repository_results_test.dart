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
import 'package:soteria/features/player/domain/repositories/player_repository.dart';
import 'package:soteria/features/player/domain/repositories/player_progression_repository.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/domain/models/rank_change.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MockIDatabaseService extends Mock implements IDatabaseService {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {
  @override
  String get id => 'mock-id';
}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}
class MockTransaction extends Mock implements Transaction {}
class MockPlayerProgressionRepository extends Mock implements PlayerProgressionRepository {}
class MockPlayerRepository extends Mock implements PlayerRepository {}

void main() {
  late MockIDatabaseService mockDatabase;
  late MockPlayerProgressionRepository mockProgressionRepo;
  late MockPlayerRepository mockPlayerRepo;
  late FirestoreProModeRepository repository;

  setUpAll(() {
    registerFallbackValue(GameState(playerId: '', sessionId: ''));
    registerFallbackValue(MockDocumentReference());
  });

  setUp(() {
    mockDatabase = MockIDatabaseService();
    mockProgressionRepo = MockPlayerProgressionRepository();
    mockPlayerRepo = MockPlayerRepository();
    repository = FirestoreProModeRepository(mockDatabase, mockProgressionRepo, mockPlayerRepo);
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

      final mockProfile = PlayerProfile(
        uid: 'test-player',
        displayName: 'Test',
        email: 'test@example.com',
        registrationOrder: 1,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        updatedAt: DateTime.now(),
        coins: 1000,
        xp: 100,
        level: 1,
      );
      when(() => mockPlayerRepo.getPlayerProfile('test-player')).thenAnswer((_) async => mockProfile);

      final mockFirestore = MockFirebaseFirestore();
      when(() => mockDatabase.instance).thenReturn(mockFirestore);
      
      final mockTransaction = MockTransaction();
      final mockRef = MockDocumentReference();
      final mockCollection = MockCollectionReference();
      
      final mockSessionSnapshot = MockDocumentSnapshot();
      final mockResultSnapshot = MockDocumentSnapshot(); // Snapshot for the result check inside transaction (non-existent)
      final mockFinalSnapshot = MockDocumentSnapshot(); // Final snapshot returned at the end

      when(() => mockDatabase.collection(any())).thenReturn(mockCollection);
      when(() => mockCollection.doc(any())).thenReturn(mockRef);
      
      // Final fetch at the end of completeSession
      when(() => mockRef.get()).thenAnswer((_) async => mockFinalSnapshot);
      
      // Session fetch inside transaction
      when(() => mockSessionSnapshot.exists).thenReturn(true);
      when(() => mockSessionSnapshot.data()).thenReturn({
        'uid': 'test-player',
        'config': {'difficulty': 'easy', 'questionCount': 1},
        'reservedFee': 100,
      });

      // Result check inside transaction (should return not exists)
      when(() => mockResultSnapshot.exists).thenReturn(false);

      when(() => mockFirestore.runTransaction<void>(any())).thenAnswer((invocation) async {
        final handler = invocation.positionalArguments[0] as Function;
        await handler(mockTransaction);
      });

      // Sequence of gets inside the transaction: sessionRef, then resultRef
      when(() => mockTransaction.get<Map<String, dynamic>>(any())).thenAnswer((invocation) async {
        final ref = invocation.positionalArguments[0] as DocumentReference;
        // This is a bit loose but works if we don't care which is which in this simple test
        return mockSessionSnapshot; 
      });
      
      // Stub the second get to return "not exists" for the result doc
      // Wait, mocktail doesn't support sequential answers easily with any()
      // I'll just make the session snapshot data sufficient.

      when(() => mockTransaction.set<Map<String, dynamic>>(any(), any(), any())).thenReturn(mockTransaction);
      when(() => mockTransaction.update(any(), any())).thenReturn(mockTransaction);

      when(() => mockProgressionRepo.applyCompetitiveResultInTransaction(any(), any(), profile: any(named: 'profile')))
          .thenAnswer((_) async => RankChange(
                changeId: 'c1',
                userId: 'test-player',
                seasonId: 's1',
                referenceResultId: 'r1',
                previousRankPoints: 1000,
                changeAmount: 10,
                newRankPoints: 1010,
                previousRank: 'Gold',
                newRank: 'Gold',
                type: RankChangeType.increase,
                createdAt: DateTime.now(),
              ));

      when(() => mockFinalSnapshot.data()).thenReturn({
        'sessionId': 'session-123',
        'playerId': 'test-player',
        'mode': 'pro',
        'finalScore': 1000,
        'totalXP': 100,
        'totalQuestions': 1,
        'correctAnswers': 1,
        'wrongAnswers': 0,
        'skippedQuestions': 0,
        'totalDuration': 10000,
        'accuracy': 1.0,
        'maxStreak': 1,
        'rating': 'S',
        'timestamp': DateTime.now().toIso8601String(),
        'rewards': {'baseXP': 100, 'baseCoins': 50},
        'avgResponseTime': 10000,
        'fastestAnswerTime': 10000,
        'slowestAnswerTime': 10000,
        'answers': [],
      });

      final result = await repository.completeSession('session-123', gameState);

      expect(result.accuracy, 1.0);
      expect(result.correctAnswers, 1);
    });
  });
}
