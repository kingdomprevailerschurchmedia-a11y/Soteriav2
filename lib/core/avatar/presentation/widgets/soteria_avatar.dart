import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../design_system/colors/soteria_colors.dart';
import '../../domain/avatar.dart';
import '../../providers/avatar_providers.dart';
import 'avatar_frame.dart';

class SoteriaAvatar extends ConsumerWidget {
  final Avatar? avatar;
  final String? imageUrl;
  final String? initials;
  final double size;
  final AvatarFrameStyle? frameStyle;
  final int? rank;
  final bool isOnline;
  final bool showGlow;
  final bool isSelected;
  final bool hasBorder;

  const SoteriaAvatar({
    super.key,
    this.avatar,
    this.imageUrl,
    this.initials,
    required this.size,
    this.frameStyle,
    this.rank,
    this.isOnline = false,
    this.showGlow = false,
    this.isSelected = false,
    this.hasBorder = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasImageUrl = imageUrl != null && imageUrl!.isNotEmpty;
    final hasInitials = initials != null && initials!.isNotEmpty;

    final effectiveAvatar =
        avatar ??
        (hasImageUrl || hasInitials
            ? null
            : ref.watch(selectedAvatarProvider));

    AvatarFrameStyle effectiveFrameStyle = frameStyle ?? AvatarFrameStyle.none;
    if (frameStyle == null && rank != null) {
      if (rank == 1) {
        effectiveFrameStyle = AvatarFrameStyle.gold;
      } else if (rank == 2) {
        effectiveFrameStyle = AvatarFrameStyle.silver;
      } else if (rank == 3) {
        effectiveFrameStyle = AvatarFrameStyle.bronze;
      }
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AvatarFrame(
          size: size,
          style: effectiveFrameStyle,
          showGlow: showGlow,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  (isSelected ||
                      (hasBorder &&
                          effectiveFrameStyle == AvatarFrameStyle.none))
                  ? Border.all(
                      color: isSelected
                          ? Colors.white
                          : SoteriaColors.primary.withValues(alpha: 0.2),
                      width: 2.w,
                    )
                  : null,
            ),
            child: ClipOval(
              child: _buildAvatarContent(context, effectiveAvatar),
            ),
          ),
        ),
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: (size * 0.25).w,
              height: (size * 0.25).w,
              decoration: BoxDecoration(
                color: SoteriaColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: SoteriaColors.background, width: 2.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4.w,
                    offset: Offset(0, 2.w),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAvatarContent(BuildContext context, Avatar? avatar) {
    if (avatar != null) {
      return Image.asset(
        avatar.assetPath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }

    if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }

    if (initials != null) {
      return Container(
        color: SoteriaColors.surface,
        alignment: Alignment.center,
        child: Text(
          initials!.toUpperCase(),
          style: TextStyle(
            color: SoteriaColors.textPrimary,
            fontSize: (size * 0.4).sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: SoteriaColors.surface,
      child: Icon(
        Icons.person_rounded,
        size: (size * 0.6).w,
        color: SoteriaColors.muted,
      ),
    );
  }
}
