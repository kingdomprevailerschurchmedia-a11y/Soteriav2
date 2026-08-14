import 'package:flutter/foundation.dart';
import 'player_profile.dart';
import 'player_progression.dart';
import 'competitive_season.dart';
import 'season_result.dart';
import 'reward_grant.dart';
import 'milestone.dart';
import 'competitive_personal_record.dart';
import 'competitive_career_summary.dart';

@immutable
class CompetitiveProfile {
  final PlayerProfile identity;
  final PlayerProgression progression;
  final CompetitiveSeason? currentSeason;
  final int globalPosition;
  final CompetitiveHistory history;
  final List<RewardGrant> recentRewards;
  final int totalRewards;
  final List<PlayerMilestone> completedMilestones;
  final int totalMilestones;
  final List<CompetitivePersonalRecord> personalRecords;
  final CompetitiveCareerSummary? careerSummary;

  const CompetitiveProfile({
    required this.identity,
    required this.progression,
    this.currentSeason,
    required this.globalPosition,
    required this.history,
    required this.recentRewards,
    required this.totalRewards,
    required this.completedMilestones,
    required this.totalMilestones,
    required this.personalRecords,
    this.careerSummary,
  });

  CompetitiveProfile copyWith({
    PlayerProfile? identity,
    PlayerProgression? progression,
    CompetitiveSeason? currentSeason,
    int? globalPosition,
    CompetitiveHistory? history,
    List<RewardGrant>? recentRewards,
    int? totalRewards,
    List<PlayerMilestone>? completedMilestones,
    int? totalMilestones,
    List<CompetitivePersonalRecord>? personalRecords,
    CompetitiveCareerSummary? careerSummary,
  }) {
    return CompetitiveProfile(
      identity: identity ?? this.identity,
      progression: progression ?? this.progression,
      currentSeason: currentSeason ?? this.currentSeason,
      globalPosition: globalPosition ?? this.globalPosition,
      history: history ?? this.history,
      recentRewards: recentRewards ?? this.recentRewards,
      totalRewards: totalRewards ?? this.totalRewards,
      completedMilestones: completedMilestones ?? this.completedMilestones,
      totalMilestones: totalMilestones ?? this.totalMilestones,
      personalRecords: personalRecords ?? this.personalRecords,
      careerSummary: careerSummary ?? this.careerSummary,
    );
  }
}
