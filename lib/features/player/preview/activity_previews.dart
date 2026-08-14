import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_activity_event.dart';
import '../domain/models/competitive_event.dart';
import '../presentation/providers/activity_providers.dart';
import '../presentation/screens/competitive_activity_screen.dart';
import '../../auth/providers/auth_providers.dart';
import 'mock_activity_repository.dart';

class ActivityPreviews {
  static List<CompetitiveActivityEvent> mockEvents() {
    final now = DateTime.now();
    return [
      CompetitiveActivityEvent(
        id: '1',
        userId: 'u1',
        type: CompetitiveEventType.milestoneCompleted,
        title: 'Achievement Unlocked',
        description: 'Diamond Competitor reached!',
        createdAt: now.subtract(const Duration(hours: 2)),
        seasonId: 'season_8',
        importance: ActivityImportance.milestone,
      ),
      CompetitiveActivityEvent(
        id: '2',
        userId: 'rival_alex',
        type: CompetitiveEventType.rankPromoted,
        title: 'Promotion',
        description: 'Reached Gold I',
        createdAt: now.subtract(const Duration(minutes: 45)),
        metadata: {'rank': 'Gold I'},
        importance: ActivityImportance.high,
      ),
      CompetitiveActivityEvent(
        id: 'streak_1',
        userId: 'u1',
        type: CompetitiveEventType.streakReached,
        title: '5 Match Win Streak!',
        description: 'You are on fire! Keep it up.',
        createdAt: now.subtract(const Duration(hours: 5)),
        metadata: {'streak': 5},
        importance: ActivityImportance.high,
      ),
      CompetitiveActivityEvent(
        id: 'challenge_1',
        userId: 'friend_jordan',
        type: CompetitiveEventType.challengeCompleted,
        title: 'Challenge Won',
        description: 'Completed the 3-win showdown!',
        createdAt: now.subtract(const Duration(hours: 1)),
        importance: ActivityImportance.high,
      ),
    ];
  }

  static Widget full() {
    return ProviderScope(
      overrides: [
        activityRepositoryProvider.overrideWithValue(MockActivityRepository(mockEvents(), false)),
      ],
      child: const CompetitiveActivityScreen(),
    );
  }

  static Widget empty() {
    return ProviderScope(
      overrides: [
        activityRepositoryProvider.overrideWithValue(MockActivityRepository([], false)),
      ],
      child: const CompetitiveActivityScreen(),
    );
  }
}
