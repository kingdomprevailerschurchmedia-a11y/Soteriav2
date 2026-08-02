import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/widgets/buttons/soteria_button.dart';

class DailyChallengeCard extends StatelessWidget {
  const DailyChallengeCard({
    super.key,
    required this.title,
    required this.description,
    required this.xpReward,
    required this.progress,
  });

  final String title;
  final String description;
  final int xpReward;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: GlassSurface(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        borderRadius: BorderRadius.circular(24),
        opacity: 0.06,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      color: SoteriaColors.gold,
                      size: 16,
                    ),
                    SizedBox(width: SoteriaSpacing.xs),
                    Text(
                      'DAILY CHALLENGE',
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.gold,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  '+$xpReward XP',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              title,
              style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: SoteriaSpacing.xs),
            Text(
              description,
              style: context.bodySmall.copyWith(color: SoteriaColors.muted),
            ),
            SizedBox(height: SoteriaSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: Colors.white.withValues(alpha: 0.05),
                      valueColor: const AlwaysStoppedAnimation(
                        SoteriaColors.gold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: SoteriaSpacing.lg),
                SoteriaButton.primary(
                  label: 'START',
                  onPressed: () {},
                  fullWidth: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
