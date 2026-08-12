import 'package:go_router/go_router.dart';
import '../../../core/navigation/services/navigation_coordinator.dart';

class MockNavigationCoordinator extends NavigationCoordinator {
  MockNavigationCoordinator() : super(GoRouter(routes: []));

  @override
  void navigateTo(String path, {Object? extra}) {
    // No-op for previews or print for debugging
    print('Mock Navigating to: $path');
  }

  @override
  void go(String path, {Object? extra}) {
    print('Mock Routing to (go): $path');
  }

  @override
  void pop() {
    print('Mock Pop');
  }

  @override
  void openNotifications() {
    print('Mock Open Notifications');
  }

  @override
  void openSettings() {
    print('Mock Open Settings');
  }

  @override
  void playPractice() {
    print('Mock Play Practice');
  }

  @override
  void playProMode() {
    print('Mock Play Pro Mode');
  }

  @override
  void playVersus() {
    print('Mock Play Versus');
  }

  @override
  void playTournament() {
    print('Mock Play Tournament');
  }
}
