import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';
import '../../../player/providers/player_providers.dart';
import '../../../question_content/domain/entities/category.dart';
import '../../../question_content/domain/repositories/category_repository.dart';
import '../../../question_content/presentation/providers/category_providers.dart';
import '../../../gameplay_engine/models/practice_session_config.dart';
import '../../../gameplay_engine/models/practice_session.dart';
import '../../../gameplay_engine/services/session_validator.dart';
import '../../../gameplay_engine/services/reward_estimator.dart';
import '../../../gameplay_engine/domain/repositories/practice_repository.dart';
import '../../../gameplay_engine/data/repositories/firestore_practice_repository.dart';

import '../../../question_content/domain/entities/difficulty.dart';
import '../../../player/presentation/providers/progression_providers.dart';

// --- Repositories ---
final practiceRepositoryProvider = Provider<PracticeRepository>((ref) {
  return FirestorePracticeRepository(
    ref.watch(firestoreDatabaseServiceProvider),
  );
});

// --- State Models ---
class PracticeLobbyState {
  final bool isLoading;
  final String? error;
  final List<Category> categories;
  final PracticeSessionConfig config;
  final EstimatedRewards? estimatedRewards;
  final String? validationError;

  const PracticeLobbyState({
    this.isLoading = false,
    this.error,
    this.categories = const [],
    this.config = const PracticeSessionConfig(),
    this.estimatedRewards,
    this.validationError,
  });

  PracticeLobbyState copyWith({
    bool? isLoading,
    String? error,
    List<Category>? categories,
    PracticeSessionConfig? config,
    EstimatedRewards? estimatedRewards,
    String? validationError,
  }) {
    return PracticeLobbyState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      categories: categories ?? this.categories,
      config: config ?? this.config,
      estimatedRewards: estimatedRewards ?? this.estimatedRewards,
      validationError: validationError ?? this.validationError,
    );
  }
}

// --- Notifiers ---
class PracticeLobbyNotifier extends Notifier<PracticeLobbyState> {
  final SessionValidator _validator = SessionValidator();
  bool _mounted = true;

  @override
  PracticeLobbyState build() {
    _mounted = true;
    ref.onDispose(() => _mounted = false);
    // Initial state - use microtask to ensure build finishes first
    Future.microtask(_init);
    return const PracticeLobbyState();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    try {
      final categories = await ref
          .read(categoryRepositoryProvider)
          .getCategories();
      if (_mounted) {
        state = state.copyWith(
          isLoading: false,
          categories: categories,
          config: state.config.copyWith(
            category: categories.isNotEmpty ? categories.first : null,
            categoryIds: categories.isNotEmpty ? [categories.first.id] : [],
          ),
        );
        _updateSummary();
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(isLoading: false, error: e.toString());
      }
    }
  }

  void updateCategory(Category category) {
    state = state.copyWith(
      config: state.config.copyWith(
        category: category,
        categoryIds: [category.id],
        useInterests: false,
      ),
    );
    _updateSummary();
  }

  void updateCategoryById(String categoryId) {
    final category = state.categories.firstWhere((c) => c.id == categoryId, orElse: () => state.categories.first);
    updateCategory(category);
  }

  void toggleCategory(String categoryId) {
    final currentIds = List<String>.from(state.config.categoryIds);
    if (currentIds.contains(categoryId)) {
      currentIds.remove(categoryId);
    } else {
      currentIds.add(categoryId);
    }
    state = state.copyWith(
      config: state.config.copyWith(
        categoryIds: currentIds,
        category: null, // Clear single category if using multi
        useInterests: false,
      ),
    );
    _updateSummary();
  }

  void updateDifficulty(Difficulty difficulty) {
    state = state.copyWith(
      config: state.config.copyWith(difficulty: difficulty),
    );
    _updateSummary();
  }

  void updateQuestionCount(int count) {
    state = state.copyWith(config: state.config.copyWith(questionCount: count));
    _updateSummary();
  }

  void setUseInterests(bool value) {
    state = state.copyWith(
      config: state.config.copyWith(useInterests: value),
    );
    _updateSummary();
  }

  void toggleTimer(bool enabled) {
    state = state.copyWith(
      config: state.config.copyWith(timerEnabled: enabled),
    );
    _updateSummary();
  }

  void _updateSummary() {
    final player = ref.read(currentPlayerProvider);
    final level = ref.read(currentCompetitiveLevelProvider);
    final estimator = ref.read(rewardEstimatorProvider);
    final validationError = _validator.validate(
      config: state.config,
      player: player,
      level: level,
    );
    final estimatedRewards = estimator.estimate(state.config);

    state = state.copyWith(
      validationError: validationError,
      estimatedRewards: estimatedRewards,
    );
  }

  Future<PracticeSession?> startSession() async {
    final player = ref.read(currentPlayerProvider);
    final level = ref.read(currentCompetitiveLevelProvider);
    if (player == null) return null;

    final validationError = _validator.validate(
      config: state.config,
      player: player,
      level: level,
    );
    if (validationError != null) {
      state = state.copyWith(validationError: validationError);
      return null;
    }

    state = state.copyWith(isLoading: true);
    try {
      final session = PracticeSession(
        sessionId: const Uuid().v4(),
        uid: player.uid,
        config: state.config,
        startTime: DateTime.now(),
      );

      await ref.read(practiceRepositoryProvider).createSession(session);
      if (_mounted) {
        state = state.copyWith(isLoading: false);
      }
      return session;
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(isLoading: false, error: e.toString());
      }
      return null;
    }
  }
}

// --- Providers ---
final rewardEstimatorProvider = Provider<RewardEstimator>((ref) {
  return RewardEstimator();
});

final practiceLobbyProvider =
    NotifierProvider<PracticeLobbyNotifier, PracticeLobbyState>(
      PracticeLobbyNotifier.new,
    );
