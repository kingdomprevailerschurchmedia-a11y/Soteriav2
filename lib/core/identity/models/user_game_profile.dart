import 'package:flutter/foundation.dart';

@immutable
class UserGameProfile {
  final int xp;
  final int level;
  final int coins;
  final int tokens;
  final int lives;
  final List<String> achievements;
  final List<String> badges;
  final String rank;
  final int globalRank;
  final int campusRank;
  final int dailyStreak;
  final int longestStreak;
  final int questionsAnswered;
  final double accuracy;

  const UserGameProfile({
    this.xp = 0,
    this.level = 1,
    this.coins = 0,
    this.tokens = 0,
    this.lives = 5,
    this.achievements = const [],
    this.badges = const [],
    this.rank = 'Novice',
    this.globalRank = 0,
    this.campusRank = 0,
    this.dailyStreak = 0,
    this.longestStreak = 0,
    this.questionsAnswered = 0,
    this.accuracy = 0.0,
  });

  UserGameProfile copyWith({
    int? xp,
    int? level,
    int? coins,
    int? tokens,
    int? lives,
    List<String>? achievements,
    List<String>? badges,
    String? rank,
    int? globalRank,
    int? campusRank,
    int? dailyStreak,
    int? longestStreak,
    int? questionsAnswered,
    double? accuracy,
  }) {
    return UserGameProfile(
      xp: xp ?? this.xp,
      level: level ?? this.level,
      coins: coins ?? this.coins,
      tokens: tokens ?? this.tokens,
      lives: lives ?? this.lives,
      achievements: achievements ?? this.achievements,
      badges: badges ?? this.badges,
      rank: rank ?? this.rank,
      globalRank: globalRank ?? this.globalRank,
      campusRank: campusRank ?? this.campusRank,
      dailyStreak: dailyStreak ?? this.dailyStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      questionsAnswered: questionsAnswered ?? this.questionsAnswered,
      accuracy: accuracy ?? this.accuracy,
    );
  }
}
