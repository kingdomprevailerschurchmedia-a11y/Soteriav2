import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/identity_provider.dart';

class AuthLandingState {
  final bool isLoading;
  final String? error;
  final bool isGuestAvailable;

  const AuthLandingState({
    this.isLoading = false,
    this.error,
    this.isGuestAvailable = false,
  });

  AuthLandingState copyWith({
    bool? isLoading,
    String? error,
    bool? isGuestAvailable,
  }) {
    return AuthLandingState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isGuestAvailable: isGuestAvailable ?? this.isGuestAvailable,
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

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  Future<void> signInWithProvider(IdentityProvider provider) async {
    setLoading(true);
    // Simulation of provider sign in
    await Future.delayed(const Duration(seconds: 2));
    setLoading(false);
  }
}

final authLandingProvider =
    NotifierProvider<AuthLandingNotifier, AuthLandingState>(AuthLandingNotifier.new);
