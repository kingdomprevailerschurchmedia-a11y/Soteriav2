import 'package:flutter/foundation.dart';
import '../../../../features/gameplay_engine/models/pro_mode_config.dart';
import '../../../../features/tournaments/domain/models/tournament_config.dart';

@immutable
class AppConfiguration {
  final GameplayConfig gameplay;
  final FeatureConfig features;
  final RewardConfig rewards;
  final LifelineConfig lifelines;
  final MaintenanceConfig maintenance;
  final ProModeConfig proMode;
  final TournamentConfig tournament;
  final Map<String, dynamic> rawValues;

  const AppConfiguration({
    required this.gameplay,
    required this.features,
    required this.rewards,
    required this.lifelines,
    required this.maintenance,
    required this.proMode,
    required this.tournament,
    this.rawValues = const {},
  });

  factory AppConfiguration.defaults() => AppConfiguration(
    gameplay: const GameplayConfig.defaults(),
    features: const FeatureConfig.defaults(),
    rewards: const RewardConfig.defaults(),
    lifelines: const LifelineConfig.defaults(),
    maintenance: const MaintenanceConfig.defaults(),
    proMode: ProModeConfig.defaults(),
    tournament: const TournamentConfig.defaults(),
  );

  AppConfiguration copyWith({
    GameplayConfig? gameplay,
    FeatureConfig? features,
    RewardConfig? rewards,
    LifelineConfig? lifelines,
    MaintenanceConfig? maintenance,
    ProModeConfig? proMode,
    TournamentConfig? tournament,
    Map<String, dynamic>? rawValues,
  }) {
    return AppConfiguration(
      gameplay: gameplay ?? this.gameplay,
      features: features ?? this.features,
      rewards: rewards ?? this.rewards,
      lifelines: lifelines ?? this.lifelines,
      maintenance: maintenance ?? this.maintenance,
      proMode: proMode ?? this.proMode,
      tournament: tournament ?? this.tournament,
      rawValues: rawValues ?? this.rawValues,
    );
  }
}

@immutable
class GameplayConfig {
  final int defaultQuestionTimer;
  final int minTimer;
  final int maxTimer;
  final double questionTransitionDelay;
  final int pointsPerCorrect;
  final int wrongAnswerPenalty;
  final int streakBonus;
  final int perfectRoundBonus;

  const GameplayConfig({
    required this.defaultQuestionTimer,
    required this.minTimer,
    required this.maxTimer,
    required this.questionTransitionDelay,
    required this.pointsPerCorrect,
    required this.wrongAnswerPenalty,
    required this.streakBonus,
    required this.perfectRoundBonus,
  });

  const GameplayConfig.defaults()
    : defaultQuestionTimer = 15,
      minTimer = 5,
      maxTimer = 60,
      questionTransitionDelay = 1.5,
      pointsPerCorrect = 100,
      wrongAnswerPenalty = 25,
      streakBonus = 10,
      perfectRoundBonus = 500;
}

@immutable
class FeatureConfig {
  final bool enablePractice;
  final bool enableProMode;
  final bool enableTournament;
  final bool enableVersus;
  final bool enableMarketplace;
  final bool enableAICoach;
  final bool enableClubs;
  final bool enableFriends;
  final bool enablePremium;

  const FeatureConfig({
    required this.enablePractice,
    required this.enableProMode,
    required this.enableTournament,
    required this.enableVersus,
    required this.enableMarketplace,
    required this.enableAICoach,
    required this.enableClubs,
    required this.enableFriends,
    required this.enablePremium,
  });

  const FeatureConfig.defaults()
    : enablePractice = true,
      enableProMode = false,
      enableTournament = false,
      enableVersus = false,
      enableMarketplace = false,
      enableAICoach = false,
      enableClubs = false,
      enableFriends = false,
      enablePremium = false;

  FeatureConfig copyWith({
    bool? enablePractice,
    bool? enableProMode,
    bool? enableTournament,
    bool? enableVersus,
    bool? enableMarketplace,
    bool? enableAICoach,
    bool? enableClubs,
    bool? enableFriends,
    bool? enablePremium,
  }) {
    return FeatureConfig(
      enablePractice: enablePractice ?? this.enablePractice,
      enableProMode: enableProMode ?? this.enableProMode,
      enableTournament: enableTournament ?? this.enableTournament,
      enableVersus: enableVersus ?? this.enableVersus,
      enableMarketplace: enableMarketplace ?? this.enableMarketplace,
      enableAICoach: enableAICoach ?? this.enableAICoach,
      enableClubs: enableClubs ?? this.enableClubs,
      enableFriends: enableFriends ?? this.enableFriends,
      enablePremium: enablePremium ?? this.enablePremium,
    );
  }
}

@immutable
class RewardConfig {
  final int dailyFreeGames;
  final double practiceXpMultiplier;
  final double tournamentXpMultiplier;
  final int leaderboardRefreshInterval;

  const RewardConfig({
    required this.dailyFreeGames,
    required this.practiceXpMultiplier,
    required this.tournamentXpMultiplier,
    required this.leaderboardRefreshInterval,
  });

  const RewardConfig.defaults()
    : dailyFreeGames = 5,
      practiceXpMultiplier = 1.0,
      tournamentXpMultiplier = 2.5,
      leaderboardRefreshInterval = 300; // seconds
}

@immutable
class LifelineConfig {
  final bool enableFiftyFifty;
  final bool enablePauseTimer;
  final bool enableAskAudience;
  final int maxUsesPerMatch;

  const LifelineConfig({
    required this.enableFiftyFifty,
    required this.enablePauseTimer,
    required this.enableAskAudience,
    required this.maxUsesPerMatch,
  });

  const LifelineConfig.defaults()
    : enableFiftyFifty = true,
      enablePauseTimer = true,
      enableAskAudience = true,
      maxUsesPerMatch = 3;
}

@immutable
class MaintenanceConfig {
  final bool isEnabled;
  final String message;
  final String minAppVersion;
  final bool forceUpgrade;

  const MaintenanceConfig({
    required this.isEnabled,
    required this.message,
    required this.minAppVersion,
    required this.forceUpgrade,
  });

  const MaintenanceConfig.defaults()
    : isEnabled = false,
      message = 'Soteria is currently undergoing scheduled maintenance.',
      minAppVersion = '1.0.0',
      forceUpgrade = false;
}
