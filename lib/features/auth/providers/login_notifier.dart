import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_state.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import 'package:soteria/core/utils/identity_validator.dart';
import 'package:soteria/core/logging/logger_service.dart';
import '../models/authentication_result.dart';
import 'auth_providers.dart';

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
    if (name != null) {
      state = state.copyWith(userName: name);
    }
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final remember = prefs.getBool(_kRememberMeKey) ?? false;
    if (remember != null) {
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

  Future<void> login() async {
    if (!IdentityValidator.isValidEmail(state.email)) {
      state = state.copyWith(error: 'Please enter a valid email address.');
      return;
    }

    if (state.password.isEmpty) {
      state = state.copyWith(error: 'Please enter your password.');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    final stopwatch = Stopwatch()..start();

    try {
      final useCase = ref.read(signInUseCaseProvider);
      final result = await useCase.execute(state.email, state.password);

      if (result.isSuccess) {
        ref.read(analyticsProvider).logLogin(loginMethod: 'email');
        LoggerService.i('Authentication successful', feature: 'Auth');
      } else if (result.status == AuthenticationStatus.unverified) {
        LoggerService.i(
          'Authentication blocked: Email unverified',
          feature: 'Auth',
        );
        state = state.copyWith(
          error: 'Please verify your email address before signing in.',
        );
      } else {
        final errorMessage =
            result.error?.userMessage ?? 'Sign in failed. Please try again.';
        LoggerService.w(
          'Authentication failed: ${result.error?.message}',
          feature: 'Auth',
          metadata: {'email': state.email, 'type': result.error?.type.name},
        );
        state = state.copyWith(error: errorMessage);
      }
    } catch (e, st) {
      LoggerService.e(
        'Unexpected Auth Crash during login',
        error: e,
        stackTrace: st,
        feature: 'Auth',
      );
      state = state.copyWith(
        error: 'An unexpected connection error occurred.',
      );
      ref
          .read(crashlyticsProvider)
          .recordError(e, st, reason: 'Unexpected Auth Crash');
    } finally {
      stopwatch.stop();
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final useCase = ref.read(googleSignInUseCaseProvider);
      final result = await useCase.execute();

      if (!result.isSuccess && result.error != null) {
        state = state.copyWith(error: result.error!.userMessage);
      }
    } catch (e, st) {
      state = state.copyWith(error: 'Google Sign-In failed.');
      ref.read(crashlyticsProvider).recordError(e, st);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> resetPassword() async {
    if (!IdentityValidator.isValidEmail(state.email)) {
      state = state.copyWith(error: 'Please enter a valid email address.');
      return;
    }

    try {
      await ref.read(forgotPasswordUseCaseProvider).execute(state.email);
      state = state.copyWith(error: 'Password reset email sent.');
    } catch (e) {
      state = state.copyWith(error: 'Failed to send reset email.');
    }
  }
}

final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);
