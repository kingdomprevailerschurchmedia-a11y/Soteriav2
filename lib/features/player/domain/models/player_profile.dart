import 'package:flutter/foundation.dart';

@immutable
class PlayerProfile {
  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;

  // Progression
  final int level;
  final int xp;
  final int coins;

  // Stats
  final int currentStreak;
  final int highestStreak;
  final int totalQuestionsAnswered;
  final int correctAnswers;
  final double accuracy;

  // Match History
  final int gamesPlayed;
  final int gamesWon;
  final int practiceSessions;
  final int proSessions;
  final int versusMatches;
  final int tournamentMatches;

  // Customization & Metadata
  final List<String> favoriteCategories;
  final String preferredLanguage;
  final String avatarFrame;
  final List<String> badges;
  final List<String> achievements;
  final String role; // user, moderator, admin
  final String accountStatus; // active, suspended, deleted

  final DateTime createdAt;
  final DateTime lastLogin;
  final DateTime updatedAt;

  final Map<String, dynamic> settings;
  final int version; // For schema migrations

  const PlayerProfile({
    required this.uid,
    required this.displayName,
    required this.email,
    this.photoUrl = '',
    this.level = 1,
    this.xp = 0,
    this.coins = 0,
    this.currentStreak = 0,
    this.highestStreak = 0,
    this.totalQuestionsAnswered = 0,
    this.correctAnswers = 0,
    this.accuracy = 0.0,
    this.gamesPlayed = 0,
    this.gamesWon = 0,
    this.practiceSessions = 0,
    this.proSessions = 0,
    this.versusMatches = 0,
    this.tournamentMatches = 0,
    this.favoriteCategories = const [],
    this.preferredLanguage = 'en',
    this.avatarFrame = 'default',
    this.badges = const [],
    this.achievements = const [],
    this.role = 'user',
    this.accountStatus = 'active',
    required this.createdAt,
    required this.lastLogin,
    required this.updatedAt,
    this.settings = const {},
    this.version = 1,
  });

  PlayerProfile copyWith({
    String? displayName,
    String? photoUrl,
    int? level,
    int? xp,
    int? coins,
    int? currentStreak,
    int? highestStreak,
    int? totalQuestionsAnswered,
    int? correctAnswers,
    double? accuracy,
    int? gamesPlayed,
    int? gamesWon,
    int? practiceSessions,
    int? proSessions,
    int? versusMatches,
    int? tournamentMatches,
    List<String>? favoriteCategories,
    String? preferredLanguage,
    String? avatarFrame,
    List<String>? badges,
    List<String>? achievements,
    String? role,
    String? accountStatus,
    DateTime? lastLogin,
    DateTime? updatedAt,
    Map<String, dynamic>? settings,
    int? version,
  }) {
    return PlayerProfile(
      uid: uid,
      displayName: displayName ?? this.displayName,
      email: email,
      photoUrl: photoUrl ?? this.photoUrl,
      level: level ?? this.level,
      xp: xp ?? this.xp,
      coins: coins ?? this.coins,
      currentStreak: currentStreak ?? this.currentStreak,
      highestStreak: highestStreak ?? this.highestStreak,
      totalQuestionsAnswered:
          totalQuestionsAnswered ?? this.totalQuestionsAnswered,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      accuracy: accuracy ?? this.accuracy,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      gamesWon: gamesWon ?? this.gamesWon,
      practiceSessions: practiceSessions ?? this.practiceSessions,
      proSessions: proSessions ?? this.proSessions,
      versusMatches: versusMatches ?? this.versusMatches,
      tournamentMatches: tournamentMatches ?? this.tournamentMatches,
      favoriteCategories: favoriteCategories ?? this.favoriteCategories,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      avatarFrame: avatarFrame ?? this.avatarFrame,
      badges: badges ?? this.badges,
      achievements: achievements ?? this.achievements,
      role: role ?? this.role,
      accountStatus: accountStatus ?? this.accountStatus,
      createdAt: createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      updatedAt: updatedAt ?? this.updatedAt,
      settings: settings ?? this.settings,
      version: version ?? this.version,
    );
  }
}
