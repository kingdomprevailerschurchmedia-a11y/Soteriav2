import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:soteria/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:soteria/features/dashboard/domain/repositories/home_repository.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/providers/player_providers.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

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

  test('initial state should be loading', () {
    final container = createContainer();
    final state = container.read(dashboardProvider);
    expect(state.isLoading, true);
  });
}
