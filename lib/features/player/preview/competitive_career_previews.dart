import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_profile.dart';
import '../domain/models/season_result.dart';
import '../domain/models/competitive_career_summary.dart';
import '../domain/models/competitive_personal_record.dart';
import '../domain/models/player_profile.dart';
import '../domain/models/player_progression.dart';
import '../presentation/providers/competitive_profile_provider.dart';
import '../../analytics/presentation/providers/analytics_providers.dart';
import '../../analytics/domain/models/performance_analytics.dart';
import '../../analytics/domain/models/analytics_enums.dart';
import '../../analytics/domain/models/performance_trend.dart';
import '../../analytics/domain/models/consistency_metrics.dart';
import '../../analytics/domain/models/category_performance.dart';
import '../presentation/screens/competitive_career_screen.dart';

class CompetitiveCareerPreviewWrapper extends StatelessWidget {
  final CompetitiveProfile profile;
  final PersonalPerformanceAnalytics analytics;

  const CompetitiveCareerPreviewWrapper({
    super.key,
    required this.profile,
    required this.analytics,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        competitiveProfileProvider.overrideWithValue(AsyncValue.data(profile)),
        personalPerformanceAnalyticsProvider.overrideWith((ref) => analytics),
      ],
      child: const CompetitiveCareerScreen(),
    );
  }
}

class CompetitiveCareerPreviews {
  static CompetitiveProfile mockProfile() {
    final now = DateTime.now();
    final results = [
      SeasonResult(
        seasonId: 's5',
        userId: 'u1',
        seasonName: 'Ascension',
        seasonNumber: 5,
        finalPosition: 127,
        finalRankPoints: 2840,
        finalTier: 'Diamond',
        finalDivision: 2,
        previousTier: 'Platinum',
        previousDivision: 1,
        rankChange: 450,
        completedAt: now.subtract(const Duration(days: 2)),
        createdAt: now.subtract(const Duration(days: 32)),
        updatedAt: now.subtract(const Duration(days: 2)),
      ),
      SeasonResult(
        seasonId: 's4',
        userId: 'u1',
        seasonName: 'Origins',
        seasonNumber: 4,
        finalPosition: 542,
        finalRankPoints: 2100,
        finalTier: 'Platinum',
        finalDivision: 3,
        previousTier: 'Gold',
        previousDivision: 1,
        rankChange: 600,
        completedAt: now.subtract(const Duration(days: 92)),
        createdAt: now.subtract(const Duration(days: 122)),
        updatedAt: now.subtract(const Duration(days: 92)),
      ),
    ];

    final records = [
      CompetitivePersonalRecord(
        id: 'r1',
        userId: 'u1',
        type: CompetitiveRecordType.highestScore,
        value: 2950,
        displayValue: '2,950',
        achievedAt: now.subtract(const Duration(days: 5)),
        isCareerRecord: true,
      ),
      CompetitivePersonalRecord(
        id: 'r2',
        userId: 'u1',
        type: CompetitiveRecordType.longestWinStreak,
        value: 12,
        displayValue: '12',
        achievedAt: now.subtract(const Duration(days: 10)),
        isCareerRecord: true,
      ),
    ];

    final identity = PlayerProfile(
      uid: 'u1',
      displayName: 'ElitePlayer',
      email: 'elite@soteria.app',
      gamesPlayed: 150,
      gamesWon: 112,
      xp: 45000,
      accuracy: 0.84,
      highestStreak: 12,
      createdAt: now.subtract(const Duration(days: 365)),
      lastLogin: now,
      updatedAt: now,
    );

    final progression = PlayerProgression(
      userId: 'u1',
      currentLevel: 42,
      currentXp: 5000,
      lifetimeXp: 45000,
      xpRequiredForCurrentLevel: 40000,
      xpRequiredForNextLevel: 50000,
      xpProgress: 0.5,
      currentRank: 'Diamond II',
      currentRankTier: 'Diamond',
      rankPoints: 2840,
      rankProgress: 0.75,
      seasonId: 's5',
      seasonXp: 12000,
      seasonRankPoints: 2840,
      lastUpdated: now,
    );

    final summary = CompetitiveCareerSummary(
      userId: 'u1',
      totalSeasons: 5,
      bestRank: 'Diamond',
      bestPosition: 127,
      totalMatches: 150,
      totalWins: 112,
      totalLosses: 38,
      winRate: 0.746,
      bestStreak: 12,
      highestScore: 2950,
      totalXp: 125000,
      bestSeason: results[0],
      careerRecords: records,
    );

    return CompetitiveProfile(
      identity: identity,
      progression: progression,
      globalPosition: 127,
      history: CompetitiveHistory(userId: 'u1', results: results, bestResult: results[0]),
      recentRewards: [],
      totalRewards: 12,
      completedMilestones: [],
      totalMilestones: 50,
      personalRecords: records,
      careerSummary: summary,
    );
  }

  static PersonalPerformanceAnalytics mockAnalytics() {
    return PersonalPerformanceAnalytics(
      playerId: 'u1',
      period: TimePeriod.allTime,
      totalQuizzes: 150,
      totalQuestions: 1500,
      totalCorrect: 1260,
      totalIncorrect: 240,
      totalSkipped: 0,
      totalTimedOut: 0,
      averageAccuracy: 0.84,
      averageScore: 2100,
      bestScore: 2950,
      bestAccuracy: 1.0,
      bestStreak: 12,
      averageResponseTime: const Duration(seconds: 8),
      fastestResponseTime: const Duration(seconds: 2),
      slowestResponseTime: const Duration(seconds: 25),
      totalXp: 125000,
      categoryPerformance: [
        CategoryPerformance(
          category: 'Technology',
          totalQuizzes: 45,
          totalQuestions: 450,
          correctAnswers: 410,
          accuracy: 0.91,
          averageScore: 2400,
          bestScore: 2950,
          averageResponseTime: const Duration(seconds: 6),
          totalXp: 45000,
        ),
        CategoryPerformance(
          category: 'Science',
          totalQuizzes: 30,
          totalQuestions: 300,
          correctAnswers: 252,
          accuracy: 0.84,
          averageScore: 2100,
          bestScore: 2600,
          averageResponseTime: const Duration(seconds: 9),
          totalXp: 28000,
        ),
      ],
      difficultyPerformance: [],
      accuracyTrend: const PerformanceTrend(
        label: 'Accuracy',
        points: [],
        averageValue: 0.84,
        minValue: 0.7,
        maxValue: 0.95,
        changeValue: 0.05,
        changePercentage: 5.0,
      ),
      scoreTrend: const PerformanceTrend(
        label: 'Score',
        points: [],
        averageValue: 2100,
        minValue: 1500,
        maxValue: 2950,
        changeValue: 0,
        changePercentage: 0,
      ),
      speedTrend: const PerformanceTrend(
        label: 'Speed',
        points: [],
        averageValue: 8,
        minValue: 2,
        maxValue: 25,
        changeValue: -1,
        changePercentage: -10,
      ),
      xpTrend: const PerformanceTrend(
        label: 'XP',
        points: [],
        averageValue: 1000,
        minValue: 500,
        maxValue: 2500,
        changeValue: 0,
        changePercentage: 0,
      ),
      consistency: const ConsistencyMetrics(
        accuracyVariance: 0.05,
        scoreVariance: 100,
        consistencyScore: 0.85,
        consistencyLevel: 'High',
        streakStability: 4,
      ),
      insights: [],
      calculatedAt: DateTime.now(),
    );
  }

  static Widget fullCareer() {
    return CompetitiveCareerPreviewWrapper(
      profile: mockProfile(),
      analytics: mockAnalytics(),
    );
  }

  static Widget partialData() {
    final profile = mockProfile().copyWith(
      history: CompetitiveHistory(userId: 'u1', results: []),
      careerSummary: mockProfile().careerSummary?.copyWith(totalSeasons: 0, bestRank: 'N/A', bestPosition: -1),
    );
    return CompetitiveCareerPreviewWrapper(
      profile: profile,
      analytics: mockAnalytics(),
    );
  }
}
