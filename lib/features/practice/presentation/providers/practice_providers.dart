import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../gameplay_engine/models/practice_session_config.dart';
import '../../../question_content/domain/selection/selection_models.dart';
import '../../../question_content/presentation/providers/selection_providers.dart';
import '../../../question_content/domain/entities/difficulty.dart';
import '../../../gameplay_engine/models/game_state.dart';
import '../../../gameplay_engine/models/game_mode.dart';
import '../../../player/providers/player_providers.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../../dashboard/presentation/providers/practice_lobby_providers.dart';
import 'practice_history_providers.dart';

import '../../domain/services/practice_result_service.dart';
import '../../domain/models/practice_result.dart';
import '../states/practice_result_state.dart';
import '../../../analytics/presentation/providers/analytics_providers.dart';
import '../../../quiz/domain/models/question_result.dart';
import '../../../quiz/domain/models/quiz_enums.dart' as quiz_enums;
import '../../../quiz/domain/models/question_result.dart' as qr_models;

class PracticeConfigurationNotifier extends StateNotifier<PracticeSessionConfig> {
  PracticeConfigurationNotifier() : super(const PracticeSessionConfig());

  void setDifficulty(Difficulty difficulty) {
    state = state.copyWith(difficulty: difficulty, useInterests: false);
  }

  void toggleCategory(String categoryId) {
    final updatedCategories = List<String>.from(state.categoryIds);
    if (updatedCategories.contains(categoryId)) {
      updatedCategories.remove(categoryId);
    } else {
      updatedCategories.add(categoryId);
    }
    state = state.copyWith(categoryIds: updatedCategories, useInterests: false);
  }

  void setQuestionCount(int count) {
    state = state.copyWith(questionCount: count);
  }

  void setUseInterests(bool useInterests) {
    state = state.copyWith(useInterests: useInterests);
    if (useInterests) {
      state = state.copyWith(categoryIds: []);
    }
  }
}

final practiceConfigurationProvider =
    StateNotifierProvider<PracticeConfigurationNotifier, PracticeSessionConfig>((ref) {
  return PracticeConfigurationNotifier();
});

final practiceQuestionsProvider = FutureProvider<QuestionSelectionResult>((ref) async {
  final lobbyState = ref.watch(practiceLobbyProvider);
  final config = lobbyState.config;
  final selectionService = ref.watch(questionSelectionServiceProvider);
  
  List<String> categories = config.categoryIds;
  if (config.useInterests) {
    final profile = ref.watch(currentPlayerProvider);
    categories = profile?.favoriteCategories ?? [];
  }

  final request = QuestionSelectionRequest(
    categoryIds: categories,
    difficulty: config.difficulty,
    questionCount: config.questionCount,
    mode: GameMode.practice,
  );

  return selectionService.selectQuestions(request);
});

class PracticeResultNotifier extends StateNotifier<PracticeResultState> {
  final Ref ref;
  PracticeResultNotifier(this.ref) : super(const PracticeResultState.initial());

  Future<void> finalize(GameState gameState) async {
    state = const PracticeResultState.calculating();
    try {
      final userId = ref.read(authRepositoryProvider).currentUserId;
      if (userId == null) throw Exception('User not authenticated');

      final player = ref.read(currentPlayerProvider);
      bool rewardsEligible = true;
      if (player != null) {
        final now = DateTime.now();
        final lastDate = player.lastPracticeSessionDate;
        final isNewDay = lastDate == null || 
            lastDate.year != now.year || 
            lastDate.month != now.month || 
            lastDate.day != now.day;
        
        final dailyCount = isNewDay ? 0 : player.dailyPracticeSessionsPlayed;
        rewardsEligible = dailyCount < 5;
      }

      final result = PracticeResultService.calculateResult(
        gameState, 
        userId,
        rewardsEligible: rewardsEligible,
      );
      
      // Persist the result
      await ref.read(practiceResultRepositoryProvider).recordResult(
        result, 
        rewardsEligible: rewardsEligible,
      );

      // Trigger global question analytics updates (Secure individual events)
      final analyticsRepo = ref.read(questionAnalyticsRepositoryProvider);
      for (final item in result.reviewItems) {
        final outcome =
            item.isCorrect
                ? qr_models.QuestionOutcome.correct
                : (item.isSkipped
                    ? qr_models.QuestionOutcome.skipped
                    : qr_models.QuestionOutcome.incorrect);

        final qr = QuestionResult(
          questionId: item.questionId,
          questionNumber: 0,
          questionText: item.questionText,
          outcome: outcome,
          selectedOptionId:
              item.selectedOptionIds.isNotEmpty
                  ? item.selectedOptionIds.first
                  : null,
          correctOptionIds: item.correctOptionIds,
          correctOptionText: '',
          responseTime: item.responseTime,
          scoreEarned: item.isCorrect ? 100 : 0,
          categoryId: item.categoryId,
          mode: quiz_enums.GameMode.practice,
          difficulty: item.difficulty,
          questionVersion: item.questionVersion,
        );
        analyticsRepo.recordEvent(result.sessionId, userId, qr).catchError((_) {});
      }

      state = PracticeResultState.success(result);
      
      // Refresh history
      ref.invalidate(practiceHistoryListProvider);
    } catch (e) {
      state = PracticeResultState.error(e.toString());
    }
  }

  void practiceAgain(PracticeRecommendation recommendation) {
    ref.read(practiceLobbyProvider.notifier).updateCategoryById(recommendation.categoryId);
    ref.read(practiceLobbyProvider.notifier).updateDifficulty(recommendation.difficulty);
    ref.read(practiceLobbyProvider.notifier).updateQuestionCount(recommendation.questionCount);
  }

  void practiceWeakArea(String categoryId) {
    ref.read(practiceLobbyProvider.notifier).updateCategoryById(categoryId);
    ref.read(practiceLobbyProvider.notifier).updateQuestionCount(10);
    // Keep current difficulty or default to Medium
  }

  void reset() {
    state = const PracticeResultState.initial();
  }
}

final practiceResultProvider = StateNotifierProvider<PracticeResultNotifier, PracticeResultState>((ref) {
  return PracticeResultNotifier(ref);
});
