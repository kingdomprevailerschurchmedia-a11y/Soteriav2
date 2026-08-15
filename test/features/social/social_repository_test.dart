import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/social/data/repositories/firebase_social_repository.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
  MockSpec<DocumentSnapshot<Map<String, dynamic>>>(),
  MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
  MockSpec<Query<Map<String, dynamic>>>(),
  MockSpec<WriteBatch>(),
  MockSpec<Transaction>(),
])
import 'social_repository_test.mocks.dart';

void main() {
  late FirebaseSocialRepository repository;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDocument;
  late MockTransaction mockTransaction;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockDocument = MockDocumentReference();
    mockTransaction = MockTransaction();
    repository = FirebaseSocialRepository(mockFirestore);
    
    when(mockFirestore.collection(any)).thenReturn(mockCollection);
    when(mockCollection.doc(any)).thenReturn(mockDocument);
  });

  group('FirebaseSocialRepository - Hardening Tests', () {
    test('sendFriendRequest throws exception for self-request', () async {
      expect(
        () => repository.sendFriendRequest('user1', 'user1'),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('cannot send a friend request to yourself'))),
      );
    });

    test('sendFriendRequest uses transaction', () async {
      const senderId = 'userA';
      const receiverId = 'userB';

      when(mockFirestore.runTransaction<void>(any)).thenAnswer((invocation) async {
        final handler = invocation.positionalArguments[0] as Future<void> Function(Transaction);
        return handler(mockTransaction);
      });

      final mockFriendshipDoc = MockDocumentSnapshot();
      final mockOutgoingDoc = MockDocumentSnapshot();
      final mockIncomingDoc = MockDocumentSnapshot();

      when(mockFriendshipDoc.exists).thenReturn(false);
      when(mockOutgoingDoc.exists).thenReturn(false);
      when(mockIncomingDoc.exists).thenReturn(false);

      when(mockTransaction.get(any)).thenAnswer((_) async => mockFriendshipDoc);

      await repository.sendFriendRequest(senderId, receiverId);

      verify(mockFirestore.runTransaction(any)).called(1);
    });

    test('removeFriend uses deterministic ID', () async {
      const userA = 'aaa';
      const userB = 'bbb';
      
      // Case 1: userA < userB
      await repository.removeFriend(userA, userB);
      verify(mockCollection.doc('aaa_bbb')).called(1);

      // Case 2: userB > userA (reversed arguments, same ID)
      await repository.removeFriend(userB, userA);
      verify(mockCollection.doc('aaa_bbb')).called(2);
    });
  });
}
