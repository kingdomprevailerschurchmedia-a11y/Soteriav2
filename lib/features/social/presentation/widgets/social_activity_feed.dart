import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../domain/models/social_activity_event.dart';
import 'package:timeago/timeago.dart' as timeago;

class SocialActivityFeed extends ConsumerWidget {
  final List<SocialActivityEvent> activities;

  const SocialActivityFeed({super.key, required this.activities});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (activities.isEmpty) {
      return Center(
        child: Text(
          'No recent competitive activity.',
          style: context.bodySmall.copyWith(color: SoteriaColors.muted),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return _ActivityCard(event: activities[index]);
      },
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final SocialActivityEvent event;

  const _ActivityCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: GlassSurface(
        borderRadius: BorderRadius.circular(12.r),
        opacity: 0.05,
        padding: EdgeInsets.all(SoteriaSpacing.md),
        child: Row(
          children: [
            _buildIcon(),
            SizedBox(width: SoteriaSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.message,
                    style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    timeago.format(event.createdAt),
                    style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData icon;
    Color color;

    switch (event.type) {
      case SocialActivityType.friendAdded:
        icon = Icons.person_add_rounded;
        color = SoteriaColors.primary;
        break;
      case SocialActivityType.friendRankUp:
        icon = Icons.trending_up_rounded;
        color = SoteriaColors.success;
        break;
      case SocialActivityType.friendAchievement:
        icon = Icons.emoji_events_rounded;
        color = SoteriaColors.gold;
        break;
      case SocialActivityType.rivalryMilestone:
        icon = Icons.whatshot_rounded;
        color = SoteriaColors.primary;
        break;
      case SocialActivityType.overtake:
        icon = Icons.double_arrow_rounded;
        color = SoteriaColors.xpColor;
        break;
    }

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20.w),
    );
  }
}
