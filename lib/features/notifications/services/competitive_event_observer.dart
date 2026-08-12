import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../player/domain/models/competitive_event.dart';
import '../../player/domain/models/player_progression.dart';
import '../../player/domain/models/competitive_season.dart';
import '../../player/domain/models/reward_grant.dart';
import '../../player/domain/models/milestone.dart';
import '../../player/presentation/providers/progression_providers.dart';
import '../../player/presentation/providers/season_providers.dart';
import '../../player/presentation/providers/reward_providers.dart';
import '../../player/presentation/providers/milestone_providers.dart';
import '../../player/domain/config/progression_config.dart';
import '../../../core/services/time_service.dart';
import '../domain/models/app_notification.dart';
import '../domain/repositories/notification_repository.dart';
import '../providers/notification_providers.dart';
import 'package:uuid/uuid.dart';

import '../../player/domain/repositories/activity_repository.dart';
import '../../player/domain/models/competitive_activity_event.dart';

class CompetitiveEventObserver {
  final Ref _ref;
  final NotificationRepository _repository;
  final ActivityRepository _activityRepository;

  CompetitiveEventObserver(
    this._ref,
    this._repository,
    this._activityRepository,
  );

  void start() {
    _observeProgression();
    _observeSeason();
    _observeRewards();
    _observeMilestones();
  }

  void _observeProgression() {
    _ref.listen<AsyncValue<PlayerProgression>>(competitiveProgressionProvider, (
      previous,
      next,
    ) {
      final oldData = previous?.value;
      final newData = next.value;

      if (oldData != null && newData != null) {
        // 1. Rank Change
        if (oldData.currentRankTier != newData.currentRankTier) {
          final isPromotion = _isPromotion(
            oldData.currentRankTier,
            newData.currentRankTier,
          );
          _emitEvent(
            CompetitiveEvent(
              eventId: const Uuid().v4(),
              userId: newData.userId,
              type: isPromotion
                  ? CompetitiveEventType.rankPromoted
                  : CompetitiveEventType.rankDemoted,
              title: isPromotion ? 'Promotion Achieved' : 'Rank Adjusted',
              body: newData.currentRank,
              metadata: {
                'tier': newData.currentRankTier,
                'rank': newData.currentRank,
              },
              createdAt: DateTime.now(),
              priority: 2, // High
              deduplicationKey:
                  'rank_change_${newData.userId}_${newData.currentRankTier}',
            ),
          );
        }

        // 2. Level Up
        if (oldData.currentLevel < newData.currentLevel) {
          _emitEvent(
            CompetitiveEvent(
              eventId: const Uuid().v4(),
              userId: newData.userId,
              type: CompetitiveEventType.personalBest,
              title: 'Level Up!',
              body:
                  'Congratulations! You reached Level ${newData.currentLevel}.',
              metadata: {'level': newData.currentLevel},
              createdAt: DateTime.now(),
              priority: 1, // Normal
              deduplicationKey:
                  'level_up_${newData.userId}_${newData.currentLevel}',
            ),
          );
        }
      }
    });
  }

  void _observeSeason() {
    _ref.listen<AsyncValue<CompetitiveSeason?>>(currentSeasonProvider, (
      previous,
      next,
    ) {
      final newData = next.value;
      if (newData == null) return;

      // 1. New Season
      if (previous?.value?.seasonId != newData.seasonId) {
        _emitEvent(
          CompetitiveEvent(
            eventId: const Uuid().v4(),
            userId: 'all',
            type: CompetitiveEventType.newSeasonStarted,
            title: 'New Season Started',
            body: '${newData.name} is now live! Compete and rise.',
            createdAt: DateTime.now(),
            seasonId: newData.seasonId,
            priority: 2,
            deduplicationKey: 'season_start_${newData.seasonId}',
          ),
        );
      }

      // 2. Season Ending Soon
      final timeService = _ref.read(timeServiceProvider);
      final now = timeService.nowUtc();
      final hoursRemaining = newData.endAt.difference(now).inHours;

      if (hoursRemaining > 0 && hoursRemaining <= 24) {
        _emitEvent(
          CompetitiveEvent(
            eventId: const Uuid().v4(),
            userId: 'all',
            type: CompetitiveEventType.seasonEnding,
            title: 'Season Ending Soon',
            body: 'Only $hoursRemaining hours left in ${newData.name}!',
            createdAt: DateTime.now(),
            seasonId: newData.seasonId,
            priority: 2,
            deduplicationKey: 'season_ending_${newData.seasonId}',
          ),
        );
      }
    });
  }

  void _observeRewards() {
    _ref.listen<AsyncValue<List<RewardGrant>>>(playerRewardsProvider, (
      previous,
      next,
    ) {
      final oldList = previous?.value ?? [];
      final newList = next.value ?? [];

      if (newList.length > oldList.length) {
        final newRewards = newList.where(
          (n) => !oldList.any((o) => o.grantId == n.grantId),
        );
        for (final reward in newRewards) {
          _emitEvent(
            CompetitiveEvent(
              eventId: const Uuid().v4(),
              userId: reward.userId,
              type: CompetitiveEventType.rewardReceived,
              title: 'Reward Received',
              body:
                  'You earned ${reward.amount} ${reward.type.name.toUpperCase()}.',
              createdAt: DateTime.now(),
              priority: 2,
              deduplicationKey: 'reward_${reward.grantId}',
            ),
          );
        }
      }
    });
  }

  void _observeMilestones() {
    _ref.listen<AsyncValue<List<PlayerMilestone>>>(playerMilestonesProvider, (
      previous,
      next,
    ) {
      final oldList = previous?.value ?? [];
      final newList = next.value ?? [];

      final newlyCompleted = newList.where(
        (n) =>
            (n.status == MilestoneStatus.completed ||
                n.status == MilestoneStatus.claimed) &&
            !oldList.any(
              (o) =>
                  o.milestoneId == n.milestoneId &&
                  (o.status == MilestoneStatus.completed ||
                      o.status == MilestoneStatus.claimed),
            ),
      );

      for (final milestone in newlyCompleted) {
        _emitEvent(
          CompetitiveEvent(
            eventId: const Uuid().v4(),
            userId: milestone.userId,
            type: CompetitiveEventType.milestoneCompleted,
            title: 'Achievement Unlocked',
            body: 'You completed a competitive milestone!',
            createdAt: DateTime.now(),
            priority: 1,
            deduplicationKey:
                'milestone_${milestone.milestoneId}_${milestone.userId}',
          ),
        );
      }
    });
  }

  void _emitEvent(CompetitiveEvent event) {
    // 1. Map event to AppNotification and save for Notification Center
    final notification = AppNotification(
      id: event.eventId,
      title: event.title,
      body: event.body,
      type: _mapType(event.type),
      createdAt: event.createdAt,
      priority: event.priority,
      payload: {'deduplicationKey': event.deduplicationKey, ...event.metadata},
      action: _mapAction(event.type),
    );

    _repository.saveNotification(notification);

    // 2. Map event to CompetitiveActivityEvent and save to persistent history
    // We only save events with a valid userId (not 'all') to the user's activity feed
    if (event.userId != 'all') {
      final activityEvent = CompetitiveActivityEvent(
        id: event.deduplicationKey ?? event.eventId,
        userId: event.userId,
        type: event.type,
        title: event.title,
        description: event.body,
        createdAt: event.createdAt,
        seasonId: event.seasonId,
        metadata: event.metadata,
        deepLink: _mapAction(event.type),
        importance: _mapImportance(event.priority),
      );
      _activityRepository.recordActivityEvent(activityEvent);
    }

    // 3. Trigger high-priority in-app awareness (Celebrations, Banners)
    if (event.priority >= 2) {
      _ref.read(activeCompetitiveEventProvider.notifier).state = event;
    }
  }

  ActivityImportance _mapImportance(int priority) {
    if (priority >= 3) return ActivityImportance.milestone;
    if (priority >= 2) return ActivityImportance.high;
    if (priority >= 1) return ActivityImportance.normal;
    return ActivityImportance.low;
  }

  NotificationType _mapType(CompetitiveEventType type) {
    switch (type) {
      case CompetitiveEventType.rankPromoted:
        return NotificationType.promotion;
      case CompetitiveEventType.rankDemoted:
        return NotificationType.rankDemoted;
      case CompetitiveEventType.rankReached:
        return NotificationType.promotion;
      case CompetitiveEventType.rankChanged:
        return NotificationType.rankChanged;
      case CompetitiveEventType.leaderboardChanged:
        return NotificationType.leaderboardChanged;
      case CompetitiveEventType.leaderboardMilestone:
        return NotificationType.leaderboardChanged;
      case CompetitiveEventType.personalBest:
        return NotificationType.personalBest;
      case CompetitiveEventType.seasonEnding:
        return NotificationType.seasonEnding;
      case CompetitiveEventType.seasonStarted:
        return NotificationType.announcement;
      case CompetitiveEventType.seasonCompleted:
        return NotificationType.seasonCompleted;
      case CompetitiveEventType.seasonResult:
        return NotificationType.seasonResult;
      case CompetitiveEventType.seasonResultAvailable:
        return NotificationType.seasonResult;
      case CompetitiveEventType.rewardReceived:
        return NotificationType.rewardReceived;
      case CompetitiveEventType.milestoneCompleted:
        return NotificationType.milestoneReached;
      case CompetitiveEventType.achievementUnlocked:
        return NotificationType.milestoneReached;
      case CompetitiveEventType.newSeasonStarted:
        return NotificationType.announcement;
      case CompetitiveEventType.gameMilestone:
        return NotificationType.milestoneReached;
      case CompetitiveEventType.winMilestone:
        return NotificationType.milestoneReached;
      case CompetitiveEventType.careerMilestone:
        return NotificationType.milestoneReached;
    }
  }

  String? _mapAction(CompetitiveEventType type) {
    switch (type) {
      case CompetitiveEventType.rankPromoted:
      case CompetitiveEventType.rankDemoted:
      case CompetitiveEventType.rankReached:
      case CompetitiveEventType.rankChanged:
        return 'profile';
      case CompetitiveEventType.leaderboardChanged:
      case CompetitiveEventType.leaderboardMilestone:
        return 'leaderboard';
      case CompetitiveEventType.milestoneCompleted:
      case CompetitiveEventType.achievementUnlocked:
      case CompetitiveEventType.careerMilestone:
      case CompetitiveEventType.gameMilestone:
      case CompetitiveEventType.winMilestone:
        return 'achievements';
      case CompetitiveEventType.rewardReceived:
        return 'rewards';
      case CompetitiveEventType.seasonResultAvailable:
      case CompetitiveEventType.seasonResult:
      case CompetitiveEventType.seasonCompleted:
        return 'history';
      default:
        return null;
    }
  }

  bool _isPromotion(String oldTier, String newTier) {
    final oldOrder = ProgressionConfig.rankTiers
        .firstWhere(
          (t) => t.id == oldTier.toLowerCase(),
          orElse: () => ProgressionConfig.rankTiers.first,
        )
        .displayOrder;
    final newOrder = ProgressionConfig.rankTiers
        .firstWhere(
          (t) => t.id == newTier.toLowerCase(),
          orElse: () => ProgressionConfig.rankTiers.first,
        )
        .displayOrder;
    return newOrder > oldOrder;
  }
}
