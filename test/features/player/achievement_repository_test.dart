import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/player/data/repositories/firebase_achievement_repository.dart';
import 'package:soteria/features/player/data/repositories/firebase_player_progression_repository.dart';
import 'package:soteria/features/player/domain/models/achievement.dart';
import 'package:soteria/features/player/domain/models/xp_transaction.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/services/progression_service.dart';

class FakeFirebaseFirestore extends Fake implements FirebaseFirestore {
  final CollectionReference<Map<String, dynamic>> Function(String) onCollection;
  final Future<void> Function(TransactionHandler) onRunTransaction;

  FakeFirebaseFirestore({required this.onCollection, required this.onRunTransaction});

  @override
  CollectionReference<Map<String, dynamic>> collection(String collectionPath) => onCollection(collectionPath);

  @override
  Future<T> runTransaction<T>(TransactionHandler<T> transactionHandler, {Duration timeout = const Duration(seconds: 30), int maxAttempts = 5}) async {
    return await onRunTransaction(transactionHandler as TransactionHandler<dynamic>) as T;
  }
}

class FakeProgressionRepository extends Fake implements FirebasePlayerProgressionRepository {
  final List<XpTransaction> processedTransactions = [];

  @override
  Future<void> processXpTransaction(dynamic tx, XpTransaction transaction) async {
    processedTransactions.add(transaction);
  }

  @override
  Future<void> applyXpTransaction(XpTransaction transaction) async {}
  
  @override
  Stream<PlayerProgression> watchProgression(String userId) => Stream.empty();
}

class FakeTransaction extends Fake implements Transaction {
  final Map<DocumentReference, dynamic> sets = {};
  final Map<DocumentReference, Map<Object, Object?>> updates = {};
  final Map<DocumentReference, DocumentSnapshot> snapshots = {};

  @override
  Future<DocumentSnapshot<T>> get<T>(DocumentReference<T> documentReference) async {
    return (snapshots[documentReference] ?? MockDocumentSnapshot()) as DocumentSnapshot<T>;
  }

  @override
  Transaction set<T>(DocumentReference<T> documentReference, T data, [SetOptions? options]) {
    sets[documentReference] = data;
    return this;
  }

  @override
  Transaction update(DocumentReference<Object?> documentReference, Map<Object, Object?> data) {
    updates[documentReference as DocumentReference<Map<String, dynamic>>] = data;
    return this;
  }
}

class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}
class MockProgressionService extends Mock implements ProgressionService {}

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late MockCollectionReference mockAchievementCollection;
  late MockUserCollection mockUserCollection;
  late MockProgressionCollection mockProgressionCollection;
  late MockDocumentReference mockAchievementDoc;
  late MockDocumentReference mockUserDoc;
  late MockDocumentReference mockProgressionDoc;
  late MockDocumentSnapshot mockAchievementSnapshot;
  late FakeTransaction fakeTransaction;
  late FakeProgressionRepository fakeProgressionRepo;
  late MockProgressionService mockProgressionService;
  late FirebaseAchievementRepository repository;

  setUp(() {
    mockAchievementCollection = MockCollectionReference();
    mockUserCollection = MockUserCollection();
    mockProgressionCollection = MockProgressionCollection();
    mockAchievementDoc = MockDocumentReference();
    mockUserDoc = MockDocumentReference();
    mockProgressionDoc = MockDocumentReference();
    mockAchievementSnapshot = MockDocumentSnapshot();
    fakeTransaction = FakeTransaction();
    
    fakeProgressionRepo = FakeProgressionRepository();
    mockProgressionService = MockProgressionService();

    fakeFirestore = FakeFirebaseFirestore(
      onCollection: (path) {
        if (path == 'users') return mockUserCollection;
        if (path == 'player_progression') return mockProgressionCollection;
        return mockUserCollection;
      },
      onRunTransaction: (handler) async {
        await handler(fakeTransaction);
      }
    );

    repository = FirebaseAchievementRepository(
      fakeFirestore,
      fakeProgressionRepo,
      mockProgressionService,
    );

    when(() => mockUserCollection.doc(any())).thenReturn(mockUserDoc);
    when(() => mockUserDoc.collection('achievements')).thenReturn(mockAchievementCollection);
    when(() => mockAchievementCollection.doc(any())).thenReturn(mockAchievementDoc);
    when(() => mockProgressionCollection.doc(any())).thenReturn(mockProgressionDoc);
  });

  group('FirebaseAchievementRepository - Unlocking', () {
    test('unlockAchievement should be idempotent and use progression hook', () async {
      const userId = 'u1';
      const achievementId = 'score_1k';

      fakeTransaction.snapshots[mockAchievementDoc] = mockAchievementSnapshot;
      when(() => mockAchievementSnapshot.exists).thenReturn(false);

      await repository.unlockAchievement(userId, achievementId);

      expect(fakeTransaction.sets.containsKey(mockAchievementDoc), true);
      expect(fakeTransaction.updates.containsKey(mockUserDoc), true);
      
      expect(fakeProgressionRepo.processedTransactions.length, 1);
      expect(fakeProgressionRepo.processedTransactions.first.referenceId, achievementId);
    });

    test('unlockAchievement should abort if already unlocked', () async {
      const userId = 'u1';
      const achievementId = 'score_1k';

      final existingAch = PlayerAchievement(
        userId: userId,
        achievementId: achievementId,
        status: AchievementStatus.unlocked,
        currentValue: 1000,
        targetValue: 1000,
      );

      fakeTransaction.snapshots[mockAchievementDoc] = mockAchievementSnapshot;
      when(() => mockAchievementSnapshot.exists).thenReturn(true);
      when(() => mockAchievementSnapshot.data()).thenReturn(existingAch.toJson());

      await repository.unlockAchievement(userId, achievementId);

      expect(fakeTransaction.sets.isEmpty, true);
      expect(fakeTransaction.updates.isEmpty, true);
      expect(fakeProgressionRepo.processedTransactions.isEmpty, true);
    });
  });
}

class MockUserCollection extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockProgressionCollection extends Mock implements CollectionReference<Map<String, dynamic>> {}
