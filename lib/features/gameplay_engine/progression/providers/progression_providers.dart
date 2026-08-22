import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progress_snapshot.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_event.dart';
import 'package:soteria/features/gameplay_engine/progression/services/progression_engine.dart';
import 'package:soteria/features/gameplay_engine/progression/services/level_engine.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_policy.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/player/domain/services/engagement_service.dart';
import 'package:soteria/features/player/domain/repositories/engagement_repository.dart';
import 'package:soteria/features/player/presentation/providers/progression_providers.dart';

/// Notifier for managing the global progression state.
class ProgressionNotifier extends StateNotifier<ProgressSnapshot> {
  final ProgressionEngine _engine;
  final EngagementService _engagementService;
  final EngagementRepository? _engagementRepository;
  final Function(ProgressionEvent)? _onEvent;

  ProgressionNotifier({
    required this._engine,
    required this._engagementService,
    this._engagementRepository,
    this._onEvent,
  }) : super(ProgressSnapshot.initial());

  /// Updates progression based on a question result.
  void handleAnswer(
    AnswerResult result,
    ProgressionPolicy policy, {
    Map<String, dynamic> careerContext = const {},
  }) {
    final outcome = _engine.processAnswer(
      current: state,
      answer: result,
      policy: policy,
      careerContext: careerContext,
    );

    state = outcome.after;

    for (final event in outcome.events) {
      _onEvent?.call(event);
    }
  }

  /// Updates progression based on round completion.
  void handleRoundEnd({
    required String userId,
    required String sessionId,
    required int totalQuestions,
    required int correctAnswers,
    required ProgressionPolicy policy,
    required String timezone,
    Map<String, dynamic> careerContext = const {},
  }) {
    if (state.lastProcessedSessionId == sessionId) return;

    final now = DateTime.now();
    final engagementDate = _engagementService.getEngagementDate(now, timezone);

    final outcome = _engine.processRoundEnd(
      current: state,
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      policy: policy,
      currentEngagementDate: engagementDate,
      isConsecutive: _engagementService.isConsecutive,
      isSameDay: _engagementService.isSameDay,
      careerContext: careerContext,
    );

    state = outcome.after.copyWith(lastProcessedSessionId: sessionId);

    for (final event in outcome.events) {
      _onEvent?.call(event);
    }

    // Trigger authoritative engagement recording
    _engagementRepository?.recordEngagement(
      userId: userId,
      activityType: policy.mode.toString(),
      activityId: sessionId,
      timezone: timezone,
    );
  }

  /// Hydrates the notifier with a baseline snapshot.
  void hydrate(ProgressSnapshot baseline) {
    state = baseline;
  }

  /// Manual reset for testing or session start if needed.
  void resetSession() {
    state = state.copyWith(sessionScore: 0, sessionStreak: 0, sessionCorrectAnswers: 0, sessionCategoryMastery: {});
  }
}

/// Provider for the Level Engine logic.
final levelEngineProvider = Provider<LevelEngine>((ref) => LevelEngine());

/// Provider for the Engagement Service.
final engagementServiceProvider = Provider<EngagementService>((ref) => EngagementService());

/// Provider for the Progression Engine orchestrator.
final progressionEngineProvider = Provider<ProgressionEngine>((ref) {
  final levelEngine = ref.watch(levelEngineProvider);
  return ProgressionEngine(levelEngine: levelEngine);
});

/// Central provider for player progression state.
final progressionProvider =
    StateNotifierProvider<ProgressionNotifier, ProgressSnapshot>((ref) {
      final engine = ref.watch(progressionEngineProvider);
      final engagementService = ref.watch(engagementServiceProvider);
      final engagementRepository = ref.watch(engagementRepositoryProvider);
      return ProgressionNotifier(
        engine: engine,
        engagementService: engagementService,
        engagementRepository: engagementRepository,
        onEvent: (event) {
          if (event is AchievementUnlockedEvent) {
            final userId = ref.read(authRepositoryProvider).currentUserId;
            if (userId != null) {
              ref
                  .read(achievementRepositoryProvider)
                  .unlockAchievement(userId, event.achievementId);
            }
          }
        },
      );
    });

/// Computed provider for current score.
final scoreProvider = Provider<int>(
  (ref) => ref.watch(progressionProvider).score,
);

/// Computed provider for current XP.
final xpProvider = Provider<int>(
  (ref) => ref.watch(progressionProvider).totalXP,
);

/// Computed provider for current level.
final levelProvider = Provider<int>(
  (ref) => ref.watch(progressionProvider).level,
);

/// Computed provider for current streak.
final streakProvider = Provider<int>(
  (ref) => ref.watch(progressionProvider).currentStreak,
);

/// Computed provider for level progress percentage.
final levelProgressProvider = Provider<double>((ref) {
  final snapshot = ref.watch(progressionProvider);
  final engine = ref.watch(levelEngineProvider);
  return engine.calculateLevelProgress(snapshot.totalXP);
});
