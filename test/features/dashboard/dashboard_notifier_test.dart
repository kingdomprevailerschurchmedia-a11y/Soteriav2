import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:soteria/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:soteria/features/dashboard/domain/repositories/home_repository.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/providers/player_providers.dart';

import 'dashboard_notifier_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
  });

  ProviderContainer createContainer({
    PlayerProfile? player,
  }) {
    final container = ProviderContainer(
      overrides: [
        homeRepositoryProvider.overrideWithValue(mockHomeRepository),
        currentPlayerStreamProvider.overrideWith((ref) => Stream.value(player)),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('initial state should load player and home data', () async {
    final player = PlayerProfile(
      uid: '123',
      displayName: 'Joseph',
      email: 'joseph@soteria.com',
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    when(mockHomeRepository.getAnnouncements()).thenAnswer((_) async => ['Hello']);
    when(mockHomeRepository.getDailyChallenge()).thenAnswer((_) async => null);

    final container = createContainer(player: player);
    
    // Wait for microtasks and async loads
    await Future.delayed(Duration.zero);
    
    final state = container.read(dashboardProvider);
    
    expect(state.player?.uid, '123');
    expect(state.announcements, ['Hello']);
    expect(state.isLoading, false);
  });

  test('should handle error when repository fails', () async {
    when(mockHomeRepository.getAnnouncements()).thenThrow(Exception('Network Error'));
    when(mockHomeRepository.getDailyChallenge()).thenAnswer((_) async => null);

    final container = createContainer();
    
    await Future.delayed(Duration.zero);
    
    final state = container.read(dashboardProvider);
    
    expect(state.error, contains('Network Error'));
    expect(state.isLoading, false);
  });
}
