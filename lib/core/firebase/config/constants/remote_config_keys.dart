class RemoteConfigKeys {
  // Gameplay
  static const String defaultQuestionTimer = 'gameplay_default_timer';
  static const String minTimer = 'gameplay_min_timer';
  static const String maxTimer = 'gameplay_max_timer';
  static const String questionTransitionDelay = 'gameplay_transition_delay';
  static const String pointsPerCorrect = 'gameplay_points_per_correct';
  static const String wrongAnswerPenalty = 'gameplay_wrong_penalty';
  static const String streakBonus = 'gameplay_streak_bonus';
  static const String perfectRoundBonus = 'gameplay_perfect_round_bonus';

  // Features
  static const String enablePractice = 'feature_enable_practice';
  static const String enableProMode = 'feature_enable_pro_mode';
  static const String enableTournament = 'feature_enable_tournament';
  static const String enableVersus = 'feature_enable_versus';
  static const String enableMarketplace = 'feature_enable_marketplace';
  static const String enableAICoach = 'feature_enable_ai_coach';
  static const String enableClubs = 'feature_enable_clubs';
  static const String enableFriends = 'feature_enable_friends';
  static const String enablePremium = 'feature_enable_premium';

  // Rewards
  static const String dailyFreeGames = 'reward_daily_free_games';
  static const String practiceXpMultiplier = 'reward_practice_xp_mult';
  static const String tournamentXpMultiplier = 'reward_tournament_xp_mult';
  static const String leaderboardRefreshInterval = 'reward_leaderboard_refresh';

  // Lifelines
  static const String enableFiftyFifty = 'lifeline_enable_5050';
  static const String enablePauseTimer = 'lifeline_enable_pause';
  static const String enableAskAudience = 'lifeline_enable_audience';
  static const String maxLifelinesPerMatch = 'lifeline_max_uses';

  // Maintenance
  static const String maintenanceEnabled = 'maintenance_enabled';
  static const String maintenanceMessage = 'maintenance_message';
  static const String minAppVersion = 'maintenance_min_version';
  static const String forceUpgrade = 'maintenance_force_upgrade';
}
