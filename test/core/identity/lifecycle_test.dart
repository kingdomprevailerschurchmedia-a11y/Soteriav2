import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/core/identity/models/user_session.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/repositories/identity_repository.dart';

class SyncMockIdentityRepository extends MockIdentityRepository {
  @override
  Future<UserSession?> getActiveSession() async => null;
}

void main() {
  group('AppLifecycleNotifier', () {
    test(
      'starts with loading and transitions to onboarding on fresh install',
      () async {
        SharedPreferences.setMockInitialValues({});
        final container = ProviderContainer(
          overrides: [
            identityRepositoryProvider.overrideWithValue(
              SyncMockIdentityRepository(),
            ),
          ],
        );
        addTearDown(container.dispose);

        expect(container.read(appLifecycleProvider), AppStartupState.loading);

        // Wait until it's no longer loading
        while (container.read(appLifecycleProvider) ==
            AppStartupState.loading) {
          await Future.delayed(const Duration(milliseconds: 10));
        }

        expect(
          container.read(appLifecycleProvider),
          AppStartupState.onboarding,
        );
      },
    );

    test('transitions to personalization if onboarding is completed', () async {
      SharedPreferences.setMockInitialValues({'onboarding_completed': true});

      final container = ProviderContainer(
        overrides: [
          identityRepositoryProvider.overrideWithValue(
            SyncMockIdentityRepository(),
          ),
        ],
      );
      addTearDown(container.dispose);

      while (container.read(appLifecycleProvider) == AppStartupState.loading) {
        await Future.delayed(const Duration(milliseconds: 10));
      }

      expect(
        container.read(appLifecycleProvider),
        AppStartupState.personalization,
      );
    });
  });
}
