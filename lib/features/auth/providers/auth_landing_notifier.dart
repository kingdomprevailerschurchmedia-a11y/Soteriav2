import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';

class AuthLandingState {
  final bool isLoading;
  final String? error;

  const AuthLandingState({this.isLoading = false, this.error});

  AuthLandingState copyWith({bool? isLoading, String? error}) {
    return AuthLandingState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthLandingNotifier extends Notifier<AuthLandingState> {
  @override
  AuthLandingState build() {
    return const AuthLandingState();
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  Future<void> signInWithGoogle() async {
    setLoading(true);
    final stopwatch = Stopwatch()..start();

    try {
      final useCase = ref.read(googleSignInUseCaseProvider);
      final result = await useCase.execute();

      if (ref.mounted) {
        if (result.isSuccess) {
          ref.read(analyticsProvider).logLogin(loginMethod: 'google');
          LoggerService.i('Google Authentication successful', feature: 'Auth');
        } else {
          final errorMessage =
              result.error?.userMessage ?? 'Google sign in failed.';
          state = state.copyWith(error: errorMessage);
        }
      }
    } catch (e, st) {
      if (ref.mounted) {
        state = state.copyWith(
          error: 'An unexpected error occurred during Google sign in.',
        );
        ref.read(crashlyticsProvider).recordError(e, st);
      }
    } finally {
      stopwatch.stop();
      if (ref.mounted) {
        setLoading(false);
      }
    }
  }
}

final authLandingProvider =
    NotifierProvider<AuthLandingNotifier, AuthLandingState>(
      AuthLandingNotifier.new,
    );
