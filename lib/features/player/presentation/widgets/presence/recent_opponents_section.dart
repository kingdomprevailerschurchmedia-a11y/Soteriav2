import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/avatar/data/avatar_catalog.dart';
import 'package:soteria/features/player/presentation/providers/match_history_providers.dart';
import 'package:soteria/features/player/presentation/providers/public_profile_providers.dart';
import 'player_presence_indicator.dart';

class RecentOpponentsSection extends ConsumerWidget {
  const RecentOpponentsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentOpponentsAsync = ref.watch(recentOpponentsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md),
          child: Text(
            'RECENT OPPONENTS',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 2,
            ),
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SizedBox(
          height: 100.h,
          child: recentOpponentsAsync.when(
            data: (opponentIds) {
              if (opponentIds.isEmpty) {
                return _buildEmptyState(context);
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md),
                scrollDirection: Axis.horizontal,
                itemCount: opponentIds.length,
                itemBuilder: (context, index) => _OpponentItem(userId: opponentIds[index]),
              );
            },
            loading: () => _buildLoadingState(),
            error: (_, _) => _buildErrorState(),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        'No recent matches found.',
        style: context.bodySmall.copyWith(color: SoteriaColors.muted),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(right: SoteriaSpacing.md),
        child: CircleAvatar(radius: 32.r, backgroundColor: Colors.white.withValues(alpha: 0.05)),
      ),
    );
  }

  Widget _buildErrorState() {
    return const Center(child: Icon(Icons.error_outline, color: SoteriaColors.error));
  }
}

class _OpponentItem extends ConsumerWidget {
  final String userId;

  const _OpponentItem({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(publicProfileProvider(userId));

    return GestureDetector(
      onTap: () => context.push('/app/profile/external/$userId'),
      child: Container(
        margin: EdgeInsets.only(right: SoteriaSpacing.lg),
        width: 64.w,
        child: Column(
          children: [
            profileAsync.when(
              data: (profile) => Stack(
                children: [
                  SoteriaAvatar(
                    avatar: AvatarCatalog().getById(profile?.avatarId ?? 'socrates'),
                    size: 64,
                    imageUrl: profile?.photoUrl,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: PlayerPresenceIndicator(userId: userId, size: 14),
                  ),
                ],
              ),
              loading: () => CircleAvatar(radius: 32.r, backgroundColor: Colors.white10),
              error: (_, _) => const Icon(Icons.error),
            ),
            SizedBox(height: SoteriaSpacing.xs),
            profileAsync.maybeWhen(
              data: (profile) => Text(
                profile?.displayName ?? 'Player',
                style: context.labelSmall.copyWith(fontSize: 10),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              orElse: () => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
