class LeaderboardConfig {
  static const int defaultPageSize = 50;
  static const int neighborhoodWindowSize = 5; // entries above and below

  // Firestore Collection Names
  static const String globalLeaderboardCollection = 'leaderboard_global';
  static const String seasonLeaderboardCollection = 'leaderboard_seasons';
}
