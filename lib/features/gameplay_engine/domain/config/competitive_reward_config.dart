import '../../../question_content/domain/entities/difficulty.dart';

class CompetitiveRewardConfig {
  // --- PRO MODE ENTRY FEES ---
  static const Map<Difficulty, int> proEntryFees = {
    Difficulty.easy: 100,      // Foundation
    Difficulty.medium: 500,    // Intermediate
    Difficulty.hard: 2000,     // Advanced
    Difficulty.expert: 5000,   // Expert
    Difficulty.adaptive: 0,    // Adaptive
  };

  // --- PRO MODE MAX COIN REWARDS ---
  static const Map<Difficulty, Map<int, int>> proMaxRewards = {
    Difficulty.easy: {
      10: 1000,
      20: 3000,
      30: 5000,
      50: 10000,
    },
    Difficulty.medium: {
      10: 2000,
      20: 4000,
      30: 8000,
      50: 15000,
    },
    Difficulty.hard: {
      10: 5000,
      20: 9000,
      30: 12000,
      50: 30000,
    },
    Difficulty.expert: {
      10: 15000,
      20: 25000,
      30: 40000,
      50: 100000,
    },
    Difficulty.adaptive: {
      10: 8000,
      20: 18000,
      30: 35000,
      50: 75000,
    },
  };

  static double getProCoinPayoutPercentage(double accuracy) {
    if (accuracy >= 1.0) return 1.25;
    if (accuracy >= 0.95) return 1.00;
    if (accuracy >= 0.90) return 0.85;
    if (accuracy >= 0.80) return 0.70;
    if (accuracy >= 0.70) return 0.50;
    if (accuracy >= 0.60) return 0.35;
    if (accuracy >= 0.40) return 0.20;
    return 0.0;
  }

  static double getProXpMultiplier(double accuracy) {
    if (accuracy >= 1.0) return 1.50;
    if (accuracy >= 0.95) return 1.30;
    if (accuracy >= 0.90) return 1.15;
    if (accuracy >= 0.80) return 1.00;
    if (accuracy >= 0.70) return 0.80;
    if (accuracy >= 0.60) return 0.65;
    if (accuracy >= 0.40) return 0.50;
    return 0.25;
  }

  static const Map<Difficulty, int> proBaseXpPerCorrect = {
    Difficulty.easy: 15,
    Difficulty.medium: 20,
    Difficulty.hard: 25,
    Difficulty.expert: 35,
    Difficulty.adaptive: 30,
  };

  static const List<int> versusWagers = [500, 1000, 5000];
  static const double versusPlatformFeePercentage = 0.10;

  static int getVersusBaseXpPerCorrect(VersusOutcome outcome) {
    switch (outcome) {
      case VersusOutcome.dominantWin: return 35;
      case VersusOutcome.win: return 30;
      case VersusOutcome.draw: return 25;
      case VersusOutcome.loss: return 20;
    }
  }

  static double getVersusAccuracyBonusMultiplier(double accuracy) {
    if (accuracy >= 1.0) return 0.35;
    if (accuracy >= 0.90) return 0.20;
    if (accuracy >= 0.80) return 0.10;
    return 0.0;
  }

  static const int tournamentEntryCostTokens = 5;

  // --- PRACTICE MODE ---
  static const int practiceXpPerCorrect = 10;
  static const int practiceCoinsPerCorrect = 2;
}

enum VersusOutcome {
  win,
  dominantWin,
  draw,
  loss,
}
