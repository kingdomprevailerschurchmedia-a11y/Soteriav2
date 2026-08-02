import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_type.dart';
import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_status.dart';

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

    Color iconColor = SoteriaColors.primary;
    double opacity = 0.08;

    if (isUsed) {
      iconColor = SoteriaColors.muted;
      opacity = 0.03;
    } else if (!isAvailable) {
      iconColor = SoteriaColors.muted.withValues(alpha: 0.5);
      opacity = 0.02;
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
              GlassSurface(
                borderRadius: SoteriaRadius.brFull,
                opacity: opacity,
                padding: EdgeInsets.all(12.w),
                child: Icon(_getIcon(type), color: iconColor, size: 24.w),
              ),
              if (isUsed)
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Container(
                    width: 4.w,
                    height: 4.w,
                    decoration: const BoxDecoration(
                      color: SoteriaColors.muted,
                      shape: BoxShape.circle,
                    ),
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
        return Icons.pause_circle_outline_rounded;
      case LifelineType.askAudience:
        return Icons.groups_rounded;
    }
  }

  String _getLabel(LifelineType type) {
    switch (type) {
      case LifelineType.fiftyFifty:
        return '50/50';
      case LifelineType.pauseTimer:
        return 'Pause Timer';
      case LifelineType.askAudience:
        return 'Ask the Audience';
    }
  }
}
