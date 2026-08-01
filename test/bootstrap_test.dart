import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/core/app/app_bootstrap.dart';

void main() {
  test('AppBootstrap initialization success', () async {
    SharedPreferences.setMockInitialValues({});
    
    final container = ProviderContainer();
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
