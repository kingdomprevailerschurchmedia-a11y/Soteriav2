import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../design_system/colors/soteria_colors.dart';
import '../../domain/avatar.dart';
import '../../providers/avatar_providers.dart';
import '../../../identity/providers/identity_providers.dart';
import '../../../../features/player/providers/player_providers.dart';
import 'avatar_frame.dart';

class SoteriaAvatar extends ConsumerWidget {
  final Avatar? avatar;
  final String? imageUrl;
  final String? initials;
  final double size;
  final AvatarFrameStyle? frameStyle;
  final int? rank;
  final bool isOnline;
  final bool showStatus;
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
    this.showStatus = false,
    this.showGlow = false,
    this.isSelected = false,
    this.hasBorder = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final player = ref.watch(currentPlayerProvider);

    final bool hasProvidedImageUrl = imageUrl?.isNotEmpty ?? false;
    final bool hasProvidedAvatar = avatar != null;
    final bool hasProvidedInitials = initials?.isNotEmpty ?? false;

    // We only fallback to the current user's profile/player image if NO other source is provided.
    // This prevents the current user's Google image from overriding other users' preset avatars in lists.
    String? effectiveImageUrl;
    if (hasProvidedImageUrl) {
      effectiveImageUrl = imageUrl;
    } else if (!hasProvidedAvatar && !hasProvidedInitials) {
      final profileUrl = profile?.avatarUrl;
      final profileAvatar = profile?.selectedAvatarId;
      final playerUrl = player?.photoUrl;

      // Priority logic:
      // 1. If we have a custom profile photo (from identity), show it.
      // 2. If we have a selected avatar ID in identity, don't show any photo (show the avatar instead).
      // 3. Fallback to player photo (from gameplay).
      if (profileUrl != null && profileUrl.isNotEmpty) {
        effectiveImageUrl = profileUrl;
      } else if (profileAvatar != null && profileAvatar.isNotEmpty) {
        effectiveImageUrl = null;
      } else if (playerUrl != null && playerUrl.isNotEmpty) {
        effectiveImageUrl = playerUrl;
      }
    }

    final hasEffectiveImageUrl =
        effectiveImageUrl != null && effectiveImageUrl.isNotEmpty;

    // Use the provided avatar, or if we don't have an image, get the globally selected one.
    final effectiveAvatar = avatar ??
        (hasEffectiveImageUrl || hasProvidedInitials
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
              child: _buildAvatarContent(context, effectiveAvatar, effectiveImageUrl),
            ),
          ),
        ),
        if (showStatus || isOnline)
          Positioned(
            right: 2.w,
            bottom: 2.w,
            child: Container(
              width: (size * 0.24).w,
              height: (size * 0.24).w,
              decoration: BoxDecoration(
                color: isOnline ? SoteriaColors.success : SoteriaColors.muted,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF0B012A), // Dark separator border
                  width: 1.5.w,
                ),
                boxShadow: [
                  if (isOnline)
                    BoxShadow(
                      color: SoteriaColors.success.withValues(alpha: 0.4),
                      blurRadius: 6.w,
                      spreadRadius: 1.w,
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAvatarContent(
    BuildContext context,
    Avatar? avatar,
    String? effectiveImageUrl,
  ) {
    if (effectiveImageUrl != null && effectiveImageUrl.isNotEmpty) {
      return Image.network(
        effectiveImageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }

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
