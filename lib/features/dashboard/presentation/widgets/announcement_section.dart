import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';

class AnnouncementSection extends StatelessWidget {
  const AnnouncementSection({super.key, required this.announcements});

  final List<String> announcements;

  @override
  Widget build(BuildContext context) {
    if (announcements.isEmpty) return const SizedBox.shrink();

    return SoteriaCard(
      padding: EdgeInsets.zero,
      borderRadius: SoteriaRadius.xxl,
      child: Column(
        children: List.generate(announcements.length, (index) {
          final isLast = index == announcements.length - 1;
          return Column(
            children: [
              _AnnouncementItem(message: announcements[index]),
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.white.withValues(alpha: 0.05),
                  indent: 72.w,
                  endIndent: SoteriaSpacing.lg,
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _AnnouncementItem extends StatelessWidget {
  const _AnnouncementItem({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final parts = message.split(': ');
    final String title = parts.length > 1 ? parts[0] : 'Notification';
    final String subtitle = parts.length > 1
        ? parts.sublist(1).join(': ')
        : message;

    return InkWell(
      onTap: () {},
      borderRadius: SoteriaRadius.brXxl,
      child: Padding(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: SoteriaColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: SoteriaColors.primary.withValues(alpha: 0.1),
                ),
              ),
              child: Icon(
                Icons.notifications_active_rounded,
                color: SoteriaColors.primary,
                size: 24.sp,
              ),
            ),
            SizedBox(width: SoteriaSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      color: SoteriaColors.textPrimary,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: SoteriaSpacing.md),
            Icon(
              Icons.chevron_right_rounded,
              color: SoteriaColors.muted.withValues(alpha: 0.4),
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
