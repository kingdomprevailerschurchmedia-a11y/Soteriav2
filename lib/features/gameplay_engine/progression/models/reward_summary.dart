/// Detailed summary of rewards earned during a session.
class RewardSummary {
  final int baseXP;
  final int bonusXP;
  final int baseCoins;
  final int bonusCoins;
  final int streakBonus;
  final int perfectScoreBonus;
  final int dailyChallengeBonus;

  const RewardSummary({
    this.baseXP = 0,
    this.bonusXP = 0,
    this.baseCoins = 0,
    this.bonusCoins = 0,
    this.streakBonus = 0,
    this.perfectScoreBonus = 0,
    this.dailyChallengeBonus = 0,
  });

  int get totalXP =>
      baseXP + bonusXP + streakBonus + perfectScoreBonus + dailyChallengeBonus;
  int get totalCoins =>
      baseCoins + bonusCoins + streakBonus ~/ 2 + perfectScoreBonus ~/ 2;

  Map<String, dynamic> toJson() => {
    'baseXP': baseXP,
    'bonusXP': bonusXP,
    'baseCoins': baseCoins,
    'bonusCoins': bonusCoins,
    'streakBonus': streakBonus,
    'perfectScoreBonus': perfectScoreBonus,
    'dailyChallengeBonus': dailyChallengeBonus,
  };

  factory RewardSummary.fromJson(Map<String, dynamic> json) => RewardSummary(
    baseXP: json['baseXP'] ?? 0,
    bonusXP: json['bonusXP'] ?? 0,
    baseCoins: json['baseCoins'] ?? 0,
    bonusCoins: json['bonusCoins'] ?? 0,
    streakBonus: json['streakBonus'] ?? 0,
    perfectScoreBonus: json['perfectScoreBonus'] ?? 0,
    dailyChallengeBonus: json['dailyChallengeBonus'] ?? 0,
  );
}
