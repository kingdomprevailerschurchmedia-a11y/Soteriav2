import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_activity_event.dart';
import '../domain/models/competitive_event.dart';
import '../presentation/providers/activity_providers.dart';
import '../presentation/screens/competitive_activity_screen.dart';
import 'mock_activity_repository.dart';

class ActivityPreviewWrapper extends StatelessWidget {
  const ActivityPreviewWrapper({
    super.key,
    required this.events,
    this.isLoading = false,
  });

  final List<CompetitiveActivityEvent> events;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        activityRepositoryProvider.overrideWithValue(
          MockActivityRepository(events, isLoading),
        ),
      ],
      child: const CompetitiveActivityScreen(),
    );
  }
}

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
        userId: 'u1',
        type: CompetitiveEventType.rankPromoted,
        title: 'Promotion',
        description: 'Reached Diamond II',
        createdAt: now.subtract(const Duration(days: 1)),
        seasonId: 'season_8',
        importance: ActivityImportance.high,
      ),
      CompetitiveActivityEvent(
        id: '3',
        userId: 'u1',
        type: CompetitiveEventType.personalBest,
        title: 'Personal Best',
        description: 'Reached #42 globally',
        createdAt: now.subtract(const Duration(days: 2)),
        seasonId: 'season_8',
        importance: ActivityImportance.normal,
      ),
      CompetitiveActivityEvent(
        id: '4',
        userId: 'u1',
        type: CompetitiveEventType.rewardReceived,
        title: 'Reward Received',
        description: '500 Coins',
        createdAt: now.subtract(const Duration(days: 3)),
        seasonId: 'season_8',
        importance: ActivityImportance.normal,
      ),
    ];
  }

  static Widget full() => ActivityPreviewWrapper(events: mockEvents());
  static Widget empty() => const ActivityPreviewWrapper(events: []);
  static Widget loading() =>
      const ActivityPreviewWrapper(events: [], isLoading: true);
}
