import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_state.dart';
import '../repositories/login_repository.dart';
import '../repositories/firebase_login_repository.dart';
import '../../../core/identity/providers/firebase_providers.dart';
import '../../../core/utils/identity_validator.dart';

class LoginNotifier extends Notifier<LoginState> {
  static const _kFirstNameKey = 'user_first_name';
  static const _kRememberMeKey = 'login_remember_me';

  @override
  LoginState build() {
    _loadUserGreeting();
    _loadPreferences();
    return const LoginState();
  }

  Future<void> _loadUserGreeting() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_kFirstNameKey);
    if (ref.mounted && name != null) {
      state = state.copyWith(userName: name);
    }
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final remember = prefs.getBool(_kRememberMeKey) ?? false;
    if (ref.mounted) {
      state = state.copyWith(rememberMe: remember);
    }
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email.trim(), error: null);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, error: null);
  }

  void toggleRememberMe(bool? value) async {
    final newValue = value ?? false;
    state = state.copyWith(rememberMe: newValue);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kRememberMeKey, newValue);
  }

  Future<void> login(LoginRepository repository) async {
    if (!IdentityValidator.isValidEmail(state.email)) {
      state = state.copyWith(error: 'Please enter a valid email address.');
      return;
    }

    if (state.password.isEmpty) {
      state = state.copyWith(error: 'Please enter your password.');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await repository.loginWithEmail(
        email: state.email,
        password: state.password,
      );

      if (ref.mounted) {
        if (result.isSuccess) {
          // Success handled by router/service listener usually
          state = state.copyWith(isLoading: false);
        } else {
          state = state.copyWith(
            isLoading: false,
            error: result.error?.userMessage ?? 'Sign in failed. Please try again.',
          );
        }
      }
    } catch (e) {
      if (ref.mounted) {
        state = state.copyWith(
          isLoading: false,
          error: 'An unexpected connection error occurred.',
        );
      }
    }
  }
}

final loginProvider = NotifierProvider<LoginNotifier, LoginState>(LoginNotifier.new);

// Updated repository provider
final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return FirebaseLoginRepository(
    auth: ref.watch(firebaseAuthProvider),
  );
});
