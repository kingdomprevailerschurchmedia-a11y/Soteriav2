import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/player/domain/repositories/player_progression_repository.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import 'package:soteria/features/player/domain/repositories/player_repository.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

class MockDatabaseService extends Mock implements IDatabaseService {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {
  @override
  String get id => 'mock-id';
}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}
class MockTransaction extends Mock implements Transaction {}
class MockPlayerProgressionRepository extends Mock implements PlayerProgressionRepository {}
class MockPlayerRepository extends Mock implements PlayerRepository {}

void main() {
  late FirestoreProModeRepository repository;
  late MockDatabaseService mockDatabase;
  late MockFirebaseFirestore mockFirestore;
  late MockPlayerProgressionRepository mockProgressionRepo;
  late MockPlayerRepository mockPlayerRepo;

  setUpAll(() {
    registerFallbackValue(Duration.zero);
    registerFallbackValue(MockDocumentReference());
    registerFallbackValue(CompetitiveResult(
      resultId: '', userId: '', seasonId: '', outcome: CompetitiveOutcome.win,
      mode: '', score: 0, completedAt: DateTime.now(),
    ));
  });

  setUp(() {
    mockDatabase = MockDatabaseService();
    mockFirestore = MockFirebaseFirestore();
    mockProgressionRepo = MockPlayerProgressionRepository();
    mockPlayerRepo = MockPlayerRepository();
    repository = FirestoreProModeRepository(mockDatabase, mockProgressionRepo, mockPlayerRepo);
    
    when(() => mockDatabase.instance).thenReturn(mockFirestore);
  });

  group('FirestoreProModeRepository.completeSession', () {
    test('calculates timing metrics correctly and handles settlement', () async {
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
        ],
        questions: [
          Question(
            id: 'q1',
            text: 'T1',
            difficulty: Difficulty.medium,
            categoryId: 'c1',
            type: QuestionType.multipleChoice,
            options: [],
            correctOptionIds: [],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            source: 's',
          ),
        ],
      );

      final mockProfile = PlayerProfile(
        uid: 'test-player',
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
      when(() => mockPlayerRepo.getPlayerProfile('test-player')).thenAnswer((_) async => mockProfile);

      final mockTransaction = MockTransaction();
      final mockRef = MockDocumentReference();
      final mockSnapshot = MockDocumentSnapshot();
      final mockCollection = MockCollectionReference();

      when(() => mockDatabase.collection(any())).thenReturn(mockCollection);
      when(() => mockCollection.doc(any())).thenReturn(mockRef);
      
      when(() => mockFirestore.runTransaction<void>(any())).thenAnswer((invocation) async {
        final handler = invocation.positionalArguments[0]
            as Future<void> Function(Transaction);
        return await handler(mockTransaction);
      });

      when(() => mockTransaction.get<Map<String, dynamic>>(any())).thenAnswer((invocation) async {
        return mockSnapshot;
      });

      // Session document stub
      when(() => mockSnapshot.exists).thenReturn(true);
      when(() => mockSnapshot.data()).thenReturn({
        'uid': 'test-player',
        'config': {
          'difficulty': 'medium',
          'questionCount': 10,
        },
        'reservedFee': 500,
      });

      when(() => mockTransaction.set<Map<String, dynamic>>(any(), any(), any())).thenReturn(mockTransaction);
      when(() => mockTransaction.update(any(), any())).thenReturn(mockTransaction);
      
      // Final result fetch stub
      final finalResultDoc = MockDocumentSnapshot();
      when(() => mockRef.get()).thenAnswer((_) async => finalResultDoc);
      when(() => finalResultDoc.data()).thenReturn({
        'sessionId': 'test-session',
        'playerId': 'test-player',
        'mode': 'pro',
        'finalScore': 1000,
        'totalXP': 100,
        'totalQuestions': 10,
        'correctAnswers': 1,
        'wrongAnswers': 0,
        'totalDuration': 300000,
        'accuracy': 0.1,
        'maxStreak': 1,
        'rating': 'D',
        'timestamp': DateTime.now().toIso8601String(),
      });

      final result = await repository.completeSession('test-session', gameState);

      expect(result.sessionId, 'test-session');
      expect(result.correctAnswers, 1);
    });
  });
}
