import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< HEAD
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
=======
import '../repositories/login_repository.dart';
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30

class AuthLandingState {
  final bool isLoading;
  final String? error;

<<<<<<< HEAD
  const AuthLandingState({this.isLoading = false, this.error});

  AuthLandingState copyWith({bool? isLoading, String? error}) {
=======
  const AuthLandingState({
    this.isLoading = false,
    this.error,
  });

  AuthLandingState copyWith({
    bool? isLoading,
    String? error,
  }) {
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
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

<<<<<<< HEAD
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
=======
  Future<void> signInWithGoogle(LoginRepository repository) async {
    setLoading(true);
    final result = await repository.loginWithGoogle();
    if (ref.mounted) {
      setLoading(false);
      if (!result.isSuccess) {
        state = state.copyWith(error: result.error?.userMessage ?? 'Google sign in failed.');
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
      }
    }
  }
}

final authLandingProvider =
    NotifierProvider<AuthLandingNotifier, AuthLandingState>(
      AuthLandingNotifier.new,
    );
