import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:confetti/confetti.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/widgets/glass_surface.dart';

class StreakCelebrationDialog extends StatefulWidget {
  final int streakDays;
  final int coinReward;
  final VoidCallback onDismiss;

  const StreakCelebrationDialog({
    super.key,
    required this.streakDays,
    required this.coinReward,
    required this.onDismiss,
  });

  @override
  State<StreakCelebrationDialog> createState() => _StreakCelebrationDialogState();
}

class _StreakCelebrationDialogState extends State<StreakCelebrationDialog> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              SoteriaColors.gold,
              SoteriaColors.primary,
              SoteriaColors.secondary,
              Colors.white,
            ],
          ),
          GlassSurface(
            padding: EdgeInsets.all(32.r),
            borderRadius: BorderRadius.circular(32.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: SoteriaColors.gold.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.local_fire_department_rounded,
                    color: SoteriaColors.gold,
                    size: 64.sp,
                  ),
                ),
                SoteriaSpacing.gapLG,
                Text(
                  '${widget.streakDays} DAY STREAK!',
                  style: context.headlineMedium.copyWith(
                    fontWeight: FontWeight.w900,
                    color: SoteriaColors.gold,
                    letterSpacing: 1,
                  ),
                ),
                SoteriaSpacing.gapSM,
                Text(
                  'UNSTOPPABLE!',
                  style: context.titleSmall.copyWith(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                SoteriaSpacing.gapLG,
                Text(
                  'Your consistency is paying off. Keep it up to reach even higher milestones!',
                  textAlign: TextAlign.center,
                  style: context.bodyMedium.copyWith(color: Colors.white60),
                ),
                SoteriaSpacing.gapXL,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/coin_icon.png',
                        width: 24.sp,
                        height: 24.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        '+${widget.coinReward} COINS',
                        style: context.titleMedium.copyWith(
                          color: SoteriaColors.gold,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SoteriaSpacing.xxl),
                SoteriaButton(
                  label: 'CLAIM REWARD',
                  onPressed: widget.onDismiss,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
