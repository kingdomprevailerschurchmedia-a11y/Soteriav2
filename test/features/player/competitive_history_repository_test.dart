import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/player/data/repositories/firebase_competitive_history_repository.dart';
import 'package:soteria/features/player/domain/models/season_result.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
  MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
  MockSpec<Query<Map<String, dynamic>>>(),
  MockSpec<QueryDocumentSnapshot<Map<String, dynamic>>>(),
])
import 'competitive_history_repository_test.mocks.dart';

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockUsersCollection;
  late MockDocumentReference mockUserDoc;
  late MockCollectionReference mockResultsCollection;
  late FirebaseCompetitiveHistoryRepository repository;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockUsersCollection = MockCollectionReference();
    mockUserDoc = MockDocumentReference();
    mockResultsCollection = MockCollectionReference();
    repository = FirebaseCompetitiveHistoryRepository(mockFirestore);

    when(mockFirestore.collection('users')).thenReturn(mockUsersCollection);
    when(mockUsersCollection.doc(any)).thenReturn(mockUserDoc);
    when(
      mockUserDoc.collection('season_results'),
    ).thenReturn(mockResultsCollection);
  });

  group('FirebaseCompetitiveHistoryRepository', () {
    const userId = 'user_123';

    test(
      'getSeasonResults should query and return list ordered by seasonNumber',
      () async {
        final mockQuery = MockQuery();
        final mockSnapshot = MockQuerySnapshot();
        final mockDoc = MockQueryDocumentSnapshot();

        final now = DateTime.now();
        final result = SeasonResult(
          seasonId: 's1',
          userId: userId,
          seasonName: 'Test',
          seasonNumber: 1,
          finalPosition: 1,
          finalRankPoints: 1000,
          finalTier: 'Gold',
          finalDivision: 1,
          previousTier: 'Silver',
          previousDivision: 1,
          rankChange: 100,
          completedAt: now,
          createdAt: now,
          updatedAt: now,
        );

        when(
          mockResultsCollection.orderBy('seasonNumber', descending: true),
        ).thenReturn(mockQuery);
        when(mockQuery.limit(any)).thenReturn(mockQuery);
        when(mockQuery.get()).thenAnswer((_) async => mockSnapshot);
        when(mockSnapshot.docs).thenReturn([mockDoc]);
        when(mockDoc.data()).thenReturn(result.toJson());

        final results = await repository.getSeasonResults(userId);

        expect(results.length, 1);
        expect(results.first.seasonId, 's1');
        verify(
          mockResultsCollection.orderBy('seasonNumber', descending: true),
        ).called(1);
      },
    );

    test('getLatestSeasonResult should use limit 1', () async {
      final mockQuery = MockQuery();
      final mockSnapshot = MockQuerySnapshot();
      final mockDoc = MockQueryDocumentSnapshot();

      when(
        mockResultsCollection.orderBy('seasonNumber', descending: true),
      ).thenReturn(mockQuery);
      when(mockQuery.limit(1)).thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.docs).thenReturn([mockDoc]);
      when(mockDoc.data()).thenReturn({
        'seasonId': 'latest',
        'userId': userId,
        'seasonName': 'Latest',
        'seasonNumber': 10,
        'finalPosition': 1,
        'finalRankPoints': 5000,
        'finalTier': 'Diamond',
        'finalDivision': 1,
        'previousTier': 'Platinum',
        'previousDivision': 1,
        'rankChange': 500,
        'completedAt': DateTime.now().toIso8601String(),
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      });

      final result = await repository.getLatestSeasonResult(userId);

      expect(result?.seasonId, 'latest');
      verify(mockQuery.limit(1)).called(1);
    });

    test('getBestSeasonResult should order by finalRankPoints', () async {
      final mockQuery = MockQuery();
      final mockSnapshot = MockQuerySnapshot();
      final mockDoc = MockQueryDocumentSnapshot();

      when(
        mockResultsCollection.orderBy('finalRankPoints', descending: true),
      ).thenReturn(mockQuery);
      when(mockQuery.limit(1)).thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.docs).thenReturn([mockDoc]);
      when(mockDoc.data()).thenReturn({
        'seasonId': 'best',
        'userId': userId,
        'seasonName': 'Best',
        'seasonNumber': 5,
        'finalPosition': 1,
        'finalRankPoints': 9999,
        'finalTier': 'Master',
        'finalDivision': 1,
        'previousTier': 'Diamond',
        'previousDivision': 1,
        'rankChange': 1000,
        'completedAt': DateTime.now().toIso8601String(),
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      });

      final result = await repository.getBestSeasonResult(userId);

      expect(result?.seasonId, 'best');
      verify(
        mockResultsCollection.orderBy('finalRankPoints', descending: true),
      ).called(1);
    });
  });
}
