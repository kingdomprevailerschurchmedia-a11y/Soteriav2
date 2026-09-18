import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../design_system/colors/soteria_colors.dart';
import 'package:soteria/core/identity/models/user_profile.dart';
import '../../domain/avatar.dart';
import '../../providers/avatar_providers.dart';
import '../../../identity/providers/identity_providers.dart';
import '../../../../features/player/providers/player_providers.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';
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
    final isProfileLoading = ref.watch(profileLoadingProvider);
    final player = ref.watch(currentPlayerProvider);
    final isPlayerLoading = ref.watch(currentPlayerStreamProvider).isLoading;

    final bool hasProvidedImageUrl = imageUrl?.isNotEmpty ?? false;
    final bool hasProvidedAvatar = avatar != null;
    final bool hasProvidedInitials = initials?.isNotEmpty ?? false;

    // Show loading state if we are waiting for profile/player data and nothing else was provided
    if ((isProfileLoading || (isPlayerLoading && player == null)) && 
        !hasProvidedImageUrl && !hasProvidedAvatar && !hasProvidedInitials) {
      return _buildLoadingState();
    }

    String? effectiveImageUrl;
    String? effectiveAvatarId;

    // Smart priority: check if provided imageUrl is just a fallback from player data
    final isProvidedUrlFromPlayer = hasProvidedImageUrl && imageUrl == player?.photoUrl;

    if (hasProvidedImageUrl && (!isProvidedUrlFromPlayer || (profile?.avatarUrl == null || profile!.avatarUrl!.isEmpty))) {
      effectiveImageUrl = imageUrl;
    } else if (hasProvidedAvatar) {
      effectiveAvatarId = avatar!.id;
    } else if (hasProvidedInitials) {
      // Initials handled separately below
    } else {
      // Dynamic resolution from providers
      final profileUrl = profile?.avatarUrl;
      final profileAvatar = profile?.selectedAvatarId;
      final playerUrl = player?.photoUrl;
      final playerAvatar = player?.selectedAvatarId;

      // Priority logic:
      // 1. Explicit Custom Profile Photo (from identity profile)
      if (profileUrl != null && profileUrl.isNotEmpty) {
        effectiveImageUrl = profileUrl;
      } 
      // 2. Google Profile Photo (from player profile or auth fallback)
      else if (playerUrl != null && playerUrl.isNotEmpty) {
        effectiveImageUrl = playerUrl;
      } else {
        final authUser = ref.watch(firebaseAuthServiceProvider).currentUser;
        if (authUser?.photoURL != null && authUser!.photoURL!.isNotEmpty) {
          effectiveImageUrl = authUser.photoURL;
        }
      }
      
      // 3. Custom Selected Avatar ID (if not default)
      if (effectiveImageUrl == null) {
        if (profileAvatar != null && profileAvatar.isNotEmpty && profileAvatar != 'socrates') {
           effectiveAvatarId = profileAvatar;
        }
        // 4. Fallback to default/player avatar ID
        else if (playerAvatar != null && playerAvatar.isNotEmpty) {
          effectiveAvatarId = playerAvatar;
        }
      }
    }

    final hasEffectiveImageUrl =
        effectiveImageUrl != null && effectiveImageUrl.isNotEmpty;

    // Use the provided avatar, or resolved avatar ID, or fallback to selected avatar provider.
    final effectiveAvatar = avatar ?? 
        (effectiveAvatarId != null 
            ? ref.watch(avatarCatalogProvider).getById(effectiveAvatarId)
            : (hasEffectiveImageUrl || hasProvidedInitials
                ? null
                : ref.watch(selectedAvatarProvider)));

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
              color: (hasBorder && effectiveFrameStyle == AvatarFrameStyle.none)
                  ? Colors.white.withValues(alpha: 0.05)
                  : null,
              boxShadow: (hasBorder && effectiveFrameStyle == AvatarFrameStyle.none)
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
              border: (isSelected ||
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
              child: _buildAvatarContent(context, effectiveAvatar, effectiveImageUrl, profile),
            ),
          ),
        ),
        if (showStatus || isOnline)
          Positioned(
            right: 2.r,
            bottom: 2.r,
            child: Container(
              width: (size * 0.24).r,
              height: (size * 0.24).r,
              decoration: BoxDecoration(
                color: isOnline ? SoteriaColors.success : SoteriaColors.muted,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF0B012A), // Dark separator border
                  width: 1.5.r,
                ),
                boxShadow: [
                  if (isOnline)
                    BoxShadow(
                      color: SoteriaColors.success.withValues(alpha: 0.4),
                      blurRadius: 6.r,
                      spreadRadius: 1.r,
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
    UserProfile? profile,
  ) {
    if (effectiveImageUrl != null && effectiveImageUrl.isNotEmpty) {
      // Use updatedAt as a stable cache breaker
      String cacheBreakerUrl = effectiveImageUrl;
      final timestamp = profile?.updatedAt?.millisecondsSinceEpoch ?? 0;
      
      try {
        final Uri uri = Uri.parse(effectiveImageUrl);
        if (uri.hasQuery) {
          cacheBreakerUrl = uri.replace(
            queryParameters: {
              ...uri.queryParameters,
              'cb': timestamp.toString(),
            },
          ).toString();
        } else {
          cacheBreakerUrl = '$effectiveImageUrl?cb=$timestamp';
        }
      } catch (e) {
        // Fallback to original URL if parsing fails
      }

      return Image.network(
        cacheBreakerUrl,
        key: ValueKey(cacheBreakerUrl),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingState();
        },
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SoteriaColors.surface,
            SoteriaColors.primary.withValues(alpha: 0.2),
          ],
        ),
      ),
      child: Icon(
        Icons.person_rounded,
        size: (size * 0.6).r,
        color: SoteriaColors.muted.withValues(alpha: 0.5),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.05),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: SoteriaColors.primary,
        ),
      ),
    );
  }
}
