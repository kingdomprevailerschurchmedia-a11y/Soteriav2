import '../models/rank_tier.dart';

class RankingConfig {
  // Base points for results
  static const int winPoints = 25;
  static const int lossPoints = -15;
  static const int drawPoints = 5;

  // Placement
  static const int placementGamesRequired = 5;
  static const int initialRankPoints = 0;

  // Divisions
  static const int divisionsPerTier = 3; // e.g., Gold III, Gold II, Gold I

  // Min/Max Points
  static const int minRankPoints = 0;
  static const int maxRankPoints = 999999;

  // Rank Protection (Future hook)
  static const bool enableRankProtection = true;
  static const int protectionThresholdPoints = 0;
}
