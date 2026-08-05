import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../domain/repositories/gameplay_repository.dart';
import '../models/game_state.dart';
import '../models/game_configuration.dart';
import '../models/game_lifecycle.dart';
import 'game_engine_provider.dart';
import 'gameplay_providers.dart';
import '../../question_content/domain/entities/question.dart';

/// Orchestrates the high-level session lifecycle: resuming or starting new games.
class GameplaySessionController extends StateNotifier<AsyncValue<GameState?>> {
  final GameplayRepository _repository;
  final Ref _ref;

  GameplaySessionController(this._repository, this._ref)
    : super(const AsyncValue.data(null));

  /// Checks for an active session and resumes it if found.
  Future<void> initialize() async {
    state = const AsyncValue.loading();
    try {
      final activeSession = await _repository.getActiveSession();
      state = AsyncValue.data(activeSession);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Starts a new session with the given configuration and questions.
  Future<void> startNewSession(
    GameConfiguration config,
    List<Question> questions,
  ) async {
    final engine = _ref.read(gameEngineProvider(config).notifier);
    await engine.startSession(questions);
    state = AsyncValue.data(engine.debugState);
  }

  /// Resumes the current active session.
  Future<void> resumeActiveSession(GameConfiguration config) async {
    final active = state.value;
    if (active != null) {
      final engine = _ref.read(gameEngineProvider(config).notifier);
      engine.hydrate(active);
    }
  }
}

final gameplaySessionControllerProvider =
    StateNotifierProvider<GameplaySessionController, AsyncValue<GameState?>>((
      ref,
    ) {
      final repository = ref.watch(gameplayRepositoryProvider);
      return GameplaySessionController(repository, ref);
    });
