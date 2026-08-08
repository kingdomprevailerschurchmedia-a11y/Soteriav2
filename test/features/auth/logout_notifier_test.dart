import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:soteria/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:soteria/features/auth/presentation/providers/logout_notifier.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/repositories/identity_repository.dart';

import 'logout_notifier_test.mocks.dart' as mocks;

@GenerateMocks([LogoutUseCase, IdentityRepository])
void main() {
  late mocks.MockLogoutUseCase mockLogoutUseCase;
  late mocks.MockIdentityRepository mockIdentityRepository;
  late ProviderContainer container;

  setUp(() {
    mockLogoutUseCase = mocks.MockLogoutUseCase();
    mockIdentityRepository = mocks.MockIdentityRepository();

    container = ProviderContainer(
      overrides: [
        logoutUseCaseProvider.overrideWithValue(mockLogoutUseCase),
        identityRepositoryProvider.overrideWithValue(mockIdentityRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('LogoutNotifier', () {
    test('initial state is LogoutStatus.initial', () {
      expect(
        container.read(logoutNotifierProvider).status,
        LogoutStatus.initial,
      );
    });

    test('logout success sequence', () async {
      when(mockLogoutUseCase.execute()).thenAnswer((_) async => {});
      when(mockIdentityRepository.clearSession()).thenAnswer((_) async => {});

      final notifier = container.read(logoutNotifierProvider.notifier);

      final logoutFuture = notifier.logout();

      expect(
        container.read(logoutNotifierProvider).status,
        LogoutStatus.loading,
      );

      await logoutFuture;

      verify(mockLogoutUseCase.execute()).called(1);
      expect(
        container.read(logoutNotifierProvider).status,
        LogoutStatus.success,
      );
    });

    test('logout failure sequence', () async {
      when(mockLogoutUseCase.execute()).thenThrow(Exception('Logout Failed'));

      final notifier = container.read(logoutNotifierProvider.notifier);

      await notifier.logout();

      expect(
        container.read(logoutNotifierProvider).status,
        LogoutStatus.failure,
      );
      expect(
        container.read(logoutNotifierProvider).errorMessage,
        contains('Logout Failed'),
      );
    });
  });
}
