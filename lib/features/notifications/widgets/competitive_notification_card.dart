import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import '../domain/models/app_notification.dart';

class CompetitiveNotificationCard extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback? onTap;

  const CompetitiveNotificationCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getTypeColor(notification.type);
    final icon = _getTypeIcon(notification.type);

    return SoteriaCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(SoteriaSpacing.md),
          decoration: BoxDecoration(
            border: notification.read
                ? null
                : Border(left: BorderSide(color: color, width: 4)),
            gradient: notification.read
                ? null
                : LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: context.bodyLarge.copyWith(
                              fontWeight: notification.read
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              color: notification.read
                                  ? Colors.white70
                                  : Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
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
      case NotificationType.milestoneReached:
      case NotificationType.levelUp:
      case NotificationType.streakReminder:
        return SoteriaColors.gold;
      case NotificationType.rewardReceived:
        return SoteriaColors.xpColor;
      case NotificationType.seasonResult:
      case NotificationType.seasonCompleted:
      case NotificationType.seasonStarted:
      case NotificationType.announcement:
        return SoteriaColors.success;
      case NotificationType.liveEventStarted:
      case NotificationType.liveEventEnding:
        return SoteriaColors.secondary;
      case NotificationType.rankDemoted:
        return SoteriaColors.error;
      case NotificationType.rematchRequest:
        return SoteriaColors.warning;
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
      case NotificationType.milestoneReached:
        return Icons.auto_awesome_rounded;
      case NotificationType.levelUp:
        return Icons.keyboard_double_arrow_up_rounded;
      case NotificationType.streakReminder:
        return Icons.local_fire_department_rounded;
      case NotificationType.rewardReceived:
        return Icons.card_giftcard_rounded;
      case NotificationType.seasonCompleted:
      case NotificationType.seasonStarted:
        return Icons.event_available_rounded;
      case NotificationType.seasonResult:
        return Icons.assessment_rounded;
      case NotificationType.liveEventStarted:
      case NotificationType.liveEventEnding:
        return Icons.bolt_rounded;
      case NotificationType.rematchRequest:
        return Icons.handshake_rounded;
      case NotificationType.announcement:
        return Icons.campaign_rounded;
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
