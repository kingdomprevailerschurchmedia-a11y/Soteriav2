import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import 'package:soteria/features/player/data/repositories/firebase_player_progression_repository.dart';
import 'package:soteria/features/player/domain/services/progression_service.dart';
import 'package:soteria/features/player/domain/services/competitive_ranking_engine.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
  MockSpec<Query<Map<String, dynamic>>>(),
  MockSpec<QueryDocumentSnapshot<Map<String, dynamic>>>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
  MockSpec<DocumentSnapshot<Map<String, dynamic>>>(),
])
import 'ranking_security_test.mocks.dart';

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockRankTxCollection;
  late FirebasePlayerProgressionRepository repository;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockRankTxCollection = MockCollectionReference();

    when(
      mockFirestore.collection('rank_transactions'),
    ).thenReturn(mockRankTxCollection);

    repository = FirebasePlayerProgressionRepository(
      mockFirestore,
      ProgressionService(),
      CompetitiveRankingEngine(),
    );
  });

  group('Ranking Security & Idempotency', () {
    test('should reject duplicate result processing', () async {
      final result = CompetitiveResult(
        resultId: 'duplicate_1',
        userId: 'user1',
        seasonId: 'season1',
        outcome: CompetitiveOutcome.win,
        mode: 'ranked',
        score: 100,
        completedAt: DateTime.now(),
      );

      final mockQuerySnapshot = MockQuerySnapshot();
      final mockQueryDoc = MockQueryDocumentSnapshot();
      final mockQuery = MockQuery();

      when(
        mockRankTxCollection.where('resultId', isEqualTo: 'duplicate_1'),
      ).thenReturn(mockQuery);
      when(mockQuery.limit(1)).thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDoc]);
      when(mockQueryDoc.data()).thenReturn({
        'transactionId': 'tx1',
        'userId': 'user1',
        'seasonId': 'season1',
        'resultId': 'duplicate_1',
        'previousRankPoints': 100,
        'changeAmount': 10,
        'newRankPoints': 110,
        'timestamp': DateTime.now().toIso8601String(),
        'schemaVersion': 1,
      });

      expect(
        () => repository.applyCompetitiveResult(result),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('already processed'),
          ),
        ),
      );
    });
  });
}
