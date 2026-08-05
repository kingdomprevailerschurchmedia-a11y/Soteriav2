import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/firebase/config/providers/configuration_providers.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';
import '../../../player/providers/player_providers.dart';
import '../../../question_content/domain/entities/category.dart';
import '../../../question_content/presentation/providers/question_providers.dart';
import '../../../../features/gameplay_engine/models/pro_mode_config.dart';
import '../../../../features/gameplay_engine/models/pro_session_config.dart';
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
  final bool hasInsufficientCoins;
  final String? validationError;

  const ProLobbyState({
    this.isLoading = false,
    this.error,
    this.config = const ProSessionConfig(),
    this.isOffline = false,
    this.hasInsufficientCoins = false,
    this.validationError,
  });

  ProLobbyState copyWith({
    bool? isLoading,
    String? error,
    ProSessionConfig? config,
    bool? isOffline,
    bool? hasInsufficientCoins,
    String? validationError,
  }) {
    return ProLobbyState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      config: config ?? this.config,
      isOffline: isOffline ?? this.isOffline,
      hasInsufficientCoins: hasInsufficientCoins ?? this.hasInsufficientCoins,
      validationError: validationError ?? this.validationError,
    );
  }
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
    final updatedConfig = config.copyWith(entryFee: fee);

    bool hasInsufficientCoins = false;
    String? validationError;

    if (player != null) {
      hasInsufficientCoins = player.coins < updatedConfig.entryFee;
      if (player.level < proConfig.minLevelRequirement) {
        validationError =
            'MINIMUM LEVEL ${proConfig.minLevelRequirement} REQUIRED';
      }
    }

    return ProLobbyState(
      config: updatedConfig,
      hasInsufficientCoins: hasInsufficientCoins,
      validationError: validationError,
      isOffline: false, // Assume online initially
    );
  }

  Future<void> checkConnection() async {
    // Simulated
    state = state.copyWith(isOffline: false);
  }

  void updateCategory(Category? category) {
    state = state.copyWith(config: state.config.copyWith(category: category));
    _updateValidation();
  }

  void updateDifficulty(ProDifficulty difficulty) {
    final proConfig = ref.read(configurationProvider).proMode;
    final multiplier = proConfig.difficultyMultipliers[difficulty.name] ?? 1.0;

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
    if (player == null) return;

    final hasInsufficientCoins = player.coins < state.config.entryFee;

    // Check if player meets level requirement (from Remote Config)
    final proConfig = ref.read(configurationProvider).proMode;
    String? validationError;
    if (player.level < proConfig.minLevelRequirement) {
      validationError =
          'MINIMUM LEVEL ${proConfig.minLevelRequirement} REQUIRED';
    }

    state = state.copyWith(
      hasInsufficientCoins: hasInsufficientCoins,
      validationError: validationError,
    );
  }

  Future<CompetitiveSession?> startSession() async {
    final player = ref.read(currentPlayerProvider);
    if (player == null ||
        state.hasInsufficientCoins ||
        state.validationError != null)
      return null;

    state = state.copyWith(isLoading: true);
    try {
      final sessionId = const Uuid().v4();

      // Reserve Fee first
      await ref
          .read(proModeRepositoryProvider)
          .reserveEntryFee(player.uid, sessionId, state.config.entryFee);

      final session = CompetitiveSession(
        sessionId: sessionId,
        uid: player.uid,
        config: state.config,
        startTime: DateTime.now(),
        reservedFee: state.config.entryFee,
      );

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
