import 'dart:math';
import '../models/player_progression.dart';
import '../models/competitive_result.dart';
import '../models/rank_change.dart';
import '../models/rank_tier.dart';
import '../models/rank_progress.dart';
import '../config/ranking_config.dart';
import '../config/progression_config.dart';

class CompetitiveRankingEngine {
  /// Calculates the new rank and points based on a competitive result.
  RankChange calculateRankChange({
    required PlayerProgression currentProgression,
    required CompetitiveResult result,
  }) {
    final previousPoints = currentProgression.rankPoints;
    final changeAmount = _calculatePointChange(result);

    int newPoints = (previousPoints + changeAmount).clamp(
      RankingConfig.minRankPoints,
      RankingConfig.maxRankPoints,
    );

    final previousRankInfo = _parseRank(currentProgression.currentRank);
    final newRankInfo = _resolveRankFromPoints(newPoints);

    final changeType = _determineChangeType(
      previousPoints,
      newPoints,
      previousRankInfo,
      newRankInfo,
    );

    final isTierChange =
        newRankInfo.tier.displayOrder != previousRankInfo.tier.displayOrder;
    final isDivisionChange =
        !isTierChange && newRankInfo.division != previousRankInfo.division;

    return RankChange(
      changeId: '${result.resultId}_change',
      userId: currentProgression.userId,
      seasonId: currentProgression.seasonId,
      previousRank: currentProgression.currentRank,
      newRank: _formatRank(newRankInfo),
      previousRankPoints: previousPoints,
      newRankPoints: newPoints,
      changeAmount: changeAmount,
      type: changeType,
      referenceResultId: result.resultId,
      createdAt: DateTime.now(),
      isTierChange: isTierChange,
      isDivisionChange: isDivisionChange,
    );
  }

  /// Calculates comprehensive progress data for a given point total.
  RankProgress calculateRankProgress(int points) {
    final info = _resolveRankFromPoints(points);
    final isUnranked = info.tier.id == 'unranked';
    final isElite = info.tier.id == 'elite';

    if (isUnranked) {
      return RankProgress(
        currentRank: 'Unranked',
        currentRP: points,
        minimumRP: 0,
        maximumRP: 99,
        progressPercentage: (points / 99).clamp(0.0, 1.0),
        nextRank: 'Bronze III',
        rpToNextRank: 100 - points,
        isUnranked: true,
        tier: info.tier,
        division: 0,
      );
    }

    if (isElite) {
      return RankProgress(
        currentRank: 'Elite',
        currentRP: points,
        minimumRP: 7500,
        maximumRP: 999999,
        progressPercentage: 1.0,
        isMaxRank: true,
        tier: info.tier,
        division: 0,
      );
    }

    // Standard Rank Progress
    final tierRange = info.tier.maxPoints - info.tier.minPoints + 1;
    final pointsPerDivision = tierRange / RankingConfig.divisionsPerTier;
    
    // Division I is highest (least points to next tier)
    // Gold III: [0, 332] relative to tier start
    // Gold II: [333, 665]
    // Gold I: [666, 999]
    final relativePoints = points - info.tier.minPoints;
    final divisionIndex = (relativePoints / pointsPerDivision).floor(); // 0, 1, 2
    
    final divMinRP = info.tier.minPoints + (divisionIndex * pointsPerDivision).floor();
    final divMaxRP = info.tier.minPoints + ((divisionIndex + 1) * pointsPerDivision).floor() - 1;
    
    final divProgress = (points - divMinRP) / (divMaxRP - divMinRP + 1);

    String? nextRankName;
    int? rpToNext;

    if (info.division > 1) {
      // Move up to next division in same tier (e.g. III -> II)
      final nextDiv = info.division - 1;
      nextRankName = '${info.tier.name} ${_dataToRoman(nextDiv)}';
      rpToNext = (divMaxRP + 1) - points;
    } else {
      // Move up to next tier
      final nextTierIndex = ProgressionConfig.rankTiers.indexOf(info.tier) + 1;
      if (nextTierIndex < ProgressionConfig.rankTiers.length) {
        final nextTier = ProgressionConfig.rankTiers[nextTierIndex];
        nextRankName = nextTier.id == 'elite' ? 'Elite' : '${nextTier.name} III';
        rpToNext = nextTier.minPoints - points;
      }
    }

    return RankProgress(
      currentRank: _formatRank(info),
      currentRP: points,
      minimumRP: divMinRP,
      maximumRP: divMaxRP,
      progressPercentage: divProgress.clamp(0.0, 1.0),
      nextRank: nextRankName,
      rpToNextRank: rpToNext,
      tier: info.tier,
      division: info.division,
    );
  }

  /// Authoritatively determines if [rankA] is higher than [rankB].
  bool isHigher(String rankA, String rankB) {
    final infoA = _parseRank(rankA);
    final infoB = _parseRank(rankB);

    if (infoA.tier.displayOrder > infoB.tier.displayOrder) return true;
    if (infoA.tier.displayOrder < infoB.tier.displayOrder) return false;

    // Same tier, check division (I > II > III)
    if (infoA.division == 0 || infoB.division == 0) return false;
    return infoA.division < infoB.division;
  }

  int _calculatePointChange(CompetitiveResult result) {
    switch (result.outcome) {
      case CompetitiveOutcome.win:
        return RankingConfig.winPoints;
      case CompetitiveOutcome.loss:
        return RankingConfig.lossPoints;
      case CompetitiveOutcome.draw:
        return RankingConfig.drawPoints;
      case CompetitiveOutcome.placement:
        return 0; // Handled separately if needed
    }
  }

  RankInfo _resolveRankFromPoints(int points) {
    // 1. Find the Tier
    final tier = ProgressionConfig.rankTiers.firstWhere(
      (t) => points >= t.minPoints && points <= t.maxPoints,
      orElse: () => ProgressionConfig.rankTiers.first,
    );

    if (tier.id == 'unranked' || tier.id == 'elite') {
      return RankInfo(tier: tier, division: 0);
    }

    // 2. Calculate Division
    // Range: 1000 - 1999 (Gold). 1000 RP.
    // 3 divisions. 1000 / 3 = 333 points per division.
    final tierRange = tier.maxPoints - tier.minPoints + 1;
    final pointsInTier = points - tier.minPoints;
    final pointsPerDivision = tierRange / RankingConfig.divisionsPerTier;

    // Gold III (3), Gold II (2), Gold I (1) - Higher points is lower number division
    int division =
        RankingConfig.divisionsPerTier -
        pointsInLevel(pointsInTier, pointsPerDivision);
    division = division.clamp(1, RankingConfig.divisionsPerTier);

    return RankInfo(tier: tier, division: division);
  }

  int pointsInLevel(int pointsInTier, double pointsPerDivision) {
    return (pointsInTier / pointsPerDivision).floor();
  }

  RankChangeType _determineChangeType(
    int prevPoints,
    int newPoints,
    RankInfo prevInfo,
    RankInfo newInfo,
  ) {
    // Tier Promotion/Demotion
    if (newInfo.tier.displayOrder > prevInfo.tier.displayOrder) {
      return RankChangeType.promotion;
    }
    if (newInfo.tier.displayOrder < prevInfo.tier.displayOrder) {
      return RankChangeType.demotion;
    }

    // Division Promotion/Demotion (within same tier)
    if (newInfo.tier.id == prevInfo.tier.id && newInfo.division != 0) {
      // Division I is 1, Division III is 3. Lower number is better.
      if (newInfo.division < prevInfo.division) {
        return RankChangeType.divisionPromotion;
      }
      if (newInfo.division > prevInfo.division) {
        return RankChangeType.divisionDemotion;
      }
    }

    if (newPoints > prevPoints) return RankChangeType.increase;
    if (newPoints < prevPoints) return RankChangeType.decrease;
    return RankChangeType.increase;
  }

  RankInfo _parseRank(String rankString) {
    if (rankString == 'Unranked') {
      return RankInfo(tier: ProgressionConfig.rankTiers.first, division: 0);
    }

    final parts = rankString.split(' ');
    final tierName = parts[0];
    final tier = ProgressionConfig.rankTiers.firstWhere(
      (t) => t.name == tierName,
      orElse: () => ProgressionConfig.rankTiers.first,
    );

    int division = 0;
    if (parts.length > 1) {
      division = _romanToData(parts[1]);
    }

    return RankInfo(tier: tier, division: division);
  }

  String _formatRank(RankInfo info) {
    if (info.tier.id == 'unranked' || info.tier.id == 'elite') {
      return info.tier.name;
    }
    return '${info.tier.name} ${_dataToRoman(info.division)}';
  }

  int _romanToData(String roman) {
    switch (roman) {
      case 'I':
        return 1;
      case 'II':
        return 2;
      case 'III':
        return 3;
      default:
        return 0;
    }
  }

  String _dataToRoman(int data) {
    switch (data) {
      case 1:
        return 'I';
      case 2:
        return 'II';
      case 3:
        return 'III';
      default:
        return '';
    }
  }
}

class RankInfo {
  final RankTier tier;
  final int division;

  RankInfo({required this.tier, required this.division});
}
