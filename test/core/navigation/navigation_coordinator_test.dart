import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/services/navigation_coordinator.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGoRouter mockRouter;
  late NavigationCoordinator coordinator;

  setUp(() {
    mockRouter = MockGoRouter();
    coordinator = NavigationCoordinator(mockRouter);
  });

  test('go should call go on router', () {
    coordinator.go('/home');
    verify(mockRouter.go('/home')).called(1);
  });
}
