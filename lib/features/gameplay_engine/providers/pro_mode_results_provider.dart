import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/pro_mode_result.dart';
import '../models/game_state.dart';
import '../../dashboard/presentation/providers/pro_lobby_providers.dart';

/// State for the Pro Mode results experience.
class ProModeResultsState {
  final AsyncValue<ProModeResult> result;
  final bool isCompleting;

  const ProModeResultsState({
    required this.result,
    this.isCompleting = false,
  });

  ProModeResultsState copyWith({
    AsyncValue<ProModeResult>? result,
    bool? isCompleting,
  }) {
    return ProModeResultsState(
      result: result ?? this.result,
      isCompleting: isCompleting ?? this.isCompleting,
    );
  }
}

/// Notifier to manage session completion and result retrieval for Pro Mode.
class ProModeResultsNotifier extends StateNotifier<ProModeResultsState> {
  final Ref _ref;

  ProModeResultsNotifier(this._ref)
    : super(const ProModeResultsState(result: AsyncValue.loading()));

  /// Fetches an existing result from the repository.
  Future<void> loadResult(String sessionId) async {
    state = state.copyWith(result: const AsyncValue.loading());
    try {
      final repo = _ref.read(proModeRepositoryProvider);
      final result = await repo.getResult(sessionId);
      if (result != null) {
        state = state.copyWith(result: AsyncValue.data(result));
      } else {
        state = state.copyWith(
          result: AsyncValue.error('Result not found', StackTrace.current),
        );
      }
    } catch (e, st) {
      state = state.copyWith(result: AsyncValue.error(e, st));
    }
  }

  /// Authoritatively completes the session and grants rewards.
  Future<void> completeSession(GameState finalState) async {
    state = state.copyWith(isCompleting: true, result: const AsyncValue.loading());
    try {
      final repo = _ref.read(proModeRepositoryProvider);
      final result = await repo.completeSession(finalState.sessionId, finalState);
      state = state.copyWith(result: AsyncValue.data(result), isCompleting: false);
    } catch (e, st) {
      state = state.copyWith(result: AsyncValue.error(e, st), isCompleting: false);
    }
  }
}

final proModeResultsProvider =
    StateNotifierProvider<ProModeResultsNotifier, ProModeResultsState>((ref) {
      return ProModeResultsNotifier(ref);
    });
