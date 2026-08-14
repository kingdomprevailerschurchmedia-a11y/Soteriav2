import '../models/practice_session_config.dart';
import '../../question_content/domain/entities/difficulty.dart';

class EstimatedRewards {
  final int xp;
  final int coins;
  final Duration estimatedDuration;

  const EstimatedRewards({
    required this.xp,
    required this.coins,
    required this.estimatedDuration,
  });
}

class RewardEstimator {
  final Map<String, dynamic> _multipliers;

  RewardEstimator({Map<String, dynamic>? multipliers})
    : _multipliers =
          multipliers ??
          {
            'xp_base': 10,
            'coin_base': 2,
            'mult_easy': 1.0,
            'mult_medium': 1.25,
            'mult_hard': 1.5,
            'mult_expert': 2.0,
            'mult_adaptive': 1.3,
          };

  EstimatedRewards estimate(PracticeSessionConfig config) {
    final int baseXP = _multipliers['xp_base'] ?? 10;
    final int baseCoins = _multipliers['coin_base'] ?? 2;

    final double diffMult = _getDifficultyMultiplier(config.difficulty);

    final int totalXP = (baseXP * config.questionCount * diffMult).toInt();
    final int totalCoins = (baseCoins * config.questionCount * (diffMult * 0.8))
        .toInt();

    // Assume 30 seconds per question on average
    final duration = Duration(seconds: config.questionCount * 30);

    return EstimatedRewards(
      xp: totalXP,
      coins: totalCoins,
      estimatedDuration: duration,
    );
  }

  double _getDifficultyMultiplier(Difficulty diff) {
    switch (diff) {
      case Difficulty.easy:
        return _multipliers['mult_easy'] ?? 1.0;
      case Difficulty.medium:
        return _multipliers['mult_medium'] ?? 1.25;
      case Difficulty.hard:
        return _multipliers['mult_hard'] ?? 1.5;
      case Difficulty.expert:
        return _multipliers['mult_expert'] ?? 2.0;
      case Difficulty.adaptive:
        return _multipliers['mult_adaptive'] ?? 1.3;
    }
  }
}
