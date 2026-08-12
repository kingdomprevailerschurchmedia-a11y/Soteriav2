import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_profile.dart';
import '../domain/models/player_profile.dart';
import '../domain/models/player_progression.dart';
import '../domain/models/competitive_season.dart';
import '../domain/models/season_result.dart';
import '../domain/models/reward_grant.dart';
import '../domain/models/milestone.dart';
import '../domain/models/season_reward_definition.dart';
import '../presentation/providers/competitive_profile_provider.dart';
import '../presentation/screens/competitive_profile_screen.dart';
import 'competitive_history_previews.dart';

class CompetitiveProfilePreviewWrapper extends StatelessWidget {
  final CompetitiveProfile profile;
  final bool isLoading;
  final Object? error;

  const CompetitiveProfilePreviewWrapper({
    super.key,
    required this.profile,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        competitiveProfileProvider.overrideWithValue(
          isLoading
              ? const AsyncValue.loading()
              : error != null
              ? AsyncValue.error(error!, StackTrace.current)
              : AsyncValue.data(profile),
        ),
      ],
      child: const CompetitiveProfileScreen(),
    );
  }
}

class CompetitiveProfilePreviews {
  static PlayerProfile mockProfile({String displayName = 'CompetitivePro'}) {
    return PlayerProfile(
      uid: 'u1',
      displayName: displayName,
      email: 'pro@soteria.com',
      photoUrl: 'https://i.pravatar.cc/150?u=u1',
      level: 42,
      xp: 2500,
      gamesPlayed: 1284,
      gamesWon: 873,
      accuracy: 0.68,
      totalQuestionsAnswered: 15420,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      lastLogin: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static PlayerProgression mockProgression({
    String tier = 'Diamond',
    int points = 2840,
    double progress = 0.6,
  }) {
    return PlayerProgression(
      userId: 'u1',
      currentLevel: 42,
      currentXp: 2500,
      lifetimeXp: 154200,
      xpRequiredForCurrentLevel: 0,
      xpRequiredForNextLevel: 5000,
      xpProgress: 0.5,
      currentRank: '$tier II',
      currentRankTier: tier,
      rankPoints: points,
      rankProgress: progress,
      seasonId: 's5',
      seasonXp: 12000,
      seasonRankPoints: 450,
      lastUpdated: DateTime.now(),
    );
  }

  static CompetitiveSeason mockSeason() {
    return CompetitiveSeason(
      seasonId: 's5',
      name: 'Season 5: Ascension',
      status: SeasonStatus.active,
      startAt: DateTime.now().subtract(const Duration(days: 30)),
      endAt: DateTime.now().add(const Duration(days: 60)),
      createdAt: DateTime.now().subtract(const Duration(days: 35)),
      updatedAt: DateTime.now().subtract(const Duration(days: 30)),
      isCurrent: true,
    );
  }

  static List<RewardGrant> mockRewards() {
    final now = DateTime.now();
    return [
      RewardGrant(
        grantId: 'g1',
        rewardId: 'r1',
        seasonId: 's4',
        userId: 'u1',
        type: RewardType.badge,
        amount: 1,
        status: GrantStatus.claimed,
        createdAt: now.subtract(const Duration(days: 92)),
        updatedAt: now.subtract(const Duration(days: 90)),
      ),
      RewardGrant(
        grantId: 'g2',
        rewardId: 'r2',
        seasonId: 's4',
        userId: 'u1',
        type: RewardType.tokens,
        amount: 500,
        status: GrantStatus.claimed,
        createdAt: now.subtract(const Duration(days: 92)),
        updatedAt: now.subtract(const Duration(days: 90)),
      ),
      RewardGrant(
        grantId: 'g3',
        rewardId: 'r3',
        seasonId: 's3',
        userId: 'u1',
        type: RewardType.achievement,
        amount: 1,
        status: GrantStatus.claimed,
        createdAt: now.subtract(const Duration(days: 182)),
        updatedAt: now.subtract(const Duration(days: 180)),
      ),
    ];
  }

  static CompetitiveProfile rankedPlayer() {
    final historyResults = CompetitiveHistoryPreviews.mockResults();
    return CompetitiveProfile(
      identity: mockProfile(),
      progression: mockProgression(),
      currentSeason: mockSeason(),
      globalPosition: 127,
      history: CompetitiveHistory(
        userId: 'u1',
        results: historyResults,
        bestResult: historyResults[0],
        latestResult: historyResults[0],
      ),
      recentRewards: mockRewards(),
      totalRewards: 12,
      completedMilestones: [
        const PlayerMilestone(
          userId: 'u1',
          milestoneId: 'm1',
          status: MilestoneStatus.completed,
          currentProgress: 10,
        ),
      ],
      totalMilestones: 40,
    );
  }

  static CompetitiveProfile unrankedPlayer() {
    return CompetitiveProfile(
      identity: mockProfile(displayName: 'NewChallenger'),
      progression: mockProgression(tier: 'Unranked', points: 0, progress: 0),
      currentSeason: mockSeason(),
      globalPosition: -1,
      history: const CompetitiveHistory(userId: 'u1', results: []),
      recentRewards: [],
      totalRewards: 0,
      completedMilestones: [],
      totalMilestones: 40,
    );
  }

  static Widget ranked() =>
      CompetitiveProfilePreviewWrapper(profile: rankedPlayer());
  static Widget unranked() =>
      CompetitiveProfilePreviewWrapper(profile: unrankedPlayer());

  static Widget loading() => CompetitiveProfilePreviewWrapper(
    profile: rankedPlayer(),
    isLoading: true,
  );

  static Widget error() => CompetitiveProfilePreviewWrapper(
    profile: rankedPlayer(),
    error: 'Failed to synchronize competitive data',
  );

  static Widget responsive(Size size) {
    return MediaQuery(
      data: MediaQueryData(size: size),
      child: ranked(),
    );
  }

  static Widget largeText() {
    return MediaQuery(
      data: const MediaQueryData(textScaler: TextScaler.linear(1.5)),
      child: ranked(),
    );
  }
}
