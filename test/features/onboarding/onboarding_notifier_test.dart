import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/onboarding/providers/onboarding_notifier.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import '../../test_helper.dart';

void main() {
  group('OnboardingNotifier', () {
    late ProviderContainer container;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer(
        overrides: [
          identityRepositoryProvider.overrideWithValue(MockIdentityRepo()),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is correct', () {
      final state = container.read(onboardingProvider);
      expect(state.currentPage, 0);
      expect(state.isCompleted, false);
    });

    test('nextPage increments currentPage', () {
      final notifier = container.read(onboardingProvider.notifier);
      notifier.nextPage();
      expect(container.read(onboardingProvider).currentPage, 1);
    });

    test('setPage updates currentPage', () {
      final notifier = container.read(onboardingProvider.notifier);
      notifier.setPage(2);
      expect(container.read(onboardingProvider).currentPage, 2);
    });

    test('skip completes onboarding', () async {
      final notifier = container.read(onboardingProvider.notifier);
      await notifier.skip();
      expect(container.read(onboardingProvider).isCompleted, true);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('onboarding_completed'), true);
    });
  });
}
