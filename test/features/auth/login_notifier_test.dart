import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/auth/providers/login_notifier.dart';
import 'package:soteria/features/auth/repositories/login_repository.dart';
import 'package:soteria/features/auth/models/authentication_result.dart';

class MockLoginRepo extends MockLoginRepository {
  @override
  Future<AuthenticationResult> loginWithEmail({required String email, required String password}) async {
    return const AuthenticationResult.success('test-id');
  }
}

void main() {
  group('LoginNotifier', () {
    late ProviderContainer container;

    setUp(() {
      SharedPreferences.setMockInitialValues({
        'user_first_name': 'Koffi',
        'login_remember_me': true,
      });
      container = ProviderContainer();
    });

    test('initial state loads from preferences', () async {
      // Trigger build
      container.read(loginProvider);
      
      // Wait for async initialization in build()
      await Future.delayed(const Duration(milliseconds: 100));
      
      final state = container.read(loginProvider);
      expect(state.userName, 'Koffi');
      expect(state.rememberMe, true);
    });

    test('updateEmail and updatePassword work', () {
      final notifier = container.read(loginProvider.notifier);
      notifier.updateEmail('test@soteria.com');
      notifier.updatePassword('Password123!');
      
      final state = container.read(loginProvider);
      expect(state.email, 'test@soteria.com');
      expect(state.password, 'Password123!');
    });

    test('validation blocks invalid email', () async {
      final notifier = container.read(loginProvider.notifier);
      notifier.updateEmail('invalid');
      await notifier.login(MockLoginRepo());
      
      expect(container.read(loginProvider).error, contains('valid email'));
    });
  });
}
