import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/core/app/app_bootstrap.dart';

class MockAppBootstrap extends AppBootstrap {
  MockAppBootstrap(super.ref);

  @override
  Future<void> initialize() async {
    // Skip real Firebase and just delay
    await Future.delayed(const Duration(milliseconds: 100));
  }
}

void main() {
  test('AppBootstrap initialization success', () async {
    SharedPreferences.setMockInitialValues({});

    final container = ProviderContainer(
      overrides: [
        bootstrapServiceProvider.overrideWith((ref) => MockAppBootstrap(ref)),
      ],
    );
    addTearDown(container.dispose);

    final bootstrapNotifier = container.read(bootstrapStateProvider.notifier);

    expect(container.read(bootstrapStateProvider), BootstrapState.initial);

    // Start bootstrap
    final future = bootstrapNotifier.run();

    expect(container.read(bootstrapStateProvider), BootstrapState.loading);

    await future;

    expect(container.read(bootstrapStateProvider), BootstrapState.success);
  });
}
