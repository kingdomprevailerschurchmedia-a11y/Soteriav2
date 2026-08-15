import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:soteria/features/player/services/player_bootstrap_service.dart';
import 'package:soteria/features/player/domain/use_cases/load_player_profile_use_case.dart';
import 'package:soteria/features/player/domain/use_cases/create_player_profile_use_case.dart';
import 'package:soteria/features/player/domain/use_cases/update_player_profile_use_case.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/repositories/player_progression_repository.dart';
import 'package:soteria/features/player/domain/services/progression_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/core/identity/repositories/identity_repository.dart';
import 'package:soteria/core/identity/models/user_profile.dart';

class MockLoadPlayerProfileUseCase extends Mock implements LoadPlayerProfileUseCase {}
class MockCreatePlayerProfileUseCase extends Mock implements CreatePlayerProfileUseCase {}
class MockUpdatePlayerProfileUseCase extends Mock implements UpdatePlayerProfileUseCase {}
class MockIdentityRepository extends Mock implements IdentityRepository {}
class MockPlayerProgressionRepository extends Mock implements PlayerProgressionRepository {}
class MockProgressionService extends Mock implements ProgressionService {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockUser extends Mock implements auth.User {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late PlayerBootstrapService service;
  late MockLoadPlayerProfileUseCase mockLoad;
  late MockCreatePlayerProfileUseCase mockCreate;
  late MockUpdatePlayerProfileUseCase mockUpdate;
  late MockIdentityRepository mockIdentity;
  late MockPlayerProgressionRepository mockProgressionRepo;
  late MockProgressionService mockProgressionService;
  late MockFirebaseFirestore mockFirestore;
  late MockUser mockUser;

  setUpAll(() {
    registerFallbackValue(PlayerProfile(
      uid: '', displayName: '', email: '', 
      createdAt: DateTime.now(), lastLogin: DateTime.now(), updatedAt: DateTime.now()
    ));
    registerFallbackValue(PlayerProgression.initial('', ''));
  });

  setUp(() {
    mockLoad = MockLoadPlayerProfileUseCase();
    mockCreate = MockCreatePlayerProfileUseCase();
    mockUpdate = MockUpdatePlayerProfileUseCase();
    mockIdentity = MockIdentityRepository();
    mockProgressionRepo = MockPlayerProgressionRepository();
    mockProgressionService = MockProgressionService();
    mockFirestore = MockFirebaseFirestore();
    mockUser = MockUser();

    service = PlayerBootstrapService(
      mockLoad,
      mockCreate,
      mockUpdate,
      mockProgressionRepo,
      mockProgressionService,
      mockFirestore,
      identityRepository: mockIdentity,
    );

    when(() => mockUser.uid).thenReturn('test-uid');
    when(() => mockUser.displayName).thenReturn('Test User');
    when(() => mockUser.email).thenReturn('test-email');
    when(() => mockUser.photoURL).thenReturn('test-photo');
    when(() => mockIdentity.getUserProfile(any())).thenAnswer((_) async => null);
    
    when(() => mockProgressionRepo.getProgression(any())).thenAnswer((_) async => null);
    when(() => mockProgressionRepo.updateProgression(any())).thenAnswer((_) async => {});

    final mockCollection = MockCollectionReference();
    final mockDoc = MockDocumentReference();
    when(() => mockFirestore.collection(any())).thenReturn(mockCollection);
    when(() => mockCollection.doc(any())).thenReturn(mockDoc);
    when(() => mockDoc.get()).thenAnswer((_) async => MockDocumentSnapshot());
  });

  test('bootstrap should create new profile if none exists', () async {
    when(() => mockLoad.execute(any())).thenAnswer((_) async => null);
    when(() => mockCreate.execute(any())).thenAnswer((_) async => {});

    final result = await service.bootstrap(mockUser);

    expect(result.uid, 'test-uid');
    expect(result.displayName, 'Test User');
    verify(() => mockCreate.execute(any())).called(1);
    verifyNever(() => mockUpdate.execute(any()));
  });

  test('bootstrap should update lastLogin if profile exists', () async {
    final existingProfile = PlayerProfile(
      uid: 'test-uid',
      displayName: 'Old Name',
      email: 'test@soteria.com',
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    when(() => mockLoad.execute(any())).thenAnswer((_) async => existingProfile);
    when(() => mockUpdate.execute(any())).thenAnswer((_) async => {});
    when(() => mockProgressionService.addXp(any(), any())).thenReturn(PlayerProgression.initial('test-uid', ''));

    final result = await service.bootstrap(mockUser);

    expect(result.uid, 'test-uid');
    verify(() => mockUpdate.execute(any())).called(1);
    verifyNever(() => mockCreate.execute(any()));
  });
}
