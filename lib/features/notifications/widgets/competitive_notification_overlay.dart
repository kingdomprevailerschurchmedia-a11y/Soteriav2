import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../player/domain/models/competitive_event.dart';
import '../../player/domain/models/rank_change.dart';
import '../../player/presentation/widgets/level_up_celebration.dart';
import '../../player/presentation/widgets/rank_promotion_celebration.dart';
import '../providers/notification_providers.dart';
import 'notification_banner.dart';

class CompetitiveNotificationOverlay extends ConsumerWidget {
  const CompetitiveNotificationOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeEvent = ref.watch(activeCompetitiveEventProvider);

    if (activeEvent == null) return const SizedBox.shrink();

    return _buildEventUI(context, ref, activeEvent);
  }

  Widget _buildEventUI(
    BuildContext context,
    WidgetRef ref,
    CompetitiveEvent event,
  ) {
    switch (event.type) {
      case CompetitiveEventType.rankPromoted:
        return RankPromotionCelebration(
          rankChange: RankChange(
            changeId: event.eventId,
            userId: event.userId,
            seasonId: event.seasonId ?? 'current',
            previousRank: 'Previous',
            newRank: event.metadata['rank'] ?? event.body,
            previousRankPoints: 0,
            newRankPoints: 0,
            changeAmount: 0,
            type: RankChangeType.promotion,
            createdAt: event.createdAt,
          ),
          onContinue: () => _dismiss(ref),
        );
      case CompetitiveEventType.personalBest:
        if (event.title.contains('Level Up')) {
          return LevelUpCelebration(
            previousLevel: (event.metadata['level'] ?? 1) - 1,
            newLevel: event.metadata['level'] ?? 1,
            onContinue: () => _dismiss(ref),
          );
        }
        return _buildBanner(event, ref);
      case CompetitiveEventType.rewardReceived:
      case CompetitiveEventType.milestoneCompleted:
      case CompetitiveEventType.seasonCompleted:
        return _buildBanner(event, ref);
      default:
        return _buildBanner(event, ref);
    }
  }

  Widget _buildBanner(CompetitiveEvent event, WidgetRef ref) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: NotificationBanner(
        title: event.title,
        body: event.body,
        onDismiss: () => _dismiss(ref),
      ),
    );
  }

  void _dismiss(WidgetRef ref) {
    ref.read(activeCompetitiveEventProvider.notifier).state = null;
  }
}
