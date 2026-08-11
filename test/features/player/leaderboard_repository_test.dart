import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/player/data/repositories/firebase_leaderboard_repository.dart';
import 'package:soteria/features/player/domain/models/leaderboard_entry.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
  MockSpec<Query<Map<String, dynamic>>>(),
  MockSpec<DocumentSnapshot<Map<String, dynamic>>>(),
])
import 'leaderboard_repository_test.mocks.dart';

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late FirebaseLeaderboardRepository repository;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    repository = FirebaseLeaderboardRepository(mockFirestore);

    when(mockFirestore.collection(any)).thenReturn(mockCollection);
  });

  group('LeaderboardRepository - Query Logic', () {
    test('getLeaderboardPage should use correct ordering and limit', () async {
      final mockQuery = MockQuery();
      final mockSnapshot = MockQuerySnapshot();

      when(
        mockCollection.orderBy('rankPoints', descending: true),
      ).thenReturn(mockQuery);
      when(
        mockQuery.orderBy('userId', descending: false),
      ).thenReturn(mockQuery);
      when(mockQuery.limit(any)).thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.docs).thenReturn([]);

      await repository.getLeaderboardPage(limit: 20);

      verify(mockCollection.orderBy('rankPoints', descending: true)).called(1);
      verify(mockQuery.orderBy('userId', descending: false)).called(1);
      verify(mockQuery.limit(20)).called(1);
    });

    test('getLeaderboardPage with seasonId should filter by season', () async {
      final mockQuery = MockQuery();
      final mockSnapshot = MockQuerySnapshot();

      when(
        mockCollection.where('seasonId', isEqualTo: 's1'),
      ).thenReturn(mockQuery);
      when(
        mockQuery.orderBy(any, descending: anyNamed('descending')),
      ).thenReturn(mockQuery);
      when(mockQuery.limit(any)).thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.docs).thenReturn([]);

      await repository.getLeaderboardPage(seasonId: 's1');

      verify(mockCollection.where('seasonId', isEqualTo: 's1')).called(1);
    });
  });
}
