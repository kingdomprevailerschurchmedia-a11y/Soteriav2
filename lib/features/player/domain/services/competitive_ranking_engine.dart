import 'dart:math';
import '../models/player_progression.dart';
import '../models/competitive_result.dart';
import '../models/rank_change.dart';
import '../models/rank_tier.dart';
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
    );
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
    if (newInfo.tier.displayOrder > prevInfo.tier.displayOrder) {
      return RankChangeType.promotion;
    }
    if (newInfo.tier.displayOrder < prevInfo.tier.displayOrder) {
      return RankChangeType.demotion;
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
