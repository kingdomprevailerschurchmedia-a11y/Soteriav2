import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../design_system/colors/soteria_colors.dart';

enum AvatarFrameStyle {
  none,
  standard,
  purple,
  gold,
  silver,
  bronze,
  premium,
  locked,
}

class AvatarFrame extends StatelessWidget {
  final Widget child;
  final AvatarFrameStyle style;
  final double size;
  final bool showGlow;

  const AvatarFrame({
    super.key,
    required this.child,
    this.style = AvatarFrameStyle.none,
    required this.size,
    this.showGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    if (style == AvatarFrameStyle.none) {
      return SizedBox(width: size.w, height: size.w, child: child);
    }

    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: _getBorder(),
        boxShadow: showGlow ? [_getGlow()] : null,
      ),
      child: Stack(
        children: [
          Positioned.fill(child: ClipOval(child: child)),
          if (style == AvatarFrameStyle.locked)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.5),
                ),
                child: Center(
                  child: Icon(
                    Icons.lock_rounded,
                    color: Colors.white,
                    size: (size * 0.35).w,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Border _getBorder() {
    Color color;
    double width = 2.0;

    switch (style) {
      case AvatarFrameStyle.standard:
        color = SoteriaColors.textSecondary.withValues(alpha: 0.3);
        break;
      case AvatarFrameStyle.purple:
        color = SoteriaColors.primary;
        break;
      case AvatarFrameStyle.gold:
        color = SoteriaColors.gold;
        break;
      case AvatarFrameStyle.silver:
        color = const Color(0xFFC0C0C0);
        break;
      case AvatarFrameStyle.bronze:
        color = const Color(0xFFCD7F32);
        break;
      case AvatarFrameStyle.premium:
        color = SoteriaColors.secondary;
        width = 3.0;
        break;
      case AvatarFrameStyle.locked:
        color = SoteriaColors.muted.withValues(alpha: 0.5);
        break;
      default:
        color = Colors.transparent;
    }

    return Border.all(color: color, width: width.w);
  }

  BoxShadow _getGlow() {
    Color glowColor;
    switch (style) {
      case AvatarFrameStyle.gold:
        glowColor = SoteriaColors.gold.withValues(alpha: 0.3);
        break;
      case AvatarFrameStyle.purple:
        glowColor = SoteriaColors.primary.withValues(alpha: 0.3);
        break;
      case AvatarFrameStyle.premium:
        glowColor = SoteriaColors.secondary.withValues(alpha: 0.3);
        break;
      default:
        glowColor = SoteriaColors.primary.withValues(alpha: 0.2);
    }

    return BoxShadow(color: glowColor, blurRadius: 12.w, spreadRadius: 2.w);
  }
}
