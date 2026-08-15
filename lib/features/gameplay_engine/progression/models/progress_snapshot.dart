import 'package:soteria/features/player/domain/models/player_progression.dart';

/// Immutable state of a player's progression at a specific point in time.
class ProgressSnapshot {
  final int score;
  final int totalXP;
  final int level;
  final int currentStreak;
  final int maxStreak;
  final int sessionScore;
  final int sessionStreak;
  final int sessionCorrectAnswers;
  final Map<String, int> sessionCategoryMastery;
  final int lives;
  final int dailyStreak;
  final String? lastEngagementDate; // YYYY-MM-DD
  final String? lastProcessedSessionId;
  final DateTime timestamp;

  const ProgressSnapshot({
    required this.score,
    required this.totalXP,
    required this.level,
    required this.currentStreak,
    required this.maxStreak,
    required this.sessionScore,
    required this.sessionStreak,
    required this.sessionCorrectAnswers,
    this.sessionCategoryMastery = const {},
    required this.lives,
    required this.dailyStreak,
    this.lastEngagementDate,
    this.lastProcessedSessionId,
    required this.timestamp,
  });

  factory ProgressSnapshot.initial() => ProgressSnapshot(
    score: 0,
    totalXP: 0,
    level: 1,
    currentStreak: 0,
    maxStreak: 0,
    sessionScore: 0,
    sessionStreak: 0,
    sessionCorrectAnswers: 0,
    sessionCategoryMastery: const {},
    lives: 3,
    dailyStreak: 0,
    timestamp: DateTime.now(),
  );

  /// Creates a snapshot from a [PlayerProgression] record to use as a session baseline.
  factory ProgressSnapshot.fromProgression(PlayerProgression progression) {
    return ProgressSnapshot(
      score: 0, // In-game score always starts at 0
      totalXP: progression.lifetimeXp,
      level: progression.currentLevel,
      currentStreak: 0, // In-session question streak
      maxStreak: 0,
      sessionScore: 0,
      sessionStreak: 0,
      sessionCorrectAnswers: 0,
      sessionCategoryMastery: const {},
      lives: 3, // Default lives
      dailyStreak: progression.dailyStreak,
      lastEngagementDate: progression.lastEngagementDate,
      timestamp: DateTime.now(),
    );
  }

  ProgressSnapshot copyWith({
    int? score,
    int? totalXP,
    int? level,
    int? currentStreak,
    int? maxStreak,
    int? sessionScore,
    int? sessionStreak,
    int? sessionCorrectAnswers,
    Map<String, int>? sessionCategoryMastery,
    int? lives,
    int? dailyStreak,
    String? lastEngagementDate,
    String? lastProcessedSessionId,
    DateTime? timestamp,
  }) {
    return ProgressSnapshot(
      score: score ?? this.score,
      totalXP: totalXP ?? this.totalXP,
      level: level ?? this.level,
      currentStreak: currentStreak ?? this.currentStreak,
      maxStreak: maxStreak ?? this.maxStreak,
      sessionScore: sessionScore ?? this.sessionScore,
      sessionStreak: sessionStreak ?? this.sessionStreak,
      sessionCorrectAnswers:
          sessionCorrectAnswers ?? this.sessionCorrectAnswers,
      sessionCategoryMastery:
          sessionCategoryMastery ?? this.sessionCategoryMastery,
      lives: lives ?? this.lives,
      dailyStreak: dailyStreak ?? this.dailyStreak,
      lastEngagementDate:
          lastEngagementDate ?? this.lastEngagementDate,
      lastProcessedSessionId:
          lastProcessedSessionId ?? this.lastProcessedSessionId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
    'score': score,
    'totalXP': totalXP,
    'level': level,
    'currentStreak': currentStreak,
    'maxStreak': maxStreak,
    'sessionScore': sessionScore,
    'sessionStreak': sessionStreak,
    'sessionCorrectAnswers': sessionCorrectAnswers,
    'sessionCategoryMastery': sessionCategoryMastery,
    'lives': lives,
    'dailyStreak': dailyStreak,
    'lastEngagementDate': lastEngagementDate,
    'lastProcessedSessionId': lastProcessedSessionId,
    'timestamp': timestamp.toIso8601String(),
  };
}
