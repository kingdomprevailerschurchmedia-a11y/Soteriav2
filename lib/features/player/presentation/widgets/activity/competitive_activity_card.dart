import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../../domain/models/competitive_activity_event.dart';
import '../../../domain/models/competitive_event.dart';

class CompetitiveActivityCard extends StatelessWidget {
  final CompetitiveActivityEvent event;
  final bool isLast;
  final VoidCallback? onTap;

  const CompetitiveActivityCard({
    super.key,
    required this.event,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getImportanceColor();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimeline(context, color),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: SoteriaSpacing.lg),
              child: SoteriaCard(
                onTap: onTap,
                hasGlow: event.importance == ActivityImportance.milestone,
                glowColor: SoteriaColors.gold,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildTypeIcon(color),
                        SizedBox(width: SoteriaSpacing.sm),
                        Expanded(
                          child: Text(
                            event.title,
                            style: context.titleSmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  event.importance ==
                                      ActivityImportance.milestone
                                  ? SoteriaColors.gold
                                  : SoteriaColors.textPrimary,
                            ),
                          ),
                        ),
                        Text(
                          _formatDate(event.createdAt),
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.muted,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SoteriaSpacing.xs),
                    Text(
                      event.description,
                      style: context.bodyMedium.copyWith(color: Colors.white70),
                    ),
                    if (event.seasonId != null) ...[
                      SizedBox(height: SoteriaSpacing.sm),
                      _buildSeasonBadge(context),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, Color color) {
    return Column(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          margin: EdgeInsets.only(top: 16.h),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 8),
            ],
          ),
        ),
        if (!isLast)
          Expanded(
            child: Container(
              width: 2.w,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
      ],
    );
  }

  Widget _buildTypeIcon(Color color) {
    return Icon(_getIconData(), color: color, size: 16.sp);
  }

  Widget _buildSeasonBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'SEASON ${event.seasonId?.split('_').last.toUpperCase() ?? 'ACTIVE'}',
        style: context.labelSmall.copyWith(
          color: SoteriaColors.muted,
          fontSize: 8.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getImportanceColor() {
    switch (event.importance) {
      case ActivityImportance.milestone:
        return SoteriaColors.gold;
      case ActivityImportance.high:
        return SoteriaColors.primary;
      case ActivityImportance.normal:
        return SoteriaColors.secondary;
      case ActivityImportance.low:
        return SoteriaColors.muted;
    }
  }

  IconData _getIconData() {
    switch (event.type) {
      case CompetitiveEventType.rankPromoted:
        return Icons.trending_up_rounded;
      case CompetitiveEventType.rankDemoted:
        return Icons.trending_down_rounded;
      case CompetitiveEventType.rankReached:
        return Icons.military_tech_rounded;
      case CompetitiveEventType.milestoneCompleted:
      case CompetitiveEventType.achievementUnlocked:
        return Icons.auto_awesome_rounded;
      case CompetitiveEventType.rewardReceived:
        return Icons.card_giftcard_rounded;
      case CompetitiveEventType.seasonCompleted:
        return Icons.event_available_rounded;
      case CompetitiveEventType.seasonStarted:
        return Icons.event_note_rounded;
      case CompetitiveEventType.personalBest:
        return Icons.star_rounded;
      case CompetitiveEventType.leaderboardMilestone:
        return Icons.public_rounded;
      default:
        return Icons.stars_rounded;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return '${date.day}/${date.month}';
  }
}
