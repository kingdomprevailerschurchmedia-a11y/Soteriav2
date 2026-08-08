import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:soteria/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/logging/logger_service.dart';

enum LogoutStatus { initial, loading, success, failure }

class LogoutState {
  final LogoutStatus status;
  final String? errorMessage;

  const LogoutState({this.status = LogoutStatus.initial, this.errorMessage});

  LogoutState copyWith({LogoutStatus? status, String? errorMessage}) {
    return LogoutState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class LogoutNotifier extends StateNotifier<LogoutState> {
  final LogoutUseCase _logoutUseCase;
  final Ref _ref;

  LogoutNotifier(this._logoutUseCase, this._ref) : super(const LogoutState());

  Future<void> logout() async {
    state = state.copyWith(status: LogoutStatus.loading);

    try {
      LoggerService.i('Initiating secure logout sequence...', feature: 'Auth');

      // 1. Perform Sign Out from Repository/Data Source
      await _logoutUseCase.execute();

      // 2. Clear Session and App State
      await _ref.read(sessionProvider.notifier).logout();

      // 3. Invalidate specific providers to clear cached data
      _ref.invalidate(profileProvider);

      LoggerService.i(
        'Logout sequence completed successfully.',
        feature: 'Auth',
      );
      state = state.copyWith(status: LogoutStatus.success);
    } catch (e, st) {
      LoggerService.e(
        'Logout failed during sequence execution',
        error: e,
        stackTrace: st,
        feature: 'Auth',
      );
      state = state.copyWith(
        status: LogoutStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }
}

final logoutNotifierProvider =
    StateNotifierProvider<LogoutNotifier, LogoutState>((ref) {
      final logoutUseCase = ref.watch(logoutUseCaseProvider);
      return LogoutNotifier(logoutUseCase, ref);
    });
