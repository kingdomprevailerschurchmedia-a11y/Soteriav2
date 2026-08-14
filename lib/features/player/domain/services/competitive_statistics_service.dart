import 'dart:math';
import '../models/competitive_statistics.dart';
import '../models/player_profile.dart';
import '../models/player_progression.dart';
import '../models/season_result.dart';
import '../models/competitive_season.dart';
import '../models/competitive_match.dart';
import '../models/competitive_result.dart';
import '../models/competitive_career_summary.dart';
import '../models/competitive_personal_record.dart';

class CompetitiveStatisticsService {
  CompetitiveCareerSummary calculateCareerSummary({
    required String userId,
    required PlayerProfile profile,
    required CompetitiveHistory history,
    required List<CompetitivePersonalRecord> records,
    List<String> recentForm = const [],
  }) {
    final highestScoreRecord = records.firstWhere(
      (r) => r.type == CompetitiveRecordType.highestScore && r.isCareerRecord,
      orElse: () => CompetitivePersonalRecord(
        id: '',
        userId: userId,
        type: CompetitiveRecordType.highestScore,
        value: 0,
        displayValue: '0',
        achievedAt: DateTime.now(),
      ),
    );

    return CompetitiveCareerSummary(
      userId: userId,
      totalSeasons: history.results.length,
      bestRank: history.bestResult?.finalTier ?? 'N/A',
      bestPosition: history.bestResult?.finalPosition ?? -1,
      totalMatches: profile.gamesPlayed,
      totalWins: profile.gamesWon,
      totalLosses: max(0, profile.gamesPlayed - profile.gamesWon),
      winRate: profile.gamesPlayed > 0 ? profile.gamesWon / profile.gamesPlayed : 0,
      bestStreak: profile.highestStreak,
      highestScore: highestScoreRecord.value.toInt(),
      totalXp: profile.xp,
      bestSeason: history.bestResult,
      careerRecords: records.where((r) => r.isCareerRecord).toList(),
      recentForm: recentForm,
    );
  }

  CompetitiveStatistics calculate({
    required String userId,
    required PlayerProfile profile,
    required CompetitiveHistory history,
    required PlayerProgression progression,
    required CompetitiveSeason? currentSeason,
    required int globalPosition,
    List<String> recentForm = const [],
  }) {
    final career = CareerStatistics(
      gamesPlayed: profile.gamesPlayed,
      gamesWon: profile.gamesWon,
      gamesLost: max(0, profile.gamesPlayed - profile.gamesWon),
      winRate: profile.gamesPlayed > 0
          ? profile.gamesWon / profile.gamesPlayed
          : 0.0,
      totalQuestionsAnswered: profile.totalQuestionsAnswered,
      correctAnswers: profile.correctAnswers,
      accuracy: profile.accuracy,
      currentStreak: profile.currentStreak,
      highestStreak: profile.highestStreak,
      bestRank: history.bestResult?.finalTier ?? progression.currentRank,
      peakPosition: history.bestResult?.finalPosition ?? -1,
      seasonsPlayed: history.results.length + (currentSeason != null ? 1 : 0),
    );

    SeasonStatistics? currentSeasonStats;
    if (currentSeason != null) {
      // Current season metrics mostly derived from progression
      currentSeasonStats = SeasonStatistics(
        seasonId: currentSeason.seasonId,
        seasonName: currentSeason.name,
        gamesPlayed:
            0, // Default to 0 if not explicitly tracked in progression yet
        gamesWon: 0,
        gamesLost: 0,
        winRate: 0.0,
        totalPoints: progression.rankPoints,
        averagePoints: 0.0,
        bestScore: 0,
        accuracy: 0.0,
        currentPosition: globalPosition,
      );
    }

    final trends = _calculateTrends(history);
    final insights = _generateInsights(career, currentSeasonStats, history);

    return CompetitiveStatistics(
      userId: userId,
      career: career,
      currentSeason: currentSeasonStats,
      trends: trends,
      insights: insights,
      recentForm: recentForm,
    );
  }

  List<PerformanceTrend> _calculateTrends(CompetitiveHistory history) {
    if (history.results.length < 2) return [];

    final trends = <PerformanceTrend>[];

    // Win Rate Trend (comparing latest two seasons)
    final latest = history.results[0];
    final previous = history.results[1];

    final latestWR = _getStat(latest, 'winRate');
    final previousWR = _getStat(previous, 'winRate');

    if (latestWR != null && previousWR != null) {
      trends.add(
        PerformanceTrend(
          state: _determineTrendState(latestWR, previousWR),
          changePercentage: latestWR - previousWR,
          metricName: 'Win Rate',
          dataPoints: history.results
              .take(5)
              .map((e) => _getStat(e, 'winRate') ?? 0.0)
              .toList()
              .reversed
              .toList(),
        ),
      );
    }

    // Accuracy Trend
    final latestAcc = _getStat(latest, 'accuracy');
    final previousAcc = _getStat(previous, 'accuracy');

    if (latestAcc != null && previousAcc != null) {
      trends.add(
        PerformanceTrend(
          state: _determineTrendState(latestAcc, previousAcc, threshold: 0.02),
          changePercentage: latestAcc - previousAcc,
          metricName: 'Accuracy',
          dataPoints: history.results
              .take(5)
              .map((e) => _getStat(e, 'accuracy') ?? 0.0)
              .toList()
              .reversed
              .toList(),
        ),
      );
    }

    return trends;
  }

  List<PerformanceInsight> _generateInsights(
    CareerStatistics career,
    SeasonStatistics? currentSeason,
    CompetitiveHistory history,
  ) {
    final insights = <PerformanceInsight>[];

    // Win Rate Insight
    if (career.winRate >= 0.7) {
      insights.add(
        const PerformanceInsight(
          title: 'Elite Win Rate',
          description: 'Your career win rate is among the top 5% of players.',
          isPositive: true,
        ),
      );
    } else if (career.winRate >= 0.5) {
      insights.add(
        const PerformanceInsight(
          title: 'Strong Performer',
          description: 'You maintain a positive win rate across your career.',
          isPositive: true,
        ),
      );
    }

    // Streak Insight
    if (career.currentStreak >= 3) {
      insights.add(
        PerformanceInsight(
          title: 'Winning Streak',
          description:
              'You\'ve won your last ${career.currentStreak} games. Keep the momentum!',
          isPositive: true,
        ),
      );
    }

    // Consistency Insight
    if (career.accuracy >= 0.8) {
      insights.add(
        const PerformanceInsight(
          title: 'Sharpshooter',
          description:
              'Your accuracy is exceptional. You rarely miss a question.',
          isPositive: true,
        ),
      );
    }

    // Milestone Insight
    if (career.seasonsPlayed >= 10) {
      insights.add(
        const PerformanceInsight(
          title: 'Season Veteran',
          description: 'You have competed in over 10 seasons. True dedication.',
          isPositive: true,
        ),
      );
    }

    return insights;
  }

  List<PerformanceInsight> generateMatchInsights(
    List<CompetitiveMatch> matches,
  ) {
    if (matches.length < 5) return [];

    final insights = <PerformanceInsight>[];

    // Win Rate Trend (Last 10 matches)
    final recentMatches = matches.take(10).toList();
    final winCount = recentMatches
        .where((m) => m.result.outcome == CompetitiveOutcome.win)
        .length;
    final winRate = winCount / recentMatches.length;

    if (winRate >= 0.8) {
      insights.add(
        const PerformanceInsight(
          title: 'On a Roll',
          description:
              'You have won 80% or more of your recent matches. Peak performance!',
          isPositive: true,
        ),
      );
    } else if (winRate >= 0.6) {
      insights.add(
        const PerformanceInsight(
          title: 'Positive Momentum',
          description: 'You are winning the majority of your recent matches.',
          isPositive: true,
        ),
      );
    }

    // Accuracy Trend
    final matchesWithQuiz = recentMatches
        .where((m) => m.quizResult != null)
        .toList();
    if (matchesWithQuiz.length >= 3) {
      final avgAccuracy =
          matchesWithQuiz
              .map((m) => m.quizResult!.accuracy)
              .reduce((a, b) => a + b) /
          matchesWithQuiz.length;

      if (avgAccuracy >= 0.85) {
        insights.add(
          const PerformanceInsight(
            title: 'Laser Precision',
            description:
                'Your average accuracy in recent matches is exceptional.',
            isPositive: true,
          ),
        );
      }
    }

    // Strongest Mode
    final modes = recentMatches.map((m) => m.result.mode).toSet();
    String? strongestMode;
    double highestModeWinRate = 0;

    for (final mode in modes) {
      final modeMatches = recentMatches
          .where((m) => m.result.mode == mode)
          .toList();
      if (modeMatches.length < 2) continue;

      final modeWinCount = modeMatches
          .where((m) => m.result.outcome == CompetitiveOutcome.win)
          .length;
      final modeWinRate = modeWinCount / modeMatches.length;

      if (modeWinRate > highestModeWinRate) {
        highestModeWinRate = modeWinRate;
        strongestMode = mode;
      }
    }

    if (strongestMode != null && highestModeWinRate >= 0.6) {
      insights.add(
        PerformanceInsight(
          title: 'Mode Mastery',
          description:
              'Your strongest recent mode is ${strongestMode.toUpperCase()}.',
          isPositive: true,
          recommendation: 'Play more $strongestMode to climb faster.',
        ),
      );
    }

    // Best Score Insight
    final bestScoreMatch = matches.reduce(
      (a, b) => a.result.score > b.result.score ? a : b,
    );
    if (bestScoreMatch.result.score > 0) {
      insights.add(
        PerformanceInsight(
          title: 'Season Peak',
          description:
              'Your best score in this period was ${bestScoreMatch.result.score}.',
          isPositive: true,
        ),
      );
    }

    return insights;
  }

  TrendState _determineTrendState(
    double current,
    double previous, {
    double threshold = 0.05,
  }) {
    if ((current - previous).abs() < threshold) return TrendState.stable;
    return current > previous ? TrendState.improving : TrendState.declining;
  }

  double? _getStat(SeasonResult result, String key) {
    final val = result.statistics?[key];
    if (val is num) return val.toDouble();
    return null;
  }
}
