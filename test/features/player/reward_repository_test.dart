import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/player/domain/models/reward_grant.dart';
import 'package:soteria/features/player/domain/models/season_reward_definition.dart';
import 'package:soteria/features/player/data/repositories/firebase_reward_repository.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  Query,
  QuerySnapshot,
  QueryDocumentSnapshot,
  DocumentSnapshot,
])
import 'reward_repository_test.mocks.dart';

void main() {
  late FirebaseRewardRepository repository;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockDefinitionsCollection;
  late MockCollectionReference<Map<String, dynamic>> mockGrantsCollection;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockDefinitionsCollection = MockCollectionReference();
    mockGrantsCollection = MockCollectionReference();

    when(
      mockFirestore.collection('season_reward_definitions'),
    ).thenReturn(mockDefinitionsCollection);
    when(
      mockFirestore.collection('season_reward_grants'),
    ).thenReturn(mockGrantsCollection);

    repository = FirebaseRewardRepository(mockFirestore);
  });

  group('FirebaseRewardRepository', () {
    test('getRewardDefinitions returns list of definitions', () async {
      final mockQuery = MockQuery<Map<String, dynamic>>();
      final mockQuery2 = MockQuery<Map<String, dynamic>>();
      final mockSnapshot = MockQuerySnapshot<Map<String, dynamic>>();
      final mockDoc = MockQueryDocumentSnapshot<Map<String, dynamic>>();

      final definition = SeasonRewardDefinition(
        rewardId: 'r1',
        seasonId: 's1',
        name: 'Reward 1',
        description: 'Desc',
        type: RewardType.xp,
        amount: 100,
      );

      when(
        mockDefinitionsCollection.where('seasonId', isEqualTo: 's1'),
      ).thenReturn(mockQuery);
      when(mockQuery.where('isActive', isEqualTo: true)).thenReturn(mockQuery2);
      when(mockQuery2.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.docs).thenReturn([mockDoc]);
      when(mockDoc.data()).thenReturn(definition.toJson());

      final results = await repository.getRewardDefinitions('s1');

      expect(results.length, 1);
      expect(results.first.rewardId, 'r1');
    });

    test('getPlayerRewards returns list of grants', () async {
      final mockQuery = MockQuery<Map<String, dynamic>>();
      final mockQuery2 = MockQuery<Map<String, dynamic>>();
      final mockSnapshot = MockQuerySnapshot<Map<String, dynamic>>();
      final mockDoc = MockQueryDocumentSnapshot<Map<String, dynamic>>();

      final grant = RewardGrant(
        grantId: 'g1',
        rewardId: 'r1',
        seasonId: 's1',
        userId: 'u1',
        type: RewardType.xp,
        amount: 100,
        status: GrantStatus.granted,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      when(
        mockGrantsCollection.where('userId', isEqualTo: 'u1'),
      ).thenReturn(mockQuery);
      when(
        mockQuery.orderBy('createdAt', descending: true),
      ).thenReturn(mockQuery2);
      when(mockQuery2.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.docs).thenReturn([mockDoc]);
      when(mockDoc.data()).thenReturn(grant.toJson());

      final results = await repository.getPlayerRewards('u1');

      expect(results.length, 1);
      expect(results.first.grantId, 'g1');
    });
  });
}
