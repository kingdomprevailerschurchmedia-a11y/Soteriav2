import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/player/data/repositories/firebase_identity_repository.dart';
import 'package:soteria/features/player/domain/models/public_competitive_profile.dart';
import 'package:soteria/features/player/domain/models/competitive_statistics.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
  MockSpec<Query<Map<String, dynamic>>>(),
  MockSpec<DocumentSnapshot<Map<String, dynamic>>>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
])
import 'identity_repository_public_test.mocks.dart';

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late FirebaseIdentityRepository repository;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    repository = FirebaseIdentityRepository(mockFirestore);

    when(mockFirestore.collection('public_profiles')).thenReturn(mockCollection);
  });

  group('FirebaseIdentityRepository - Public Profiles', () {
    test('getPublicProfile should fetch from public_profiles collection', () async {
      final mockDoc = MockDocumentReference();
      final mockSnapshot = MockDocumentSnapshot();
      
      when(mockCollection.doc('user123')).thenReturn(mockDoc);
      when(mockDoc.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.exists).thenReturn(true);
      when(mockSnapshot.id).thenReturn('user123');
      when(mockSnapshot.data()).thenReturn({
        'displayName': 'Test Player',
        'avatarId': 'socrates',
        'currentRank': 'Gold',
        'rankTier': 'Gold',
        'rankPoints': 1200,
        'division': 1,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      final result = await repository.getPublicProfile('user123');

      expect(result, isNotNull);
      expect(result!.displayName, 'Test Player');
      verify(mockCollection.doc('user123')).called(1);
    });

    test('searchPlayers should use normalized name query', () async {
      final mockQuery = MockQuery();
      final mockSnapshot = MockQuerySnapshot();

      when(mockCollection.where(
        'displayNameNormalized',
        isGreaterThanOrEqualTo: 'alex',
      )).thenReturn(mockQuery);
      when(mockQuery.where(
        'displayNameNormalized',
        isLessThanOrEqualTo: 'alex\uf8ff',
      )).thenReturn(mockQuery);
      when(mockQuery.limit(any)).thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.docs).thenReturn([]);

      await repository.searchPlayers('Alex');

      verify(mockCollection.where(
        'displayNameNormalized',
        isGreaterThanOrEqualTo: 'alex',
      )).called(1);
    });
  });
}
