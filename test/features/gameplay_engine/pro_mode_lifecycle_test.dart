import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart';
import 'package:soteria/features/player/domain/repositories/player_progression_repository.dart';
import 'package:soteria/features/player/domain/repositories/player_repository.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

class MockDatabaseService extends Mock implements IDatabaseService {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockQuery extends Mock implements Query<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {
  @override
  String get id => 'mock-id';
}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}
class MockQuerySnapshot extends Mock implements QuerySnapshot<Map<String, dynamic>> {}
class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot<Map<String, dynamic>> {}
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
    registerFallbackValue(MockDocumentReference());
  });

  setUp(() {
    mockDatabase = MockDatabaseService();
    mockFirestore = MockFirebaseFirestore();
    mockProgressionRepo = MockPlayerProgressionRepository();
    mockPlayerRepo = MockPlayerRepository();
    repository = FirestoreProModeRepository(mockDatabase, mockProgressionRepo, mockPlayerRepo);
    
    when(() => mockDatabase.instance).thenReturn(mockFirestore);
  });

  group('Pro Mode Lifecycle & Stale Recovery', () {
    test('Reproduction: Detects stale session, refunds it, and allows new session', () async {
      final uid = 'test-user';
      
      final mockColl = MockCollectionReference();
      final mockQuery = MockQuery();
      final mockSnap = MockQuerySnapshot();
      final mockDocSnap = MockQueryDocumentSnapshot();
      
      when(() => mockDatabase.collection(any())).thenReturn(mockColl);
      
      when(() => mockColl.where(any(),
        isEqualTo: any(named: 'isEqualTo'),
        whereIn: any(named: 'whereIn'),
        isNotEqualTo: any(named: 'isNotEqualTo'),
        isLessThan: any(named: 'isLessThan'),
        isLessThanOrEqualTo: any(named: 'isLessThanOrEqualTo'),
        isGreaterThan: any(named: 'isGreaterThan'),
        isGreaterThanOrEqualTo: any(named: 'isGreaterThanOrEqualTo'),
        arrayContains: any(named: 'arrayContains'),
        arrayContainsAny: any(named: 'arrayContainsAny'),
        whereNotIn: any(named: 'whereNotIn'),
        isNull: any(named: 'isNull'),
      )).thenReturn(mockQuery);

      when(() => mockQuery.where(any(),
        isEqualTo: any(named: 'isEqualTo'),
        whereIn: any(named: 'whereIn'),
        isNotEqualTo: any(named: 'isNotEqualTo'),
        isLessThan: any(named: 'isLessThan'),
        isLessThanOrEqualTo: any(named: 'isLessThanOrEqualTo'),
        isGreaterThan: any(named: 'isGreaterThan'),
        isGreaterThanOrEqualTo: any(named: 'isGreaterThanOrEqualTo'),
        arrayContains: any(named: 'arrayContains'),
        arrayContainsAny: any(named: 'arrayContainsAny'),
        whereNotIn: any(named: 'whereNotIn'),
        isNull: any(named: 'isNull'),
      )).thenReturn(mockQuery);
      
      when(() => mockQuery.get(any())).thenAnswer((_) async => mockSnap);
      when(() => mockSnap.docs).thenReturn([mockDocSnap]);
      when(() => mockDocSnap.id).thenReturn('stale-1');
      when(() => mockDocSnap.data()).thenReturn({
        'uid': uid,
        'status': 'initialized',
        'createdAt': DateTime.now().subtract(const Duration(minutes: 5)).toIso8601String(),
      });

      final mockTransaction = MockTransaction();
      when(() => mockFirestore.runTransaction<void>(any())).thenAnswer((inv) async {
        final f = inv.positionalArguments[0] as Future<void> Function(Transaction);
        return await f(mockTransaction);
      });

      final mockDocRef = MockDocumentReference();
      final mockDoc = MockDocumentSnapshot();
      when(() => mockColl.doc(any())).thenReturn(mockDocRef);
      
      when(() => mockTransaction.get<Map<String, dynamic>>(any())).thenAnswer((_) async => mockDoc);
      
      when(() => mockDoc.data()).thenReturn({
        'coins': 1000,
        'uid': uid,
        'status': 'reserved',
        'fee': 500,
      });

      var existsCount = 0;
      when(() => mockDoc.exists).thenAnswer((_) {
        existsCount++;
        if (existsCount == 1) return false;
        return true;
      });

      when(() => mockTransaction.update(any(), any())).thenReturn(mockTransaction);
      when(() => mockTransaction.set<Map<String, dynamic>>(any(), any(), any())).thenReturn(mockTransaction);
      when(() => mockTransaction.set<Map<String, dynamic>>(any(), any())).thenReturn(mockTransaction);

      await repository.reserveEntryFee(uid, 'new-1', Difficulty.medium);

      // --- VERIFY ---
      verify(() => mockTransaction.set<Map<String, dynamic>>(any(), any(), any())).called(greaterThan(0));
    });
  });
}
