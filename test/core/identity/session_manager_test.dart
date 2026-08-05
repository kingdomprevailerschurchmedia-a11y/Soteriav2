import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/identity/models/user_session.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
<<<<<<< HEAD
import '../../test_helper.dart';
=======
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30

void main() {
  group('SessionNotifier', () {
    late ProviderContainer container;

    setUp(() {
<<<<<<< HEAD
      container = ProviderContainer(
        overrides: [
          identityRepositoryProvider.overrideWithValue(MockIdentityRepo()),
        ],
      );
=======
      container = ProviderContainer();
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is guest session', () {
      final session = container.read(sessionProvider);
      expect(session.status, SessionStatus.guest);
    });

    test('setSession updates state', () {
<<<<<<< HEAD
      const session = UserSession(
        uid: 'user-1',
        status: SessionStatus.authenticated,
      );
      container.read(sessionProvider.notifier).setSession(session);

=======
      const session = UserSession(uid: 'user-1', status: SessionStatus.authenticated);
      container.read(sessionProvider.notifier).setSession(session);
      
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
      expect(container.read(sessionProvider).uid, 'user-1');
      expect(container.read(sessionProvider).isAuthenticated, true);
    });

    test('logout resets to guest', () async {
<<<<<<< HEAD
      const session = UserSession(
        uid: 'user-1',
        status: SessionStatus.authenticated,
      );
      container.read(sessionProvider.notifier).setSession(session);

=======
      const session = UserSession(uid: 'user-1', status: SessionStatus.authenticated);
      container.read(sessionProvider.notifier).setSession(session);
      
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
      await container.read(sessionProvider.notifier).logout();
      expect(container.read(sessionProvider).status, SessionStatus.guest);
    });
  });
}
