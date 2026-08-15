import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/models/xp_transaction.dart';
import 'package:soteria/features/player/data/repositories/firebase_player_progression_repository.dart';
import 'package:soteria/features/player/domain/services/progression_service.dart';
import 'package:soteria/features/player/domain/services/competitive_ranking_engine.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}
class MockTransaction extends Mock implements Transaction {}

class FakeDocumentReference extends Fake implements DocumentReference<Map<String, dynamic>> {}

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockProgressionCollection;
  late MockCollectionReference mockXpTransactionCollection;
  late MockDocumentReference mockProgressionDoc;
  late MockDocumentReference mockXpTxDoc;
  late MockDocumentSnapshot mockProgressionSnapshot;
  late MockDocumentSnapshot mockXpTxSnapshot;
  late MockTransaction mockTransaction;
  late ProgressionService progressionService;
  late FirebasePlayerProgressionRepository repository;

  setUpAll(() {
    registerFallbackValue(FakeDocumentReference());
  });

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockProgressionCollection = MockCollectionReference();
    mockXpTransactionCollection = MockCollectionReference();
    mockProgressionDoc = MockDocumentReference();
    mockXpTxDoc = MockDocumentReference();
    mockProgressionSnapshot = MockDocumentSnapshot();
    mockXpTxSnapshot = MockDocumentSnapshot();
    mockTransaction = MockTransaction();
    
    progressionService = ProgressionService();
    repository = FirebasePlayerProgressionRepository(
      mockFirestore,
      progressionService,
      CompetitiveRankingEngine(),
    );

    when(() => mockFirestore.collection('player_progression')).thenReturn(mockProgressionCollection);
    when(() => mockFirestore.collection('xp_transactions')).thenReturn(mockXpTransactionCollection);
    when(() => mockProgressionCollection.doc(any())).thenReturn(mockProgressionDoc);
    when(() => mockXpTransactionCollection.doc(any())).thenReturn(mockXpTxDoc);

    // Setup for both 2 and 3 arguments as Firestore might call it either way depending on platform interface
    when(() => mockTransaction.set<Map<String, dynamic>>(any(), any())).thenReturn(mockTransaction);
    when(() => mockTransaction.set<Map<String, dynamic>>(any(), any(), any())).thenReturn(mockTransaction);
  });

  group('FirebasePlayerProgressionRepository - Idempotency', () {
    test('processXpTransaction should abort if transaction document already exists', () async {
      final transaction = XpTransaction(
        transactionId: 'duplicate_tx',
        userId: 'user1',
        amount: 100,
        source: XpSource.bonus,
        referenceId: 'ref1',
        createdAt: DateTime.now(),
      );

      when(() => mockTransaction.get<Map<String, dynamic>>(mockXpTxDoc)).thenAnswer((_) async => mockXpTxSnapshot);
      when(() => mockXpTxSnapshot.exists).thenReturn(true);

      await repository.processXpTransaction(mockTransaction, transaction);

      verify(() => mockTransaction.get(mockXpTxDoc)).called(1);
      verifyNever(() => mockTransaction.get(mockProgressionDoc));
    });

    test('processXpTransaction should abort if lastXpTransactionId matches', () async {
      final transaction = XpTransaction(
        transactionId: 'last_tx',
        userId: 'user1',
        amount: 100,
        source: XpSource.bonus,
        referenceId: 'ref1',
        createdAt: DateTime.now(),
      );

      final initialProg = PlayerProgression.initial('user1', 's1').copyWith(
        lastXpTransactionId: 'last_tx',
      );

      when(() => mockTransaction.get<Map<String, dynamic>>(mockXpTxDoc)).thenAnswer((_) async => mockXpTxSnapshot);
      when(() => mockXpTxSnapshot.exists).thenReturn(false);
      
      when(() => mockTransaction.get<Map<String, dynamic>>(mockProgressionDoc)).thenAnswer((_) async => mockProgressionSnapshot);
      when(() => mockProgressionSnapshot.exists).thenReturn(true);
      when(() => mockProgressionSnapshot.data()).thenReturn(initialProg.toJson());

      await repository.processXpTransaction(mockTransaction, transaction);

      verify(() => mockTransaction.get(mockXpTxDoc)).called(1);
      verify(() => mockTransaction.get(mockProgressionDoc)).called(1);
      verifyNever(() => mockTransaction.set(any(), any(), any()));
      verifyNever(() => mockTransaction.set(any(), any()));
    });

    test('processXpTransaction should apply transaction if new', () async {
       final transaction = XpTransaction(
        transactionId: 'new_tx',
        userId: 'user1',
        amount: 100,
        source: XpSource.bonus,
        referenceId: 'ref1',
        createdAt: DateTime.now(),
      );

      final initialProg = PlayerProgression.initial('user1', 's1');

      when(() => mockTransaction.get<Map<String, dynamic>>(any())).thenAnswer((invocation) async {
             final docRef = invocation.positionalArguments[0] as DocumentReference;
             if (docRef == mockXpTxDoc) return mockXpTxSnapshot;
             return mockProgressionSnapshot;
          });
          
      when(() => mockXpTxSnapshot.exists).thenReturn(false);
      when(() => mockProgressionSnapshot.exists).thenReturn(true);
      when(() => mockProgressionSnapshot.data()).thenReturn(initialProg.toJson());

      await repository.processXpTransaction(mockTransaction, transaction);

      // Verify either 2 or 3 arg version was called
      verify(() => mockTransaction.set<Map<String, dynamic>>(mockProgressionDoc, any(), any())).called(1);
      verify(() => mockTransaction.set<Map<String, dynamic>>(mockXpTxDoc, any(), any())).called(1);
    });
  });
}
