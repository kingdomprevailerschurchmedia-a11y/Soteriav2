import 'package:flutter/foundation.dart';

@immutable
class TournamentReward {
  final int coins;
  final int xp;
  final List<String> badges;
  final List<String> titles;
  final List<String> achievements;

  const TournamentReward({
    this.coins = 0,
    this.xp = 0,
    this.badges = const [],
    this.titles = const [],
    this.achievements = const [],
  });

  bool get isEmpty =>
      coins == 0 &&
      xp == 0 &&
      badges.isEmpty &&
      titles.isEmpty &&
      achievements.isEmpty;

  Map<String, dynamic> toJson() => {
    'coins': coins,
    'xp': xp,
    'badges': badges,
    'titles': titles,
    'achievements': achievements,
  };

  factory TournamentReward.fromJson(Map<String, dynamic> json) =>
      TournamentReward(
        coins: json['coins'] ?? 0,
        xp: json['xp'] ?? 0,
        badges: List<String>.from(json['badges'] ?? []),
        titles: List<String>.from(json['titles'] ?? []),
        achievements: List<String>.from(json['achievements'] ?? []),
      );
}
