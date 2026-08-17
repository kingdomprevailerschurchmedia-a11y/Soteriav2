import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/features/gameplay_engine/data/repositories/firestore_competitive_settlement_repository.dart';
import 'package:soteria/features/gameplay_engine/models/competitive_settlement.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/player/domain/repositories/player_progression_repository.dart';

class MockDatabaseService extends Mock implements IDatabaseService {}
class MockFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}
class MockTransaction extends Mock implements Transaction {}
class MockProgressionRepository extends Mock implements PlayerProgressionRepository {}

void main() {
  late FirestoreCompetitiveSettlementRepository repository;
  late MockDatabaseService mockDatabase;
  late MockFirestore mockFirestore;
  late MockProgressionRepository mockProgression;

  setUpAll(() {
    registerFallbackValue(CompetitiveSettlement(
      settlementId: 'test',
      sessionId: 'test',
      uid: 'test',
      result: GameResult(
        sessionId: 'test',
        playerId: 'test',
        mode: GameMode.pro,
        finalScore: 0,
        totalXP: 0,
        totalQuestions: 0,
        correctAnswers: 0,
        wrongAnswers: 0,
        totalDuration: Duration.zero,
        accuracy: 0,
        maxStreak: 0,
        timestamp: DateTime.now(),
      ),
      coinsWagered: 0,
      coinsWon: 0,
      xpEarned: 0,
      timestamp: DateTime.now(),
    ));
    registerFallbackValue(MockDocumentReference());
    registerFallbackValue(Duration.zero);
  });

  setUp(() {
    mockDatabase = MockDatabaseService();
    mockFirestore = MockFirestore();
    mockProgression = MockProgressionRepository();
    
    when(() => mockDatabase.instance).thenReturn(mockFirestore);
    
    repository = FirestoreCompetitiveSettlementRepository(mockDatabase, mockProgression);
  });

  test('finalizeSettlement skips if already completed (Idempotency)', () async {
    final settlement = CompetitiveSettlement(
      settlementId: 'already_done',
      sessionId: 'session_1',
      uid: 'user_1',
      result: GameResult(
        sessionId: 'session_1',
        playerId: 'user_1',
        mode: GameMode.pro,
        finalScore: 100,
        totalXP: 0,
        totalQuestions: 10,
        correctAnswers: 10,
        wrongAnswers: 0,
        totalDuration: Duration.zero,
        accuracy: 1.0,
        maxStreak: 10,
        timestamp: DateTime.now(),
      ),
      coinsWagered: 0,
      coinsWon: 100,
      xpEarned: 100,
      timestamp: DateTime.now(),
    );

    final mockTransaction = MockTransaction();
    final mockSettlementRef = MockDocumentReference();
    final mockSnapshot = MockDocumentSnapshot();
    final mockCollection = MockCollectionReference();

    when(() => mockFirestore.collection(any())).thenReturn(mockCollection);
    when(() => mockCollection.doc(any())).thenReturn(mockSettlementRef);
    
    // Very broad stubbing to avoid matching issues
    when(() => mockFirestore.runTransaction<void>(
      any(),
      timeout: any(named: 'timeout'),
      maxAttempts: any(named: 'maxAttempts'),
    )).thenAnswer((invocation) async {
      final handler = invocation.positionalArguments[0] as Future<void> Function(Transaction);
      return handler(mockTransaction);
    });

    when(() => mockTransaction.get(any())).thenAnswer((_) async => mockSnapshot);
    when(() => mockSnapshot.exists).thenReturn(true);
    when(() => mockSnapshot.data()).thenReturn({
      'status': 'completed',
    });

    await repository.finalizeSettlement(settlement);

    // Verify that NO writes were performed because it was already completed
    verifyNever(() => mockTransaction.set(any(), any()));
    verifyNever(() => mockTransaction.update(any(), any()));
  });
}
