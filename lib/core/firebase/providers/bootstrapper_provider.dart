import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../initializer/firebase_bootstrapper.dart';
import '../security/providers/security_providers.dart';

final firebaseBootstrapperProvider = Provider<FirebaseBootstrapper>((ref) {
  return FirebaseBootstrapper();
});

class FirebaseInitStatusNotifier extends Notifier<BootstrapperStatus> {
  @override
  BootstrapperStatus build() {
    return ref.watch(firebaseBootstrapperProvider).status;
  }
}

final firebaseInitStatusProvider =
    NotifierProvider<FirebaseInitStatusNotifier, BootstrapperStatus>(
      FirebaseInitStatusNotifier.new,
    );

final firebaseInitFutureProvider = FutureProvider<void>((ref) async {
  final bootstrapper = ref.watch(firebaseBootstrapperProvider);
  final securityCoordinator = ref.watch(securityCoordinatorProvider);
  await bootstrapper.init(securityCoordinator);
});
