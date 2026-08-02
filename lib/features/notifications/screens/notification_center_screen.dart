import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'package:soteria/core/widgets/cards/soteria_card.dart';
import 'package:soteria/core/widgets/feedback/soteria_empty_state.dart';
import '../domain/models/app_notification.dart';
import '../providers/notification_providers.dart';

class NotificationCenterScreen extends ConsumerWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationListProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'NOTIFICATIONS',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            letterSpacing: 4,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.clear_all_rounded,
              color: SoteriaColors.muted,
            ),
            onPressed: () =>
                ref.read(notificationListProvider.notifier).clearAll(),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: notificationsAsync.when(
          data: (notifications) => notifications.isEmpty
              ? const Center(
                  child: SoteriaEmptyState(
                    title: 'ALL CAUGHT UP',
                    subtitle:
                        'Your notification center is clear. New updates will appear here.',
                    icon: Icons.notifications_none_rounded,
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.fromLTRB(
                    SoteriaSpacing.lg,
                    kToolbarHeight + SoteriaSpacing.xl,
                    SoteriaSpacing.lg,
                    SoteriaSpacing.xl,
                  ),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return _NotificationTile(
                      notification: notifications[index],
                    );
                  },
                ),
          loading: () => const Center(child: SoteriaLoader()),
          error: (error, _) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}

class _NotificationTile extends ConsumerWidget {
  final AppNotification notification;
  const _NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = _getTypeColor(notification.type);
    final icon = _getTypeIcon(notification.type);

    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Dismissible(
        key: Key(notification.id),
        direction: DismissDirection.endToStart,
        onDismissed: (_) =>
            ref.read(notificationListProvider.notifier).delete(notification.id),
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: SoteriaSpacing.xl),
          decoration: BoxDecoration(
            color: SoteriaColors.error.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.delete_outline_rounded,
            color: SoteriaColors.error,
          ),
        ),
        child: SoteriaCard(
          padding: EdgeInsets.zero,
          child: InkWell(
            onTap: () {
              if (!notification.read) {
                ref
                    .read(notificationListProvider.notifier)
                    .markAsRead(notification.id);
              }
              // Potential: Trigger navigation based on notification.action
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: EdgeInsets.all(SoteriaSpacing.md),
              decoration: BoxDecoration(
                border: notification.read
                    ? null
                    : Border(left: BorderSide(color: color, width: 4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: color.withValues(alpha: 0.1),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  SizedBox(width: SoteriaSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              notification.title,
                              style: context.bodyLarge.copyWith(
                                fontWeight: notification.read
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                                color: notification.read
                                    ? Colors.white70
                                    : Colors.white,
                              ),
                            ),
                            Text(
                              _formatDate(notification.createdAt),
                              style: context.labelSmall.copyWith(
                                color: SoteriaColors.muted,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SoteriaSpacing.xs),
                        Text(
                          notification.body,
                          style: context.bodyMedium.copyWith(
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.tournamentInvitation:
      case NotificationType.tournamentStart:
      case NotificationType.tournamentResults:
        return SoteriaColors.primary;
      case NotificationType.achievementEarned:
      case NotificationType.levelUp:
      case NotificationType.streakReminder:
        return SoteriaColors.gold;
      case NotificationType.practiceReminder:
      case NotificationType.dailyReminder:
        return SoteriaColors.secondary;
      case NotificationType.systemUpdate:
      case NotificationType.maintenance:
        return Colors.blue;
      case NotificationType.announcement:
      case NotificationType.promotion:
        return SoteriaColors.success;
      default:
        return SoteriaColors.muted;
    }
  }

  IconData _getTypeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.tournamentInvitation:
      case NotificationType.tournamentStart:
      case NotificationType.tournamentResults:
        return Icons.emoji_events_rounded;
      case NotificationType.achievementEarned:
      case NotificationType.levelUp:
        return Icons.auto_awesome_rounded;
      case NotificationType.streakReminder:
        return Icons.local_fire_department_rounded;
      case NotificationType.practiceReminder:
      case NotificationType.dailyReminder:
        return Icons.timer_rounded;
      case NotificationType.systemUpdate:
      case NotificationType.maintenance:
        return Icons.settings_suggest_rounded;
      case NotificationType.announcement:
        return Icons.campaign_rounded;
      case NotificationType.promotion:
        return Icons.star_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inMinutes < 60) return '${difference.inMinutes}m';
    if (difference.inHours < 24) return '${difference.inHours}h';
    return '${difference.inDays}d';
  }
}
