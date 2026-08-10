import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/models/power_up_state.dart';

class QuizPowerUpBar extends StatelessWidget {
  const QuizPowerUpBar({
    super.key,
    required this.powerUps,
    this.onPowerUpTap,
    this.isLocked = false,
  });

  final List<PowerUpState> powerUps;
  final Function(PowerUpType)? onPowerUpTap;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.lg,
        vertical: SoteriaSpacing.md,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _PowerUpItem(
              type: PowerUpType.fiftyFifty,
              icon: Icons.exposure_minus_1_rounded,
              label: '50/50',
              state: _getPowerUpState(PowerUpType.fiftyFifty),
              onTap: () => _handleTap(context, PowerUpType.fiftyFifty),
              isLocked: isLocked,
            ),
            _PowerUpItem(
              type: PowerUpType.pauseTimer,
              icon: Icons.pause_circle_outline_rounded,
              label: 'PAUSE',
              state: _getPowerUpState(PowerUpType.pauseTimer),
              onTap: () => _handleTap(context, PowerUpType.pauseTimer),
              isLocked: isLocked,
            ),
            _PowerUpItem(
              type: PowerUpType.askAudience,
              icon: Icons.people_outline_rounded,
              label: 'POLL',
              state: _getPowerUpState(PowerUpType.askAudience),
              onTap: () => _handleTap(context, PowerUpType.askAudience),
              isLocked: isLocked,
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(BuildContext context, PowerUpType type) {
    final state = _getPowerUpState(type);
    if (state?.status == PowerUpStatus.available && !isLocked) {
      HapticFeedback.mediumImpact();
      onPowerUpTap?.call(type);
    } else if (!isLocked) {
      HapticFeedback.heavyImpact();
    }
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
    this.isLocked = false,
  });

  final PowerUpType type;
  final IconData icon;
  final String label;
  final PowerUpState? state;
  final VoidCallback onTap;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    final status = state?.status ?? PowerUpStatus.disabled;
    final bool isAvailable = status == PowerUpStatus.available && !isLocked;
    final bool isUsed = status == PowerUpStatus.used;
    final bool isActivating = status == PowerUpStatus.activating;

    String semanticLabel = label;
    if (isUsed) semanticLabel += ', used';
    if (isAvailable) semanticLabel += ', available';
    if (isLocked) semanticLabel += ', disabled';

    return Semantics(
      label: semanticLabel,
      button: isAvailable,
      enabled: isAvailable,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: SoteriaAnimations.normal,
                  width: 52.w,
                  height: 52.w,
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
                    color: !isAvailable
                        ? Colors.white.withValues(alpha: 0.05)
                        : null,
                    border: Border.all(
                      color: isUsed
                          ? SoteriaColors.gold.withValues(alpha: 0.5)
                          : (isAvailable
                                ? Colors.white30
                                : Colors.white.withValues(alpha: 0.05)),
                      width: 1.5,
                    ),
                    boxShadow: isAvailable
                        ? [
                            BoxShadow(
                              color: SoteriaColors.primary.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    isActivating ? Icons.sync : (isUsed ? Icons.check : icon),
                    color: isAvailable
                        ? Colors.white
                        : (isUsed
                              ? SoteriaColors.gold
                              : Colors.white.withValues(alpha: 0.2)),
                    size: 24.sp,
                  ),
                ),
                if (isActivating)
                  SizedBox(
                    width: 52.w,
                    height: 52.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: context.labelSmall.copyWith(
                color: isAvailable
                    ? Colors.white70
                    : (isUsed ? SoteriaColors.gold : Colors.white24),
                fontSize: 9.sp,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
