import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/firebase/config/providers/configuration_providers.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';
import '../../../player/providers/player_providers.dart';
import '../../../question_content/domain/entities/category.dart';
import '../../../question_content/presentation/providers/question_providers.dart';
import '../../../question_content/domain/selection/selection_models.dart';
import '../../../question_content/presentation/providers/selection_providers.dart';
import '../../../../features/gameplay_engine/models/pro_mode_config.dart';
import '../../../../features/gameplay_engine/models/game_mode.dart';
import '../../../../features/gameplay_engine/models/pro_session_config.dart';
import '../../../../features/gameplay_engine/models/pro_mode_access.dart';
import '../../../../features/gameplay_engine/models/competitive_session.dart';
import '../../../../features/gameplay_engine/domain/repositories/pro_mode_repository.dart';
import '../../../../features/gameplay_engine/data/repositories/firestore_pro_mode_repository.dart';
import '../../../question_content/domain/repositories/category_repository.dart';
import '../../../question_content/presentation/providers/category_providers.dart';

import '../../../player/presentation/providers/progression_providers.dart';

part 'pro_lobby_providers.freezed.dart';

// --- Repositories ---
final proModeRepositoryProvider = Provider<ProModeRepository>((ref) {
  return FirestoreProModeRepository(
    ref.watch(firestoreDatabaseServiceProvider),
    ref.watch(playerProgressionRepositoryProvider),
  );
});

// --- State Models ---
@freezed
abstract class ProLobbyState with _$ProLobbyState {
  const factory ProLobbyState({
    @Default(false) bool isLoading,
    String? error,
    @Default(ProSessionConfig()) ProSessionConfig config,
    @Default(false) bool isOffline,
    @Default(ProModeAccessResult.loading()) ProModeAccessResult access,
    @Default([]) List<Category> categories,
  }) = _ProLobbyState;

  const ProLobbyState._();

  bool get hasInsufficientCoins => access.state == ProModeAccessState.insufficientTokens;
  String? get validationError => access.message;
}

// --- Notifiers ---
class ProLobbyNotifier extends Notifier<ProLobbyState> {
  bool _mounted = true;

  @override
  ProLobbyState build() {
    _mounted = true;
    ref.onDispose(() => _mounted = false);
    // Trigger initial validation and category fetch
    Future.microtask(() => _init());
    return _getInitialState();
  }

  ProLobbyState _getInitialState() {
    final player = ref.read(currentPlayerProvider);
    final proConfig = ref.read(configurationProvider).proMode;

    const config = ProSessionConfig();
    final fee = proConfig.entryFees[config.questionCount] ?? 100;
    final updatedConfig = config.copyWith(
      entryFee: fee,
      minLevelRequirement: proConfig.minLevelRequirement,
    );

    ProModeAccessResult access = const ProModeAccessResult.available();

    if (player != null) {
      final level = ref.read(currentCompetitiveLevelProvider);
      if (level < updatedConfig.minLevelRequirement) {
        access = ProModeAccessResult(
          state: ProModeAccessState.locked,
          message: 'MINIMUM LEVEL ${updatedConfig.minLevelRequirement} REQUIRED',
        );
      } else if (player.coins < updatedConfig.entryFee) {
        access = const ProModeAccessResult(state: ProModeAccessState.insufficientTokens);
      }
    }

    return ProLobbyState(
      config: updatedConfig,
      access: access,
      isOffline: false,
    );
  }

  Future<void> _init() async {
    await _fetchCategories();
    _updateValidation();
  }

  Future<void> _fetchCategories() async {
    state = state.copyWith(isLoading: true);
    try {
      final categories = await ref.read(categoryRepositoryProvider).getCategories();
      if (_mounted) {
        state = state.copyWith(
          isLoading: false,
          categories: categories,
        );
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(isLoading: false, error: e.toString());
      }
    }
  }

  Future<void> checkConnection() async {
    state = state.copyWith(isOffline: false);
    _updateValidation();
  }

  void updateCategory(Category? category) {
    state = state.copyWith(
      config: state.config.copyWith(category: category, useInterests: false),
    );
    _updateValidation();
  }

  void setUseInterests(bool value) {
    state = state.copyWith(
      config: state.config.copyWith(useInterests: value),
    );
    if (value) {
      state = state.copyWith(config: state.config.copyWith(category: null));
    }
    _updateValidation();
  }

  void updateDifficulty(ProDifficulty difficulty) {
    final proConfig = ref.read(configurationProvider).proMode;
    state = state.copyWith(
      config: state.config.copyWith(difficulty: difficulty),
    );
    _updateValidation();
  }

  void updateQuestionCount(int count) {
    final proConfig = ref.read(configurationProvider).proMode;
    final fee = proConfig.entryFees[count] ?? 100;

    state = state.copyWith(
      config: state.config.copyWith(questionCount: count, entryFee: fee),
    );
    _updateValidation();
  }

  void toggleTimer(bool enabled) {
    state = state.copyWith(
      config: state.config.copyWith(timerEnabled: enabled),
    );
    _updateValidation();
  }

  void _updateValidation() {
    final player = ref.read(currentPlayerProvider);
    if (player == null) {
      state = state.copyWith(access: const ProModeAccessResult(state: ProModeAccessState.locked));
      return;
    }

    ProModeAccessResult access = const ProModeAccessResult.available();

    final level = ref.read(currentCompetitiveLevelProvider);
    if (level < state.config.minLevelRequirement) {
      access = ProModeAccessResult(
        state: ProModeAccessState.locked,
        message: 'MINIMUM LEVEL ${state.config.minLevelRequirement} REQUIRED',
      );
    } else if (player.coins < state.config.entryFee) {
      access = const ProModeAccessResult(state: ProModeAccessState.insufficientTokens);
    }

    state = state.copyWith(access: access);
    
    if (access.isAllowed) {
      _checkAvailability();
    }
  }

  Future<void> _checkAvailability() async {
    List<String>? categoryIds;
    
    if (state.config.useInterests) {
      final player = ref.read(currentPlayerProvider);
      categoryIds = player?.favoriteCategories ?? [];
      if (categoryIds.isEmpty) {
        state = state.copyWith(
          access: const ProModeAccessResult(
            state: ProModeAccessState.insufficientContent,
            message: 'NO INTERESTS DEFINED IN PROFILE',
          ),
        );
        return;
      }
    } else if (state.config.category != null) {
      categoryIds = [state.config.category!.id];
    }

    final count = await ref.read(proModeRepositoryProvider).getAvailableQuestionCount(
      categoryIds: categoryIds,
      difficulty: state.config.difficulty.toBaseDifficulty(),
    );

    if (count < state.config.questionCount) {
      state = state.copyWith(
        access: ProModeAccessResult(
          state: ProModeAccessState.insufficientContent,
          message: 'ONLY $count QUESTIONS AVAILABLE (${state.config.questionCount} REQUIRED)',
          metadata: {'available': count, 'required': state.config.questionCount},
        ),
      );
    }
  }

  Future<CompetitiveSession?> startSession() async {
    final player = ref.read(currentPlayerProvider);
    if (player == null || !state.access.isAllowed) return null;

    state = state.copyWith(isLoading: true);
    try {
      // 1. Select Questions first (Fail-fast content check)
      List<String> categories = [];
      if (state.config.useInterests) {
        final profile = ref.read(currentPlayerProvider);
        categories = profile?.favoriteCategories ?? [];
      } else if (state.config.category != null) {
        categories = [state.config.category!.id];
      }

      final selectionResult = await ref.read(questionSelectionServiceProvider).selectQuestions(
        QuestionSelectionRequest(
          categoryIds: categories,
          difficulty: state.config.difficulty.toBaseDifficulty(),
          questionCount: state.config.questionCount,
          mode: GameMode.pro,
        ),
      );

      if (selectionResult.status != SelectionStatus.success) {
        state = state.copyWith(
          isLoading: false,
          access: const ProModeAccessResult(state: ProModeAccessState.insufficientContent),
        );
        return null;
      }

      final sessionId = const Uuid().v4();

      // 2. Reserve Fee (Authoritative atomic check)
      await ref
          .read(proModeRepositoryProvider)
          .reserveEntryFee(player.uid, sessionId, state.config.entryFee);

      final session = CompetitiveSession(
        sessionId: sessionId,
        uid: player.uid,
        config: state.config,
        questions: selectionResult.questions,
        startTime: DateTime.now(),
        reservedFee: state.config.entryFee,
      );

      // 3. Create Session Record
      await ref
          .read(proModeRepositoryProvider)
          .createCompetitiveSession(session);

      state = state.copyWith(isLoading: false);
      return session;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }
}

// --- Providers ---
final proLobbyProvider = NotifierProvider<ProLobbyNotifier, ProLobbyState>(
  ProLobbyNotifier.new,
);

final rewardPreviewProvider = Provider((ref) {
  final config = ref.watch(proLobbyProvider).config;
  final proModeConfig = ref.watch(configurationProvider).proMode;

  final multiplier =
      proModeConfig.difficultyMultipliers[config.difficulty.name] ?? 1.0;
  final baseReward = config.entryFee * 2; // Simple double your money

  return {
    'potentialCoins': (baseReward * multiplier).toInt(),
    'potentialXP': (config.questionCount * 20 * multiplier).toInt(),
    'multiplier': multiplier,
  };
});

final riskCalculatorProvider = Provider<RiskLevel>((ref) {
  final config = ref.watch(proLobbyProvider).config;

  if (config.difficulty == ProDifficulty.expert) return RiskLevel.extreme;
  if (config.difficulty == ProDifficulty.advanced) return RiskLevel.high;
  if (config.questionCount >= 30) return RiskLevel.medium;

  return RiskLevel.low;
});
