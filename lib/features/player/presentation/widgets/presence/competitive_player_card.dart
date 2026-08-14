import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/avatar/data/avatar_catalog.dart';
import 'package:soteria/features/player/presentation/providers/public_profile_providers.dart';
import 'player_presence_indicator.dart';
import 'presence_label.dart';

class CompetitivePlayerCard extends ConsumerWidget {
  final String userId;
  final VoidCallback? onTap;
  final Widget? trailing;

  const CompetitivePlayerCard({
    super.key,
    required this.userId,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(publicProfileProvider(userId));

    return GlassSurface(
      onTap: onTap,
      borderRadius: BorderRadius.circular(SoteriaRadius.lg),
      padding: EdgeInsets.all(SoteriaSpacing.md),
      child: profileAsync.when(
        data: (profile) => Row(
          children: [
            Stack(
              children: [
                SoteriaAvatar(
                  avatar: AvatarCatalog().getById(profile?.avatarId ?? 'socrates'),
                  size: 48,
                  imageUrl: profile?.photoUrl,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: PlayerPresenceIndicator(userId: userId, size: 12),
                ),
              ],
            ),
            SizedBox(width: SoteriaSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile?.displayName ?? 'Competitive Player',
                    style: const TextStyle(
                      color: SoteriaColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        profile?.rankTier ?? 'Unranked',
                        style: const TextStyle(
                          color: SoteriaColors.gold,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 8),
                      PresenceLabel(userId: userId),
                    ],
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        loading: () => const _LoadingPlaceholder(),
        error: (_, __) => const _ErrorState(),
      ),
    );
  }
}

class _LoadingPlaceholder extends StatelessWidget {
  const _LoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 24.r, backgroundColor: Colors.white.withValues(alpha: 0.05)),
        SizedBox(width: SoteriaSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 12.h, width: 100.w, color: Colors.white.withValues(alpha: 0.05)),
              const SizedBox(height: 4),
              Container(height: 10.h, width: 60.w, color: Colors.white.withValues(alpha: 0.05)),
            ],
          ),
        ),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.error_outline, color: SoteriaColors.error));
  }
}
