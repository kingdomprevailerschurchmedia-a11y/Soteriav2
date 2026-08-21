import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/progression/models/reward_summary.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/post_game_repository.dart';
import 'package:soteria/features/gameplay_engine/data/repositories/firestore_post_game_repository.dart';
import 'package:soteria/features/gameplay_engine/providers/gameplay_providers.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/gameplay_engine/models/answer_review.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/features/player/presentation/providers/progression_providers.dart';

final postGameRepositoryProvider = Provider<PostGameRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final auth = ref.watch(firebaseAuthProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  final progressionRepo = ref.watch(playerProgressionRepositoryProvider);
  return FirestorePostGameRepository(
    firestore,
    auth,
    prefs,
    progressionRepo,
  );
});

class ResultsNotifier extends StateNotifier<AsyncValue<GameResult?>> {
  final PostGameRepository _repository;
  final Ref _ref;

  ResultsNotifier(this._repository, this._ref) : super(const AsyncValue.data(null));

  Future<void> processCompletedSession(
    GameState gameState,
    GameConfiguration config,
  ) async {
    state = const AsyncValue.loading();

    final history = gameState.answerHistory;
    final correct = history.where((r) => r.isCorrect).length;
    final wrong = history.where((r) => r.isWrong).length;
    final total = history.length;

    // Analytics
    final responseTimes = history
        .map((r) => (r.metadata['responseTimeMs'] as num?)?.toInt() ?? 0)
        .toList();
    final avgResponse = responseTimes.isEmpty
        ? 0
        : responseTimes.reduce((a, b) => a + b) / (total == 0 ? 1 : total);
    final fastest = responseTimes.isEmpty
        ? 0
        : responseTimes.reduce((a, b) => a < b ? a : b);
    final slowest = responseTimes.isEmpty
        ? 0
        : responseTimes.reduce((a, b) => a > b ? a : b);

    final rewards = RewardSummary(
      baseXP: correct * 10,
      bonusXP: (gameState.streak >= 5) ? 50 : 0,
      baseCoins: correct * 2,
      streakBonus: gameState.streak * 5,
      perfectScoreBonus: (correct > 0 && correct == gameState.questions.length)
          ? 100
          : 0,
    );

    final result = GameResult(
      sessionId: gameState.sessionId,
      playerId: _ref.read(sessionProvider).uid ?? '',
      mode: config.mode,
      finalScore: gameState.score,
      totalXP: gameState.xp + rewards.totalXP,
      totalQuestions: gameState.questions.length,
      correctAnswers: correct,
      wrongAnswers: wrong,
      skippedQuestions: gameState.questions.length - total,
      totalDuration: DateTime.now().difference(
        gameState.startTime ?? DateTime.now(),
      ),
      accuracy: total == 0 ? 0 : correct / total,
      maxStreak: gameState.streak,
      rewards: rewards,
      avgResponseTime: Duration(milliseconds: avgResponse.toInt()),
      fastestAnswerTime: Duration(milliseconds: fastest),
      slowestAnswerTime: Duration(milliseconds: slowest),
      answers: history,
      timestamp: DateTime.now(),
    );

    try {
      await _repository.syncProgress(result);
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void reset() => state = const AsyncValue.data(null);
}

final resultsProvider =
    StateNotifierProvider<ResultsNotifier, AsyncValue<GameResult?>>((ref) {
      final repo = ref.watch(postGameRepositoryProvider);
      return ResultsNotifier(repo, ref);
    });

final answerReviewProvider = Provider.family<List<AnswerReview>, GameState>((
  ref,
  state,
) {
  return state.questions.map((question) {
    final result = state.answerHistory.firstWhere(
      (r) => r.questionId == question.id,
      orElse: () => AnswerResult(
        submissionId: 'skipped',
        questionId: question.id,
        decision: AnswerDecision.wrong,
        correctOptionIds: question.correctOptionIds,
        timestamp: DateTime.now(),
        questionVersion: question.version,
      ),
    );

    return AnswerReview(
      question: question,
      selectedOptionIds: (result.submissionId == 'skipped')
          ? []
          : (result.metadata['selectedIds'] as List<String>? ?? []),
      isCorrect: result.isCorrect,
      responseTime: Duration(
        milliseconds: (result.metadata['responseTimeMs'] as num?)?.toInt() ?? 0,
      ),
    );
  }).toList();
});
