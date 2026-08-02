import 'package:flutter/foundation.dart';
import '../../config/firebase_config.dart';

enum AppCheckTokenState { unknown, valid, expired, error }

@immutable
class SecurityStatus {
  final FirebaseEnvironment environment;
  final String providerName;
  final AppCheckTokenState tokenState;
  final bool isInitialized;
  final DateTime? lastRefreshTime;
  final String? errorMessage;

  const SecurityStatus({
    required this.environment,
    required this.providerName,
    this.tokenState = AppCheckTokenState.unknown,
    this.isInitialized = false,
    this.lastRefreshTime,
    this.errorMessage,
  });

  SecurityStatus copyWith({
    AppCheckTokenState? tokenState,
    bool? isInitialized,
    DateTime? lastRefreshTime,
    String? errorMessage,
  }) {
    return SecurityStatus(
      environment: environment,
      providerName: providerName,
      tokenState: tokenState ?? this.tokenState,
      isInitialized: isInitialized ?? this.isInitialized,
      lastRefreshTime: lastRefreshTime ?? this.lastRefreshTime,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
