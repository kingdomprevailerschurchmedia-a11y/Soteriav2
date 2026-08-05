import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';

class SoteriaAvatar extends StatelessWidget {
  final String? url;
  final double size;
  final bool isOnline;
  final bool hasBorder;

  const SoteriaAvatar({
    super.key,
    this.url,
    this.size = 48.0,
    this.isOnline = false,
    this.hasBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size.w,
          height: size.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: hasBorder
                ? Border.all(
                    color: SoteriaColors.primary.withValues(alpha: 0.2),
                    width: 2,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: url != null
                ? Image.network(
                    url!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildPlaceholder(),
                  )
                : _buildPlaceholder(),
          ),
        ),
        if (isOnline)
          Positioned(
            right: 2.w,
            bottom: 2.w,
            child: Container(
              width: (size * 0.25).w,
              height: (size * 0.25).w,
              decoration: BoxDecoration(
                color: SoteriaColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: SoteriaColors.background, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: SoteriaColors.surface,
      child: Icon(
        Icons.person_rounded,
        color: SoteriaColors.muted,
        size: (size * 0.6).sp,
      ),
    );
  }
}
