import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/features/question_content/data/repositories/firestore_category_repository.dart';

@GenerateNiceMocks([
  MockSpec<IDatabaseService>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
  MockSpec<Query<Map<String, dynamic>>>(),
  MockSpec<DocumentSnapshot<Map<String, dynamic>>>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
])
import 'firestore_category_repository_test.mocks.dart';

void main() {
  late MockIDatabaseService mockDatabase;
  late MockCollectionReference mockCollection;
  late FirestoreCategoryRepository repository;

  setUp(() {
    mockDatabase = MockIDatabaseService();
    mockCollection = MockCollectionReference();
    repository = FirestoreCategoryRepository(mockDatabase);

    when(mockDatabase.collection(any)).thenReturn(mockCollection);
  });

  group('FirestoreCategoryRepository', () {
    test('getCategories should filter by active and order by displayOrder', () async {
      final mockQuery = MockQuery();
      final mockSnapshot = MockQuerySnapshot();

      when(mockCollection.where('active', isEqualTo: true)).thenReturn(mockQuery);
      when(mockQuery.orderBy('displayOrder')).thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.docs).thenReturn([]);

      await repository.getCategories();

      verify(mockCollection.where('active', isEqualTo: true)).called(1);
      verify(mockQuery.orderBy('displayOrder')).called(1);
    });

    test('getSubcategories should filter by categoryId and active', () async {
      final mockQuery = MockQuery();
      final mockSnapshot = MockQuerySnapshot();

      when(mockCollection.where('categoryId', isEqualTo: 'cat1')).thenReturn(mockQuery);
      when(mockQuery.where('active', isEqualTo: true)).thenReturn(mockQuery);
      when(mockQuery.orderBy('displayOrder')).thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.docs).thenReturn([]);

      await repository.getSubcategories('cat1');

      verify(mockCollection.where('categoryId', isEqualTo: 'cat1')).called(1);
    });

    test('getTopics should filter by subcategoryId and active', () async {
      final mockQuery = MockQuery();
      final mockSnapshot = MockQuerySnapshot();

      when(mockCollection.where('subcategoryId', isEqualTo: 'sub1')).thenReturn(mockQuery);
      when(mockQuery.where('active', isEqualTo: true)).thenReturn(mockQuery);
      when(mockQuery.orderBy('displayOrder')).thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.docs).thenReturn([]);

      await repository.getTopics('sub1');

      verify(mockCollection.where('subcategoryId', isEqualTo: 'sub1')).called(1);
    });
  });
}
