/// Immutable state of a player's progression at a specific point in time.
class ProgressSnapshot {
  final int score;
  final int totalXP;
  final int level;
  final int currentStreak;
  final int maxStreak;
  final int sessionScore;
  final int sessionStreak;
  final int dailyStreak;
  final DateTime? lastDailyStreakUpdate;
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
    required this.dailyStreak,
    this.lastDailyStreakUpdate,
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
    dailyStreak: 0,
    timestamp: DateTime.now(),
  );

  ProgressSnapshot copyWith({
    int? score,
    int? totalXP,
    int? level,
    int? currentStreak,
    int? maxStreak,
    int? sessionScore,
    int? sessionStreak,
    int? dailyStreak,
    DateTime? lastDailyStreakUpdate,
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
      dailyStreak: dailyStreak ?? this.dailyStreak,
      lastDailyStreakUpdate:
          lastDailyStreakUpdate ?? this.lastDailyStreakUpdate,
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
    'dailyStreak': dailyStreak,
    'lastDailyStreakUpdate': lastDailyStreakUpdate?.toIso8601String(),
    'lastProcessedSessionId': lastProcessedSessionId,
    'timestamp': timestamp.toIso8601String(),
  };
}
