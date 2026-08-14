import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../../../../core/design_system/gradients/soteria_gradients.dart';
import '../../../../../core/widgets/glass_surface.dart';
import '../../../domain/models/competitive_activity_event.dart';
import '../../../domain/models/competitive_event.dart';
import 'package:intl/intl.dart';

import 'package:soteria/features/player/presentation/providers/public_profile_providers.dart';
import '../presence/player_presence_indicator.dart';
import '../../../../auth/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompetitiveActivityCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final color = _getImportanceColor();
    final currentUserId = ref.watch(authRepositoryProvider).currentUserId;
    final isMe = event.userId == currentUserId;
    final profileAsync = ref.watch(publicProfileProvider(event.userId));

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimeline(context, color),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: SoteriaSpacing.lg),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SoteriaRadius.lg),
                  gradient: event.importance == ActivityImportance.milestone
                      ? SoteriaGradients.settingsCardBorder
                      : null,
                ),
                padding: event.importance == ActivityImportance.milestone
                    ? const EdgeInsets.all(1.5)
                    : EdgeInsets.zero,
                child: GlassSurface(
                  onTap: onTap,
                  opacity: event.importance == ActivityImportance.milestone ? 0.15 : 0.05,
                  borderRadius: BorderRadius.circular(
                    event.importance == ActivityImportance.milestone
                        ? SoteriaRadius.lg - 1.5
                        : SoteriaRadius.lg,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(SoteriaSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            profileAsync.when(
                              data: (profile) => Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  CircleAvatar(
                                    radius: 18.r,
                                    backgroundColor: SoteriaColors.surface,
                                    backgroundImage: profile?.photoUrl != null 
                                      ? NetworkImage(profile!.photoUrl!) 
                                      : null,
                                    child: profile?.photoUrl == null 
                                      ? Icon(Icons.person, color: SoteriaColors.muted, size: 20.sp)
                                      : null,
                                  ),
                                  Positioned(
                                    right: -2,
                                    bottom: -2,
                                    child: PlayerPresenceIndicator(userId: event.userId, size: 10),
                                  ),
                                ],
                              ),
                              loading: () => CircleAvatar(radius: 18.r, backgroundColor: SoteriaColors.surface),
                              error: (_, __) => CircleAvatar(radius: 18.r, backgroundColor: SoteriaColors.surface),
                            ),
                            SizedBox(width: SoteriaSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      profileAsync.when(
                                        data: (profile) => Text(
                                          isMe ? 'YOU' : (profile?.displayName ?? 'Player'),
                                          style: context.labelSmall.copyWith(
                                            color: isMe ? SoteriaColors.primary : SoteriaColors.muted,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        loading: () => const Text('...'),
                                        error: (_, __) => const Text('Player'),
                                      ),
                                      const Spacer(),
                                      Text(
                                        _formatRelativeDate(event.createdAt),
                                        style: context.labelSmall.copyWith(
                                          color: SoteriaColors.muted.withValues(alpha: 0.5),
                                          fontSize: 9.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    event.title,
                                    style: context.titleSmall.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: event.importance == ActivityImportance.milestone
                                          ? SoteriaColors.gold
                                          : SoteriaColors.textPrimary,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SoteriaSpacing.md),
                        Text(
                          event.description,
                          style: context.bodyMedium.copyWith(
                            color: Colors.white.withValues(alpha: 0.7),
                            height: 1.4,
                          ),
                        ),
                        if (event.metadata.isNotEmpty) ...[
                          SizedBox(height: SoteriaSpacing.md),
                          _buildMetadataDisplay(context),
                        ],
                        if (event.seasonId != null) ...[
                          SizedBox(height: SoteriaSpacing.md),
                          _buildSeasonBadge(context),
                        ],
                      ],
                    ),
                  ),
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
          width: 14.w,
          height: 14.w,
          margin: EdgeInsets.only(top: 20.h),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: color.withValues(alpha: 0.2),
              width: 3.w,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        if (!isLast)
          Expanded(
            child: Container(
              width: 2.w,
              margin: EdgeInsets.symmetric(vertical: 4.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    color.withValues(alpha: 0.3),
                    Colors.white.withValues(alpha: 0.02),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTypeIcon(Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(_getIconData(), color: color, size: 18.sp),
    );
  }

  Widget _buildMetadataDisplay(BuildContext context) {
    if (event.type == CompetitiveEventType.rankPromoted ||
        event.type == CompetitiveEventType.rankDemoted) {
      final rank = event.metadata['rank'] as String?;
      if (rank == null) return const SizedBox.shrink();
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: SoteriaColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: SoteriaColors.primary.withValues(alpha: 0.2)),
        ),
        child: Text(
          rank.toUpperCase(),
          style: context.labelSmall.copyWith(
            color: SoteriaColors.secondary,
            fontWeight: FontWeight.w900,
            fontSize: 10.sp,
          ),
        ),
      );
    }

    if (event.type == CompetitiveEventType.streakReached) {
      final streak = event.metadata['streak'];
      return Row(
        children: [
          Icon(Icons.local_fire_department_rounded, color: SoteriaColors.error, size: 16.sp),
          SizedBox(width: 4.w),
          Text(
            '$streak MATCH STREAK',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.error,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
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
      case CompetitiveEventType.badgeEarned:
        return Icons.verified_rounded;
      case CompetitiveEventType.titleEarned:
        return Icons.title_rounded;
      case CompetitiveEventType.tournamentResult:
        return Icons.emoji_events_rounded;
      case CompetitiveEventType.matchCompleted:
        return Icons.check_circle_outline_rounded;
      case CompetitiveEventType.streakReached:
        return Icons.local_fire_department_rounded;
      default:
        return Icons.stars_rounded;
    }
  }

  String _formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return DateFormat('MMM d').format(date);
  }
}
