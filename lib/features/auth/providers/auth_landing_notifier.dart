import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/login_repository.dart';

class AuthLandingState {
  final bool isLoading;
  final String? error;

  const AuthLandingState({
    this.isLoading = false,
    this.error,
  });

  AuthLandingState copyWith({
    bool? isLoading,
    String? error,
  }) {
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

  Future<void> signInWithGoogle(LoginRepository repository) async {
    setLoading(true);
    final result = await repository.loginWithGoogle();
    if (ref.mounted) {
      setLoading(false);
      if (!result.isSuccess) {
        state = state.copyWith(error: result.error?.userMessage ?? 'Google sign in failed.');
      }
    }
  }
}

final authLandingProvider =
    NotifierProvider<AuthLandingNotifier, AuthLandingState>(AuthLandingNotifier.new);
