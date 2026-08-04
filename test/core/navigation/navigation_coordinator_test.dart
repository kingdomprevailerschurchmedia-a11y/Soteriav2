import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/services/navigation_coordinator.dart';

import 'navigation_coordinator_test.mocks.dart';

@GenerateMocks([GoRouter])
void main() {
  late MockGoRouter mockRouter;
  late NavigationCoordinator coordinator;

  setUp(() {
    mockRouter = MockGoRouter();
    coordinator = NavigationCoordinator(mockRouter);
  });

  test('navigateTo should call push on router', () {
    coordinator.navigateTo('/test');
    verify(mockRouter.push('/test', extra: null)).called(1);
  });

  test('go should call go on router', () {
    coordinator.go('/home');
    verify(mockRouter.go('/home', extra: null)).called(1);
  });

  test('openSettings should navigate to settings path', () {
    coordinator.openSettings();
    verify(mockRouter.push('/app/settings', extra: null)).called(1);
  });

  test('playPractice should navigate to practice path', () {
    coordinator.playPractice();
    verify(mockRouter.push('/app/practice', extra: null)).called(1);
  });
}
