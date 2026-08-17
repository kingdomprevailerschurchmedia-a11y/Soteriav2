import 'dart:math';
import '../models/rank_tier.dart';

class ProgressionConfig {
  static const int maxLevel = 100;

  // Authoritative Level Curve Constants
  static const int baseLevelXP = 100;
  static const double levelExponent = 1.5;
  static const int linearFactor = 50;

  static final List<RankTier> rankTiers = [
    const RankTier(
      id: 'unranked',
      name: 'Unranked',
      minPoints: 0,
      maxPoints: 99,
      displayOrder: 0,
      promotionThreshold: 100,
      demotionThreshold: 0,
      visualToken: 'assets/ranks/unranked_badge.png',
    ),
    const RankTier(
      id: 'bronze',
      name: 'Bronze',
      minPoints: 100,
      maxPoints: 499,
      displayOrder: 1,
      promotionThreshold: 500,
      demotionThreshold: 90,
      visualToken: 'assets/ranks/bronze_badge.png',
    ),
    const RankTier(
      id: 'silver',
      name: 'Silver',
      minPoints: 500,
      maxPoints: 999,
      displayOrder: 2,
      promotionThreshold: 1000,
      demotionThreshold: 450,
      visualToken: 'assets/ranks/silver_badge.png',
    ),
    const RankTier(
      id: 'gold',
      name: 'Gold',
      minPoints: 1000,
      maxPoints: 1999,
      displayOrder: 3,
      promotionThreshold: 2000,
      demotionThreshold: 950,
      visualToken: 'assets/ranks/gold_badge.png',
    ),
    const RankTier(
      id: 'platinum',
      name: 'Platinum',
      minPoints: 2000,
      maxPoints: 3499,
      displayOrder: 4,
      promotionThreshold: 3500,
      demotionThreshold: 1900,
      visualToken: 'assets/ranks/platinium_badge.png',
    ),
    const RankTier(
      id: 'diamond',
      name: 'Diamond',
      minPoints: 3500,
      maxPoints: 4999,
      displayOrder: 5,
      promotionThreshold: 5000,
      demotionThreshold: 3400,
      visualToken: 'assets/ranks/diamond_badge.png',
    ),
    const RankTier(
      id: 'master',
      name: 'Master',
      minPoints: 5000,
      maxPoints: 7499,
      displayOrder: 6,
      promotionThreshold: 7500,
      demotionThreshold: 4800,
      visualToken: 'assets/ranks/master_badge.png',
    ),
    const RankTier(
      id: 'elite',
      name: 'Elite',
      minPoints: 7500,
      maxPoints: 999999,
      displayOrder: 7,
      promotionThreshold: 999999,
      demotionThreshold: 7200,
      visualToken: 'assets/ranks/elite_badge.png',
    ),
  ];

  static int xpRequiredForLevel(int level) {
    if (level <= 1) return 0;
    if (level > maxLevel) return xpRequiredForLevel(maxLevel);

    final n = level - 1;
    final exponentialPart = baseLevelXP * pow(n, levelExponent);
    final linearPart = linearFactor * n;

    return (exponentialPart + linearPart).toInt();
  }

  /// Calculates the relative XP capacity of a specific level (XP needed to cross it).
  static int xpCapacityForLevel(int level) {
    if (level < 1) return baseLevelXP;
    return xpRequiredForLevel(level + 1) - xpRequiredForLevel(level);
  }
}
