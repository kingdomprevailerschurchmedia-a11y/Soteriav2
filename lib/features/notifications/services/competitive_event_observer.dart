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
import '../../player/presentation/providers/personal_record_providers.dart';
import '../../player/domain/models/competitive_personal_record.dart';
import '../../player/domain/models/live_event.dart';
import '../../player/presentation/providers/live_event_providers.dart';
import '../../player/domain/models/player_profile.dart';
import '../../player/domain/config/progression_config.dart';
import '../../../core/services/time_service.dart';
import '../domain/models/app_notification.dart';
import '../domain/repositories/notification_repository.dart';
import '../providers/notification_providers.dart';
import '../../player/domain/models/competitive_badge.dart';
import '../../player/domain/models/competitive_title.dart';
import '../../player/providers/player_providers.dart';
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
    _observePersonalRecords();
    _observeProfileChanges();
    _observeLiveEvents();
  }

  void _observeLiveEvents() {
    _ref.listen<AsyncValue<List<LiveEvent>>>(activeLiveEventsProvider, (
      previous,
      next,
    ) {
      final oldList = previous?.value ?? [];
      final newList = next.value ?? [];

      if (newList.length > oldList.length) {
        final newEvents = newList.where(
          (n) => !oldList.any((o) => o.eventId == n.eventId),
        );
        for (final event in newEvents) {
          _emitEvent(
            CompetitiveEvent(
              eventId: const Uuid().v4(),
              userId: 'all',
              type: CompetitiveEventType.liveEventStarted,
              title: 'New Live Event!',
              body: '${event.name} is now active.',
              metadata: {'eventId': event.eventId},
              createdAt: DateTime.now(),
              priority: 2,
              deduplicationKey: 'live_event_start_${event.eventId}',
            ),
          );
        }
      }
    });
  }

  void _observeProfileChanges() {
    _ref.listen<AsyncValue<PlayerProfile?>>(currentPlayerStreamProvider, (
      previous,
      next,
    ) {
      final oldData = previous?.value;
      final newData = next.value;

      if (oldData != null && newData != null) {
        // 1. Badges
        if (newData.badges.length > oldData.badges.length) {
          final newBadgeIds = newData.badges.where(
            (id) => !oldData.badges.contains(id),
          );
          for (final badgeId in newBadgeIds) {
            _emitEvent(
              CompetitiveEvent(
                eventId: const Uuid().v4(),
                userId: newData.uid,
                type: CompetitiveEventType.badgeEarned,
                title: 'New Badge Earned!',
                body: 'You unlocked a new competitive badge.',
                metadata: {'badgeId': badgeId},
                createdAt: DateTime.now(),
                priority: 2,
                deduplicationKey: 'badge_${badgeId}_${newData.uid}',
              ),
            );
          }
        }

        // 2. Titles (from achievements list)
        if (newData.achievements.length > oldData.achievements.length) {
          final newAchievementIds = newData.achievements.where(
            (id) => !oldData.achievements.contains(id),
          );
          for (final achievementId in newAchievementIds) {
            // We assume for now that new achievements might also be titles
            // The activity card can resolve the actual name/type
            _emitEvent(
              CompetitiveEvent(
                eventId: const Uuid().v4(),
                userId: newData.uid,
                type: CompetitiveEventType.titleEarned,
                title: 'New Title Unlocked!',
                body: 'A new title is now available for your profile.',
                metadata: {'achievementId': achievementId},
                createdAt: DateTime.now(),
                priority: 2,
                deduplicationKey: 'title_${achievementId}_${newData.uid}',
              ),
            );
          }
        }

        // 3. Win Streaks
        if (newData.currentStreak > oldData.currentStreak) {
          final milestones = [5, 10, 20, 50, 100];
          for (final milestone in milestones) {
            if (newData.currentStreak == milestone &&
                oldData.currentStreak < milestone) {
              _emitEvent(
                CompetitiveEvent(
                  eventId: const Uuid().v4(),
                  userId: newData.uid,
                  type: CompetitiveEventType.streakReached,
                  title: '$milestone Match Win Streak!',
                  body: 'You are on fire! Keep it up.',
                  metadata: {'streak': milestone},
                  createdAt: DateTime.now(),
                  priority: 2,
                  deduplicationKey: 'streak_${milestone}_${newData.uid}',
                ),
              );
            }
          }
        }

        // 4. Matches Completed
        if (newData.gamesPlayed > oldData.gamesPlayed) {
          _emitEvent(
            CompetitiveEvent(
              eventId: const Uuid().v4(),
              userId: newData.uid,
              type: CompetitiveEventType.matchCompleted,
              title: 'Match Completed',
              body: 'You finished a competitive match.',
              createdAt: DateTime.now(),
              priority: 1,
              deduplicationKey:
                  'match_${newData.gamesPlayed}_${newData.uid}_${DateTime.now().millisecondsSinceEpoch}',
            ),
          );
        }
      }
    });
  }

  void _observeProgression() {
    _ref.listen<AsyncValue<PlayerProgression>>(competitiveProgressionProvider, (
      previous,
      next,
    ) {
      final oldData = previous?.value;
      final newData = next.value;

      if (oldData != null && newData != null) {
        // 1. Rank Change (Tier or Division)
        if (oldData.currentRank != newData.currentRank) {
          final oldOrder = _getTierOrder(oldData.currentRankTier);
          final newOrder = _getTierOrder(newData.currentRankTier);

          final oldDiv = _getDivision(oldData.currentRank);
          final newDiv = _getDivision(newData.currentRank);

          final isPromotion =
              newOrder > oldOrder || (newOrder == oldOrder && newDiv < oldDiv);
          final isTierChange = newOrder != oldOrder;

          _emitEvent(
            CompetitiveEvent(
              eventId: const Uuid().v4(),
              userId: newData.userId,
              type:
                  isPromotion
                      ? CompetitiveEventType.rankPromoted
                      : CompetitiveEventType.rankDemoted,
              title:
                  isPromotion
                      ? (isTierChange ? 'Tier Promotion!' : 'Division Rank Up!')
                      : 'Rank Adjusted',
              body: newData.currentRank,
              metadata: {
                'tier': newData.currentRankTier,
                'rank': newData.currentRank,
                'previousRank': oldData.currentRank,
                'isTierChange': isTierChange,
              },
              createdAt: DateTime.now(),
              priority: isTierChange ? 3 : 2, // Milestone for Tier change
              deduplicationKey:
                  'rank_change_${newData.userId}_${newData.currentRank}_${newData.rankPoints}',
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
      case CompetitiveEventType.badgeEarned:
        return NotificationType.milestoneReached;
      case CompetitiveEventType.titleEarned:
        return NotificationType.milestoneReached;
      case CompetitiveEventType.tournamentResult:
        return NotificationType.seasonResult;
      case CompetitiveEventType.matchCompleted:
        return NotificationType.personalBest;
      case CompetitiveEventType.streakReached:
        return NotificationType.personalBest;
      case CompetitiveEventType.liveEventStarted:
        return NotificationType.liveEventStarted;
      case CompetitiveEventType.liveEventEnding:
        return NotificationType.liveEventEnding;
      case CompetitiveEventType.rematchRequest:
        return NotificationType.rematchRequest;
      case CompetitiveEventType.systemAnnouncement:
        return NotificationType.systemAnnouncement;
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
      case CompetitiveEventType.badgeEarned:
      case CompetitiveEventType.titleEarned:
        return 'achievements';
      case CompetitiveEventType.rewardReceived:
        return 'rewards';
      case CompetitiveEventType.seasonResultAvailable:
      case CompetitiveEventType.seasonResult:
      case CompetitiveEventType.seasonCompleted:
      case CompetitiveEventType.tournamentResult:
      case CompetitiveEventType.newSeasonStarted:
      case CompetitiveEventType.seasonStarted:
        return 'season';
      case CompetitiveEventType.matchCompleted:
      case CompetitiveEventType.streakReached:
        return 'profile';
      case CompetitiveEventType.liveEventStarted:
      case CompetitiveEventType.liveEventEnding:
        return 'events';
      case CompetitiveEventType.rematchRequest:
        return 'versus';
      default:
        return null;
    }
  }

  void _observePersonalRecords() {
    _ref.listen<AsyncValue<List<CompetitivePersonalRecord>>>(
      currentUserPersonalRecordsProvider,
      (previous, next) {
        final oldList = previous?.value ?? [];
        final newList = next.value ?? [];

        if (newList.length > oldList.length) {
          final newRecords = newList.where(
            (n) => !oldList.any((o) => o.id == n.id),
          );

          for (final record in newRecords) {
            // We only notify for career records or significant seasonal records
            if (record.isCareerRecord) {
              _emitEvent(
                CompetitiveEvent(
                  eventId: const Uuid().v4(),
                  userId: record.userId,
                  type: CompetitiveEventType.personalBest,
                  title: 'New Career Best!',
                  body: 'You just set a new record for ${_formatRecordType(record.type)}: ${record.displayValue}',
                  createdAt: DateTime.now(),
                  metadata: {
                    'recordType': record.type.name,
                    'value': record.value,
                    'displayValue': record.displayValue,
                  },
                  priority: 2,
                  deduplicationKey: 'record_${record.id}',
                ),
              );
            }
          }
        }
      },
    );
  }

  String _formatRecordType(CompetitiveRecordType type) {
    switch (type) {
      case CompetitiveRecordType.highestScore:
        return 'Highest Score';
      case CompetitiveRecordType.bestAccuracy:
        return 'Best Accuracy';
      case CompetitiveRecordType.longestWinStreak:
        return 'Longest Win Streak';
      case CompetitiveRecordType.mostRankPointsGained:
        return 'Rank Points Gained';
      case CompetitiveRecordType.bestRankReached:
        return 'Best Rank Reached';
      case CompetitiveRecordType.bestLeaderboardPosition:
        return 'Best Leaderboard Position';
      case CompetitiveRecordType.bestSeasonPosition:
        return 'Best Season Position';
      case CompetitiveRecordType.mostWinsInSeason:
        return 'Most Wins in Season';
      case CompetitiveRecordType.bestModeScore:
        return 'Best Mode Score';
    }
  }

  int _getTierOrder(String tierId) {
    return ProgressionConfig.rankTiers
        .firstWhere(
          (t) => t.id == tierId.toLowerCase(),
          orElse: () => ProgressionConfig.rankTiers.first,
        )
        .displayOrder;
  }

  int _getDivision(String rankName) {
    final parts = rankName.split(' ');
    if (parts.length < 2) return 0;
    final roman = parts[1];
    switch (roman) {
      case 'I':
        return 1;
      case 'II':
        return 2;
      case 'III':
        return 3;
      default:
        return 0;
    }
  }
}
