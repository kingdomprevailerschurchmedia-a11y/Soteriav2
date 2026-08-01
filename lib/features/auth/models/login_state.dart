import 'package:flutter/foundation.dart';

@immutable
class LoginState {
  final String email;
  final String password;
  final bool rememberMe;
  final bool isLoading;
  final String? error;
  final String? userName; // For personalized greeting

  const LoginState({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.isLoading = false,
    this.error,
    this.userName,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? isLoading,
    String? error,
    String? userName,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      userName: userName ?? this.userName,
    );
  }
}
