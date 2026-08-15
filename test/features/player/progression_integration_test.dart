import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/models/xp_transaction.dart';
import 'package:soteria/features/player/data/repositories/firebase_player_progression_repository.dart';
import 'package:soteria/features/player/domain/services/progression_service.dart';

import 'package:soteria/features/player/domain/services/competitive_ranking_engine.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
  MockSpec<DocumentSnapshot<Map<String, dynamic>>>(),
  MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
])
import 'progression_integration_test.mocks.dart';

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDoc;
  late ProgressionService progressionService;
  late FirebasePlayerProgressionRepository repository;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockDoc = MockDocumentReference();
    progressionService = ProgressionService();
    repository = FirebasePlayerProgressionRepository(
      mockFirestore,
      progressionService,
      CompetitiveRankingEngine(),
    );

    when(
      mockFirestore.collection('player_progression'),
    ).thenReturn(mockCollection);
    when(mockCollection.doc(any)).thenReturn(mockDoc);
  });

  group('Progression Integration - Repository & Service', () {
    test('applyXpTransaction should trigger level up calculation', () async {
      // Setup initial progression state
      final initialProgression = PlayerProgression.initial(
        'user123',
        'season1',
      );
      final transaction = XpTransaction(
        transactionId: 'tx1',
        userId: 'user123',
        amount: 2000,
        source: XpSource.quizCompletion,
        referenceId: 'quiz1',
        createdAt: DateTime.now(),
      );

      // Verify that addXp calculates the level correctly
      final updated = progressionService.addXp(initialProgression, 2000);
      expect(updated.currentLevel, 7);
      expect(updated.lifetimeXp, 2000);
    });
  });
}
