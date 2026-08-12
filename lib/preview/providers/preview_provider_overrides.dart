import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/firebase/providers/firebase_providers.dart';
import '../../../core/navigation/providers/navigation_providers.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../core/navigation/app_router.dart';
import '../../../features/quiz/presentation/providers/recovery_providers.dart';
import '../mock/fake_auth_service.dart';
import '../mock/fake_database_service.dart';
import '../mock/mock_navigation_coordinator.dart';

final fakeAuthServiceProvider = Provider<FakeAuthService>(
  (ref) => FakeAuthService(),
);
final fakeDatabaseServiceProvider = Provider<FakeDatabaseService>(
  (ref) => FakeDatabaseService(),
);

class MockNavigationService extends NavigationService {
  MockNavigationService(super.ref);

  @override
  void go(String path, {Object? extra}) {
    debugPrint('Mock Navigation Service (go): $path');
  }

  @override
  Future<T?> push<T extends Object?>(String path, {Object? extra}) async {
    debugPrint('Mock Navigation Service (push): $path');
    return null;
  }

  @override
  void replace(String path, {Object? extra}) {
    debugPrint('Mock Navigation Service (replace): $path');
  }

  @override
  void pop<T extends Object?>([T? result]) {
    debugPrint('Mock Navigation Service (pop)');
  }
}

class MockRecoveryNotifier extends RecoveryNotifier {
  @override
  RecoveryState build() => const RecoveryState(status: RecoveryStatus.idle);
  @override
  Future<void> checkForRecoverableSession() async {}
}

List<Override> getBasePreviewOverrides() {
  return [
    firebaseAuthServiceProvider.overrideWith(
      (ref) => ref.watch(fakeAuthServiceProvider),
    ),
    firestoreDatabaseServiceProvider.overrideWith(
      (ref) => ref.watch(fakeDatabaseServiceProvider),
    ),
    navigationCoordinatorProvider.overrideWith(
      (ref) => MockNavigationCoordinator(),
    ),
    navigationServiceProvider.overrideWith((ref) => MockNavigationService(ref)),
    recoveryProvider.overrideWith(() => MockRecoveryNotifier()),
  ];
}
