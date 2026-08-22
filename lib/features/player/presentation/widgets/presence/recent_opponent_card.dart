import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/avatar/data/avatar_catalog.dart';
import 'package:soteria/features/player/presentation/providers/public_profile_providers.dart';
import 'player_presence_indicator.dart';
import 'presence_label.dart';

class RecentOpponentCard extends ConsumerWidget {
  final String userId;

  const RecentOpponentCard({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(publicProfileProvider(userId));

    return GlassSurface(
      onTap: () => context.push('/app/profile/external/$userId'),
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
                    profile?.displayName ?? 'Opponent',
                    style: const TextStyle(
                      color: SoteriaColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
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
            _RematchButton(userId: userId),
          ],
        ),
        loading: () => const _LoadingPlaceholder(),
        error: (_, _) => const SizedBox.shrink(),
      ),
    );
  }
}

class _RematchButton extends ConsumerWidget {
  final String userId;
  const _RematchButton({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => context.push('/app/challenges/create?opponentId=$userId'),
      style: ElevatedButton.styleFrom(
        backgroundColor: SoteriaColors.primary,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text(
        'REMATCH',
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _LoadingPlaceholder extends StatelessWidget {
  const _LoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(SoteriaRadius.lg),
      ),
    );
  }
}
