import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_progress_bar.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../domain/models/player_progression.dart';
import 'rank_badge.dart';

class PlayerProgressionCard extends StatelessWidget {
  final PlayerProgression progression;
  final String? avatarUrl;
  final String displayName;

  const PlayerProgressionCard({
    super.key,
    required this.progression,
    this.avatarUrl,
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: SoteriaGradients.settingsCardBorder,
      ),
      padding: const EdgeInsets.all(1.5),
      child: GlassSurface(
        borderRadius: BorderRadius.circular(27),
        opacity: 0.1,
        padding: EdgeInsets.all(20.w),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: _ProgressBarSection(
                  icon: Icons.stars_rounded,
                  label: 'XP PROGRESS',
                  value: '${progression.currentXp} / ${progression.xpRequiredForNextLevel} XP',
                  progress: progression.xpProgress,
                  color: const Color(0xFF7C4DFF),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: VerticalDivider(
                  color: Colors.white.withValues(alpha: 0.1),
                  thickness: 1,
                  width: 1,
                ),
              ),
              Expanded(
                child: _ProgressBarSection(
                  icon: Icons.emoji_events_rounded,
                  label: 'RANK PROGRESS',
                  value: '${(progression.rankProgress * 100).toInt()}%',
                  progress: progression.rankProgress,
                  color: SoteriaColors.gold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressBarSection extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double progress;
  final Color color;

  const _ProgressBarSection({
    required this.icon,
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: context.labelSmall.copyWith(
                color: SoteriaColors.textSecondary,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          value,
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        SizedBox(height: 12.h),
        SoteriaProgressBar(
          progress: progress,
          color: color.withValues(alpha: 0.3),
          height: 8,
        ),
      ],
    );
  }
}
