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

import '../../../../core/logging/logger_service.dart';
import '../../../../features/gameplay_engine/domain/config/competitive_reward_config.dart';
import '../../../player/presentation/providers/progression_providers.dart';
import '../../../../core/network/providers/connectivity_providers.dart';

part 'pro_lobby_providers.freezed.dart';

// --- Repositories ---
final proModeRepositoryProvider = Provider<ProModeRepository>((ref) {
  return FirestoreProModeRepository(
    ref.watch(firestoreDatabaseServiceProvider),
    ref.watch(playerProgressionRepositoryProvider),
    ref.watch(playerRepositoryProvider),
  );
});

// --- State Models ---
@freezed
abstract class ProLobbyState with _$ProLobbyState {
  const factory ProLobbyState({
    @Default(false) bool isLoading,
    @Default(false) bool isStarting,
    String? error,
    @Default(ProSessionConfig()) ProSessionConfig config,
    @Default(false) bool isOffline,
    @Default(ProModeAccessResult.loading()) ProModeAccessResult access,
    @Default([]) List<Category> categories,
    @Default(false) bool isFreeEntry,
    @Default(0) int remainingFreeGames,
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
    
    const config = ProSessionConfig(difficulty: ProDifficulty.intermediate, questionCount: 10);
    final fee = CompetitiveRewardConfig.proEntryFees[config.difficulty.toBaseDifficulty()] ?? 500;
    
    final updatedConfig = config.copyWith(
      entryFee: fee,
      minLevelRequirement: 1, // Default min level
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
          config: state.config.copyWith(
            category: categories.isNotEmpty ? categories.first : null,
            categoryIds: categories.isNotEmpty ? [categories.first.id] : [],
          ),
        );
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(isLoading: false, error: e.toString());
      }
    }
  }

  Future<void> checkConnection() async {
    state = state.copyWith(isOffline: false, error: null);
    _updateValidation();
  }

  void updateCategory(Category? category) {
    state = state.copyWith(
      config: state.config.copyWith(
        category: category,
        categoryIds: category != null ? [category.id] : [],
        useInterests: false,
      ),
    );
    _updateValidation();
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
        category: null, // Clear single category view
        useInterests: false,
      ),
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
    final fee = CompetitiveRewardConfig.proEntryFees[difficulty.toBaseDifficulty()] ?? 0;
    state = state.copyWith(
      config: state.config.copyWith(difficulty: difficulty, entryFee: fee),
    );
    _updateValidation();
  }

  void updateQuestionCount(int count) {
    state = state.copyWith(
      config: state.config.copyWith(questionCount: count),
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
    final rewardConfig = ref.read(configurationProvider).rewards;

    if (player == null) {
      state = state.copyWith(access: const ProModeAccessResult(state: ProModeAccessState.locked));
      return;
    }

    // Calculate free game status
    final now = DateTime.now();
    final bool isNewDay = player.lastProSessionDate == null ||
        player.lastProSessionDate!.year != now.year ||
        player.lastProSessionDate!.month != now.month ||
        player.lastProSessionDate!.day != now.day;

    final usedToday = isNewDay ? 0 : player.dailyProSessionsPlayed;
    final remaining = (rewardConfig.dailyFreeGames - usedToday).clamp(0, rewardConfig.dailyFreeGames);
    final isFree = remaining > 0;

    ProModeAccessResult access = const ProModeAccessResult.available();

    final level = ref.read(currentCompetitiveLevelProvider);
    if (level < state.config.minLevelRequirement) {
      access = ProModeAccessResult(
        state: ProModeAccessState.locked,
        message: 'MINIMUM LEVEL ${state.config.minLevelRequirement} REQUIRED',
      );
    } else if (!isFree && player.coins < state.config.entryFee) {
      access = const ProModeAccessResult(state: ProModeAccessState.insufficientTokens);
    }

    state = state.copyWith(
      access: access,
      isFreeEntry: isFree,
      remainingFreeGames: remaining,
    );
    
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
    } else {
      categoryIds = state.config.categoryIds;
      if (categoryIds.isEmpty) {
        state = state.copyWith(
          access: const ProModeAccessResult(
            state: ProModeAccessState.locked,
            message: 'PLEASE SELECT AT LEAST ONE CATEGORY',
          ),
        );
        return;
      }
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
    final isOnline = ref.read(isOnlineProvider);
    
    if (!isOnline) {
      state = state.copyWith(isOffline: true);
      return null;
    }

    if (player == null || !state.access.isAllowed) return null;

    final isFree = state.isFreeEntry;
    final fee = isFree ? 0 : state.config.entryFee;
    final difficulty = state.config.difficulty.toBaseDifficulty();

    state = state.copyWith(isLoading: true, isStarting: true, error: null);
    
    String? createdSessionId;

    try {
      // 1. Select Questions first (Fail-fast content check)
      final selectionResult = await ref
          .read(questionSelectionServiceProvider)
          .selectQuestions(
            QuestionSelectionRequest(
              categoryIds: state.config.useInterests 
                  ? (player.favoriteCategories ?? []) 
                  : state.config.categoryIds,
              difficulty: difficulty,
              questionCount: state.config.questionCount,
              mode: GameMode.pro,
            ),
          )
          .timeout(const Duration(seconds: 15));

      if (selectionResult.status != SelectionStatus.success) {
        throw Exception(selectionResult.status == SelectionStatus.error 
            ? 'Failed to load competitive content.' 
            : 'Insufficient questions for this configuration.');
      }

      final sessionId = const Uuid().v4();
      createdSessionId = sessionId;

      // 2. Reserve Fee (Authoritative atomic check & stale cleanup)
      await ref
          .read(proModeRepositoryProvider)
          .reserveEntryFee(
            player.uid, 
            sessionId, 
            difficulty, 
            isFree: isFree
          )
          .timeout(const Duration(seconds: 10));

      final session = CompetitiveSession(
        sessionId: sessionId,
        uid: player.uid,
        config: state.config,
        questions: selectionResult.questions,
        startTime: DateTime.now(),
        createdAt: DateTime.now(),
        reservedFee: fee,
      );

      // 3. Create Session Record
      await ref
          .read(proModeRepositoryProvider)
          .createCompetitiveSession(session)
          .timeout(const Duration(seconds: 10));

      return session;
    } catch (e) {
      LoggerService.e('Pro Mode Session Start failed', error: e);
      
      // Authoritative Auto-Refund if fee was reserved but session creation failed
      if (createdSessionId != null && !isFree) {
        try {
          await ref.read(proModeRepositoryProvider).refundEntryFee(
            player.uid, 
            createdSessionId, 
            difficulty,
          );
        } catch (refundError) {
          LoggerService.e('Fail-safe refund failed', error: refundError);
        }
      }

      state = state.copyWith(
        error: _mapStartError(e),
      );
      return null;
    } finally {
      if (_mounted) {
        state = state.copyWith(isLoading: false, isStarting: false);
      }
    }
  }

  String _mapStartError(dynamic e) {
    final msg = e.toString().toLowerCase();
    if (msg.contains('active competitive session already exists')) {
      return 'A session is already in progress. If you were disconnected, please wait 2 minutes for it to expire.';
    }
    if (msg.contains('insufficient coins')) {
      return 'Insufficient coins for Pro Mode entry.';
    }
    if (msg.contains('timeout')) {
      return 'Connection timed out. Please check your internet and try again.';
    }
    return 'Failed to initialize Pro match. Secure settlement error: ${e.toString()}';
  }
}

// --- Providers ---
final proLobbyProvider = NotifierProvider<ProLobbyNotifier, ProLobbyState>(
  ProLobbyNotifier.new,
);

final rewardPreviewProvider = Provider((ref) {
  final config = ref.watch(proLobbyProvider).config;
  
  final difficulty = config.difficulty.toBaseDifficulty();
  final questionCount = config.questionCount;
  
  final maxRewards = CompetitiveRewardConfig.proMaxRewards[difficulty] ?? {};
  final baseMaxReward = maxRewards[questionCount] ?? 0;
  
  // Accuracy multipliers
  final perfectCoinMult = CompetitiveRewardConfig.getProCoinPayoutPercentage(1.0);
  final perfectXpMult = CompetitiveRewardConfig.getProXpMultiplier(1.0);
  
  final baseXpPerCorrect = CompetitiveRewardConfig.proBaseXpPerCorrect[difficulty] ?? 0;

  return {
    'potentialCoins': (baseMaxReward * perfectCoinMult).round(),
    'potentialXP': (questionCount * baseXpPerCorrect * perfectXpMult).round(),
    'multiplier': perfectCoinMult,
  };
});

final riskCalculatorProvider = Provider<RiskLevel>((ref) {
  final config = ref.watch(proLobbyProvider).config;

  if (config.difficulty == ProDifficulty.expert) return RiskLevel.extreme;
  if (config.difficulty == ProDifficulty.advanced) return RiskLevel.high;
  if (config.questionCount >= 30) return RiskLevel.medium;

  return RiskLevel.low;
});
