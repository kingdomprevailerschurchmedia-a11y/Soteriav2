import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/models/power_up_state.dart';

class QuizPowerUpBar extends StatelessWidget {
  const QuizPowerUpBar({super.key, required this.powerUps, this.onPowerUpTap});

  final List<PowerUpState> powerUps;
  final Function(PowerUpType)? onPowerUpTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        border: const Border(top: BorderSide(color: Colors.white10)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _PowerUpItem(
              type: PowerUpType.fiftyFifty,
              icon: Icons.exposure_minus_1_rounded,
              label: '50/50',
              state: _getPowerUpState(PowerUpType.fiftyFifty),
              onTap: () => onPowerUpTap?.call(PowerUpType.fiftyFifty),
            ),
            _PowerUpItem(
              type: PowerUpType.pauseTimer,
              icon: Icons.pause_circle_rounded,
              label: 'PAUSE',
              state: _getPowerUpState(PowerUpType.pauseTimer),
              onTap: () => onPowerUpTap?.call(PowerUpType.pauseTimer),
            ),
            _PowerUpItem(
              type: PowerUpType.askAudience,
              icon: Icons.people_rounded,
              label: 'POLL',
              state: _getPowerUpState(PowerUpType.askAudience),
              onTap: () => onPowerUpTap?.call(PowerUpType.askAudience),
            ),
          ],
        ),
      ),
    );
  }

  PowerUpState? _getPowerUpState(PowerUpType type) {
    try {
      return powerUps.firstWhere((p) => p.type == type);
    } catch (_) {
      return null;
    }
  }
}

class _PowerUpItem extends StatelessWidget {
  const _PowerUpItem({
    required this.type,
    required this.icon,
    required this.label,
    required this.state,
    required this.onTap,
  });

  final PowerUpType type;
  final IconData icon;
  final String label;
  final PowerUpState? state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = state?.isAvailable ?? false;
    final bool isUsed = state?.isUsed ?? false;

    return Opacity(
      opacity: isAvailable ? 1.0 : 0.4,
      child: GestureDetector(
        onTap: isAvailable ? onTap : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 54.w,
              height: 54.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isAvailable
                    ? const LinearGradient(
                        colors: [
                          SoteriaColors.secondary,
                          SoteriaColors.primary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: !isAvailable ? Colors.white12 : null,
                border: Border.all(
                  color: isUsed ? SoteriaColors.gold : Colors.white24,
                  width: 2,
                ),
                boxShadow: isAvailable
                    ? [
                        BoxShadow(
                          color: SoteriaColors.primary.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icon,
                color: isAvailable ? Colors.white : Colors.white24,
                size: 26.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: context.labelSmall.copyWith(
                color: isAvailable ? Colors.white70 : Colors.white24,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
