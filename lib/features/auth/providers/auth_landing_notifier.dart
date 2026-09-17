import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';

class AuthLandingState {
  final bool isLoading;
  final String? error;

  const AuthLandingState({this.isLoading = false, this.error});

  AuthLandingState copyWith({
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return AuthLandingState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class AuthLandingNotifier extends Notifier<AuthLandingState> {
  @override
  AuthLandingState build() {
    return const AuthLandingState();
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading, clearError: loading);
  }

  Future<void> signInWithGoogle() async {
    setLoading(true);
    final stopwatch = Stopwatch()..start();

    try {
      final useCase = ref.read(googleSignInUseCaseProvider);
      final result = await useCase.execute();

      if (result.isSuccess) {
        ref.read(analyticsProvider).logLogin(loginMethod: 'google');
        LoggerService.i('Google Authentication successful', feature: 'Auth');

        final uid = result.userId;
        if (uid != null) {
          final profile = await ref.read(identityRepositoryProvider).getUserProfile(uid);
          final prefs = await SharedPreferences.getInstance();
          
          if (profile != null) {
            await prefs.setString('user_personalization', 'completed');
            ref.read(appLifecycleProvider.notifier).setReady();
          } else {
            ref.read(appLifecycleProvider.notifier).setPersonalization();
            ref.read(navigationServiceProvider).go(SoteriaRoutes.personalization);
          }
        }
      } else {
        final errorMessage =
            result.error?.userMessage ?? 'Google sign in failed.';
        state = state.copyWith(error: errorMessage);
      }
    } catch (e, st) {
      state = state.copyWith(
        error: 'An unexpected error occurred during Google sign in.',
      );
      ref.read(crashlyticsProvider).recordError(e, st);
    } finally {
      stopwatch.stop();
      setLoading(false);
    }
  }
}

final authLandingProvider =
    NotifierProvider<AuthLandingNotifier, AuthLandingState>(
      AuthLandingNotifier.new,
    );
