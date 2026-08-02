import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:soteria/features/player/services/player_bootstrap_service.dart';
import 'package:soteria/features/player/domain/use_cases/load_player_profile_use_case.dart';
import 'package:soteria/features/player/domain/use_cases/create_player_profile_use_case.dart';
import 'package:soteria/features/player/domain/use_cases/update_player_profile_use_case.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';

@GenerateMocks([
  LoadPlayerProfileUseCase,
  CreatePlayerProfileUseCase,
  UpdatePlayerProfileUseCase,
  auth.User,
])
import 'player_bootstrap_service_test.mocks.dart';

void main() {
  late PlayerBootstrapService service;
  late MockLoadPlayerProfileUseCase mockLoad;
  late MockCreatePlayerProfileUseCase mockCreate;
  late MockUpdatePlayerProfileUseCase mockUpdate;
  late MockUser mockUser;

  setUp(() {
    mockLoad = MockLoadPlayerProfileUseCase();
    mockCreate = MockCreatePlayerProfileUseCase();
    mockUpdate = MockUpdatePlayerProfileUseCase();
    mockUser = MockUser();

    service = PlayerBootstrapService(mockLoad, mockCreate, mockUpdate);

    when(mockUser.uid).thenReturn('test-uid');
    when(mockUser.displayName).thenReturn('Test User');
    when(mockUser.email).thenReturn('test@soteria.com');
    when(mockUser.photoURL).thenReturn('photo-url');
  });

  test('bootstrap should create new profile if none exists', () async {
    when(mockLoad.execute(any)).thenAnswer((_) async => null);
    when(mockCreate.execute(any)).thenAnswer((_) async => {});

    final result = await service.bootstrap(mockUser);

    expect(result.uid, 'test-uid');
    expect(result.displayName, 'Test User');
    verify(mockCreate.execute(any)).called(1);
    verifyNever(mockUpdate.execute(any));
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

    when(mockLoad.execute(any)).thenAnswer((_) async => existingProfile);
    when(mockUpdate.execute(any)).thenAnswer((_) async => {});

    final result = await service.bootstrap(mockUser);

    expect(result.uid, 'test-uid');
    verify(mockUpdate.execute(any)).called(1);
    verifyNever(mockCreate.execute(any));
  });
}
