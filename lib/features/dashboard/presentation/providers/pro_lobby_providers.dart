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

// --- Repositories ---
final proModeRepositoryProvider = Provider<ProModeRepository>((ref) {
  return FirestoreProModeRepository(
    ref.watch(firestoreDatabaseServiceProvider),
  );
});

// --- State Models ---
class ProLobbyState {
  final bool isLoading;
  final String? error;
  final ProSessionConfig config;
  final bool isOffline;
  final ProModeAccessResult access;

  const ProLobbyState({
    this.isLoading = false,
    this.error,
    this.config = const ProSessionConfig(),
    this.isOffline = false,
    this.access = const ProModeAccessResult.loading(),
  });

  ProLobbyState copyWith({
    bool? isLoading,
    String? error,
    ProSessionConfig? config,
    bool? isOffline,
    ProModeAccessResult? access,
  }) {
    return ProLobbyState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      config: config ?? this.config,
      isOffline: isOffline ?? this.isOffline,
      access: access ?? this.access,
    );
  }

  bool get hasInsufficientCoins => access.state == ProModeAccessState.insufficientTokens;
  String? get validationError => access.message;
}

// --- Notifiers ---
class ProLobbyNotifier extends Notifier<ProLobbyState> {
  @override
  ProLobbyState build() {
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
      if (player.level < updatedConfig.minLevelRequirement) {
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

  Future<void> checkConnection() async {
    state = state.copyWith(isOffline: false);
    _updateValidation();
  }

  void updateCategory(Category? category) {
    state = state.copyWith(config: state.config.copyWith(category: category));
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

    if (player.level < state.config.minLevelRequirement) {
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
    final count = await ref.read(proModeRepositoryProvider).getAvailableQuestionCount(
      categoryId: state.config.category?.id,
      difficulty: state.config.difficulty.toBaseDifficulty(),
    );

    if (count < state.config.questionCount) {
      state = state.copyWith(
        access: ProModeAccessResult(
          state: ProModeAccessState.insufficientContent,
          message: 'Not enough questions available for this configuration.',
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
      final selectionResult = await ref.read(questionSelectionServiceProvider).selectQuestions(
        QuestionSelectionRequest(
          categoryIds: state.config.category != null ? [state.config.category!.id] : [],
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
