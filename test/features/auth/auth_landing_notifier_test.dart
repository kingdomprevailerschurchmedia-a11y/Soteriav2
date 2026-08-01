import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/auth/providers/auth_landing_notifier.dart';

void main() {
  group('AuthLandingNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is correct', () {
      final state = container.read(authLandingProvider);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('setLoading updates state', () {
      final notifier = container.read(authLandingProvider.notifier);
      notifier.setLoading(true);
      expect(container.read(authLandingProvider).isLoading, true);
    });

    test('setError updates state', () {
      final notifier = container.read(authLandingProvider.notifier);
      notifier.setError('test error');
      expect(container.read(authLandingProvider).error, 'test error');
    });
  });
}
