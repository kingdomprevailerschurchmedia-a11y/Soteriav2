import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/widgets/buttons/soteria_button.dart';

class DailyChallengeCard extends StatelessWidget {
  const DailyChallengeCard({
    super.key,
    required this.title,
    required this.description,
    required this.xpReward,
    required this.progress,
    this.difficulty = 'Normal',
    this.duration = '5m',
    this.isCompleted = false,
  });

  final String title;
  final String description;
  final int xpReward;
  final double progress;
  final String difficulty;
  final String duration;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Daily Challenge: $title. Reward: $xpReward XP. ${isCompleted ? "Completed" : "In Progress"}',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
        child: GlassSurface(
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          borderRadius: BorderRadius.circular(SoteriaRadius.xl),
          opacity: isCompleted ? 0.03 : 0.06,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        isCompleted ? Icons.check_circle_rounded : Icons.calendar_today_rounded,
                        color: isCompleted ? Colors.greenAccent : SoteriaColors.gold,
                        size: 16,
                      ),
                      SizedBox(width: SoteriaSpacing.xs),
                      Text(
                        isCompleted ? 'CHALLENGE COMPLETED' : 'DAILY CHALLENGE',
                        style: context.labelSmall.copyWith(
                          color: isCompleted ? Colors.greenAccent : SoteriaColors.gold,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (!isCompleted)
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
                style: context.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isCompleted ? Colors.white38 : Colors.white,
                ),
              ),
              SizedBox(height: SoteriaSpacing.xs),
              Row(
                children: [
                  _Badge(label: difficulty, color: SoteriaColors.gold),
                  SizedBox(width: SoteriaSpacing.sm),
                  _Badge(label: duration, color: SoteriaColors.muted),
                  const Spacer(),
                  if (!isCompleted)
                    Text(
                      'Ends at midnight',
                      style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                    ),
                ],
              ),
              SizedBox(height: SoteriaSpacing.lg),
              if (isCompleted)
                Text(
                  'Next challenge available tomorrow.',
                  style: context.bodySmall.copyWith(color: SoteriaColors.muted),
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(SoteriaRadius.xs),
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
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(SoteriaRadius.xs),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
