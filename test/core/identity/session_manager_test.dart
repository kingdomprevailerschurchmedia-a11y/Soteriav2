import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/identity/models/user_session.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';

void main() {
  group('SessionNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is guest session', () {
      final session = container.read(sessionProvider);
      expect(session.status, SessionStatus.guest);
    });

    test('setSession updates state', () {
      const session = UserSession(uid: 'user-1', status: SessionStatus.authenticated);
      container.read(sessionProvider.notifier).setSession(session);
      
      expect(container.read(sessionProvider).uid, 'user-1');
      expect(container.read(sessionProvider).isAuthenticated, true);
    });

    test('logout resets to guest', () async {
      const session = UserSession(uid: 'user-1', status: SessionStatus.authenticated);
      container.read(sessionProvider.notifier).setSession(session);
      
      await container.read(sessionProvider.notifier).logout();
      expect(container.read(sessionProvider).status, SessionStatus.guest);
    });
  });
}
