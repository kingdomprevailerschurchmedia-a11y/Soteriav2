import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/firebase/providers/firebase_providers.dart';
import '../mock/fake_auth_service.dart';
import '../mock/fake_database_service.dart';

final fakeAuthServiceProvider = Provider<FakeAuthService>(
  (ref) => FakeAuthService(),
);
final fakeDatabaseServiceProvider = Provider<FakeDatabaseService>(
  (ref) => FakeDatabaseService(),
);

List getBasePreviewOverrides() {
  return [
    firebaseAuthServiceProvider.overrideWith(
      (ref) => ref.watch(fakeAuthServiceProvider),
    ),
    firestoreDatabaseServiceProvider.overrideWith(
      (ref) => ref.watch(fakeDatabaseServiceProvider),
    ),
  ];
}
