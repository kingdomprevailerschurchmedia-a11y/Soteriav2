import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../../../../core/avatar/providers/avatar_providers.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';

class LeaderboardPreview extends StatelessWidget {
  const LeaderboardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOP SCHOLARS',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.gold,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'VIEW ALL',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.primary,
                  ),
                ),
              ),
            ],
          ),
          GlassSurface(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              children: [
                _LeaderboardRow(
                  rank: 1,
                  name: 'Hypatia',
                  xp: 24500,
                  isGold: true,
                  avatarId: 'athena',
                ),
                _LeaderboardRow(
                  rank: 2,
                  name: 'Archimedes',
                  xp: 22100,
                  avatarId: 'isaac',
                ),
                _LeaderboardRow(
                  rank: 3,
                  name: 'Euler',
                  xp: 19800,
                  avatarId: 'elias',
                ),
                const Divider(color: Colors.white10, height: 1),
                _LeaderboardRow(rank: 42, name: 'You', xp: 12500, isMe: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeaderboardRow extends ConsumerWidget {
  const _LeaderboardRow({
    required this.rank,
    required this.name,
    required this.xp,
    this.isGold = false,
    this.isMe = false,
    this.avatarId,
  });

  final int rank;
  final String name;
  final int xp;
  final bool isGold;
  final bool isMe;
  final String? avatarId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatar = avatarId != null
        ? ref.watch(avatarCatalogProvider).getById(avatarId!)
        : null;

    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      color: isMe ? SoteriaColors.primary.withValues(alpha: 0.05) : null,
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              rank.toString(),
              style: context.bodySmall.copyWith(
                color: isGold ? SoteriaColors.gold : SoteriaColors.muted,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: SoteriaSpacing.sm),
          SoteriaAvatar(avatar: avatar, size: 24, rank: rank, hasBorder: false),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Text(
              name,
              style: context.bodyMedium.copyWith(
                fontWeight: isMe ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            '$xp XP',
            style: context.labelSmall.copyWith(color: SoteriaColors.muted),
          ),
        ],
      ),
    );
  }
}
