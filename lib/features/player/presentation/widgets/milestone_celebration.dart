import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../domain/models/milestone.dart';

class MilestoneCelebration extends StatelessWidget {
  final MilestoneDefinition definition;
  final VoidCallback onContinue;

  const MilestoneCelebration({
    super.key,
    required this.definition,
    required this.onContinue,
  });

  static Future<void> show(
    BuildContext context, {
    required MilestoneDefinition definition,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Milestone Celebration',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: SoteriaAnimations.slow,
      pageBuilder: (context, anim1, anim2) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: MilestoneCelebration(
          definition: definition,
          onContinue: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: SoteriaAnimations.slow,
      curve: SoteriaAnimations.bounce,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(SoteriaSpacing.xl),
          child: GlassSurface(
            borderRadius: BorderRadius.circular(32.r),
            padding: EdgeInsets.symmetric(
              vertical: SoteriaSpacing.xxl,
              horizontal: SoteriaSpacing.xl,
            ),
            opacity: 0.1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'MILESTONE REACHED',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.gold,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: SoteriaSpacing.xl),
                Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: SoteriaColors.gold.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: SoteriaColors.gold.withValues(alpha: 0.2),
                    ),
                  ),
                  child: (definition.id == 'first_game' ||
                          definition.id == 'welcome_bonus')
                      ? Center(
                          child: Image.asset(
                            definition.id == 'first_game'
                                ? 'assets/icons/first_step_icon.png'
                                : 'assets/icons/star_icon.png',
                            width: 48.w,
                            height: 48.w,
                            fit: BoxFit.contain,
                          ),
                        )
                      : Icon(
                          _getIconData(definition.icon),
                          color: SoteriaColors.gold,
                          size: 48.sp,
                        ),
                ),
                SizedBox(height: SoteriaSpacing.xxl),
                Text(
                  definition.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: context.headlineSmall.copyWith(
                    color: SoteriaColors.textPrimary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: SoteriaSpacing.md),
                Text(
                  definition.description,
                  textAlign: TextAlign.center,
                  style: context.bodyMedium.copyWith(
                    color: SoteriaColors.textSecondary,
                  ),
                ),
                if (definition.rewardAmount != null) ...[
                  SizedBox(height: SoteriaSpacing.xxl),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SoteriaSpacing.xl,
                      vertical: SoteriaSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: SoteriaColors.surface,
                      borderRadius: BorderRadius.circular(SoteriaSpacing.md),
                      border: Border.all(color: SoteriaColors.border),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'REWARD',
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.muted,
                          ),
                        ),
                        Text(
                          '+${definition.rewardAmount} ${definition.rewardType?.name.toUpperCase()}',
                          style: context.titleLarge.copyWith(
                            color: SoteriaColors.gold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: SoteriaSpacing.xxxl),
                SoteriaButton.primary(
                  label: 'CONTINUE',
                  onPressed: onContinue,
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String? iconName) {
    switch (iconName) {
      case 'stars_rounded':
        return Icons.stars_rounded;
      case 'emoji_events_rounded':
        return Icons.emoji_events_rounded;
      case 'military_tech_rounded':
        return Icons.military_tech_rounded;
      case 'workspace_premium_rounded':
        return Icons.workspace_premium_rounded;
      case 'diamond_rounded':
        return Icons.diamond_rounded;
      case 'public_rounded':
        return Icons.public_rounded;
      case 'auto_awesome_rounded':
        return Icons.auto_awesome_rounded;
      default:
        return Icons.emoji_events_rounded;
    }
  }
}
