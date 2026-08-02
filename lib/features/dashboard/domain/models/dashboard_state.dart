import 'package:flutter/foundation.dart';
import '../../../player/domain/models/player_profile.dart';

@immutable
class DashboardState {
  final bool isLoading;
  final String? error;
  final PlayerProfile? player;
  final List<String> announcements;
  final DailyChallenge? dailyChallenge;
  final String greeting;

  const DashboardState({
    this.isLoading = false,
    this.error,
    this.player,
    this.announcements = const [],
    this.dailyChallenge,
    this.greeting = 'Good Morning',
  });

  DashboardState copyWith({
    bool? isLoading,
    String? error,
    PlayerProfile? player,
    List<String>? announcements,
    DailyChallenge? dailyChallenge,
    String? greeting,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      player: player ?? this.player,
      announcements: announcements ?? this.announcements,
      dailyChallenge: dailyChallenge ?? this.dailyChallenge,
      greeting: greeting ?? this.greeting,
    );
  }
}

@immutable
class DailyChallenge {
  final String title;
  final String description;
  final int xpReward;
  final double completionPercentage;

  const DailyChallenge({
    required this.title,
    required this.description,
    required this.xpReward,
    required this.completionPercentage,
  });
}
