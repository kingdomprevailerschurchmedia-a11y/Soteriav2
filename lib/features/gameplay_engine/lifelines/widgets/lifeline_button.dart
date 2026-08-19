import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_type.dart';
import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_status.dart';

import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';

class LifelineButton extends StatelessWidget {
  const LifelineButton({
    super.key,
    required this.type,
    required this.onTap,
    this.status = LifelineStatus.available,
  });

  final LifelineType type;
  final VoidCallback onTap;
  final LifelineStatus status;

  @override
  Widget build(BuildContext context) {
    final isUsed = status == LifelineStatus.used;
    final isAvailable = status == LifelineStatus.available;

    Color iconColor = Colors.white;
    Color glowColor = SoteriaColors.secondary.withValues(alpha: 0.3);
    double opacity = 0.12;

    if (isUsed) {
      iconColor = SoteriaColors.muted;
      opacity = 0.05;
      glowColor = Colors.transparent;
    } else if (!isAvailable) {
      iconColor = SoteriaColors.muted.withValues(alpha: 0.5);
      opacity = 0.03;
      glowColor = Colors.transparent;
    }

    return Semantics(
      button: true,
      enabled: isAvailable,
      label: 'Lifeline: ${_getLabel(type)}',
      child: GestureDetector(
        onTap: isAvailable ? onTap : null,
        child: AnimatedScale(
          duration: SoteriaAnimations.fast,
          scale: isAvailable ? 1.0 : 0.95,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    if (isAvailable)
                      BoxShadow(
                        color: glowColor,
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                child: GlassSurface(
                  borderRadius: SoteriaRadius.brFull,
                  opacity: opacity,
                  padding: EdgeInsets.all(16.w),
                  border: Border.all(
                    color: isAvailable
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.05),
                    width: 1,
                  ),
                  child: Icon(_getIcon(type), color: iconColor, size: 28.w),
                ),
              ),
              SizedBox(height: SoteriaSpacing.xs),
              Text(
                _getLabel(type),
                style: context.labelSmall.copyWith(
                  color: isAvailable ? SoteriaColors.textSecondary : SoteriaColors.muted,
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(LifelineType type) {
    switch (type) {
      case LifelineType.fiftyFifty:
        return Icons.exposure_minus_2_rounded;
      case LifelineType.pauseTimer:
        return Icons.pause_rounded;
      case LifelineType.askAudience:
        return Icons.groups_rounded;
    }
  }

  String _getLabel(LifelineType type) {
    switch (type) {
      case LifelineType.fiftyFifty:
        return 'Deduct';
      case LifelineType.pauseTimer:
        return 'Pause';
      case LifelineType.askAudience:
        return 'Ask Friend';
    }
  }
}
