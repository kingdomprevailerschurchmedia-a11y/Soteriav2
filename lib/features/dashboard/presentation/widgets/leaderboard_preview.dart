import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/providers/avatar_providers.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../player/presentation/providers/leaderboard_providers.dart';
import '../../../../core/identity/providers/identity_providers.dart';
import '../../../player/providers/player_providers.dart';
import '../../../player/domain/models/leaderboard_entry.dart';

class LeaderboardPreview extends ConsumerWidget {
  const LeaderboardPreview({super.key});

  static final List<LeaderboardEntry> _seedScholars = [
    LeaderboardEntry(
      userId: 'seed_segun',
      displayName: 'Segun',
      avatarId: 'athena',
      rankPoints: 1200,
      xp: 24500,
      rankTier: 'Master',
      division: 1,
      position: 1,
      registrationOrder: 1,
      lastUpdated: DateTime.now(),
      createdAt: DateTime(2026, 1, 1),
    ),
    LeaderboardEntry(
      userId: 'seed_peter',
      displayName: 'Peter',
      avatarId: 'isaac',
      rankPoints: 1100,
      xp: 22100,
      rankTier: 'Master',
      division: 2,
      position: 2,
      registrationOrder: 2,
      lastUpdated: DateTime.now(),
      createdAt: DateTime(2026, 1, 2),
    ),
    LeaderboardEntry(
      userId: 'seed_micheal',
      displayName: 'Micheal',
      avatarId: 'elias',
      rankPoints: 950,
      xp: 19800,
      rankTier: 'Expert',
      division: 3,
      position: 3,
      registrationOrder: 3,
      lastUpdated: DateTime.now(),
      createdAt: DateTime(2026, 1, 3),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topPlayersAsync = ref.watch(leaderboardControllerProvider(null));
    final playerEntryAsync = ref.watch(playerLeaderboardEntryProvider);
    final playerRankAsync = ref.watch(playerRankPositionProvider);
    final currentUserId = ref.watch(sessionProvider).uid;
    final currentPlayer = ref.watch(currentPlayerProvider);

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
                onPressed: () {
                  // TODO: Navigate to full leaderboard
                },
                child: Text(
                  'VIEW ALL',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          GlassSurface(
            borderRadius: BorderRadius.circular(24),
            child: topPlayersAsync.when(
              data: (entries) {
                final merged = [...entries, ..._seedScholars];
                
                // Sort by XP (desc) then Registration Order (asc)
                merged.sort((a, b) {
                  if (b.rankPoints != a.rankPoints) {
                    return b.rankPoints.compareTo(a.rankPoints);
                  }
                  return a.registrationOrder.compareTo(b.registrationOrder);
                });

                final previewList = merged.take(3).toList();
                final bool isPlayerInTop3 = previewList.any((e) => e.userId == currentUserId);

                return Column(
                  children: [
                    ...previewList.asMap().entries.map((item) {
                      final index = item.key;
                      final entry = item.value;
                      return _LeaderboardRow(
                        rank: index + 1,
                        name: entry.userId == currentUserId ? 'You' : entry.displayName,
                        xp: entry.rankPoints,
                        isGold: index == 0,
                        avatarId: entry.avatarId,
                        imageUrl: entry.avatarUrl,
                        isMe: entry.userId == currentUserId,
                      );
                    }),
                    if (!isPlayerInTop3 && currentPlayer != null) ...[
                      const Divider(color: Colors.white10, height: 1),
                      Builder(
                        builder: (context) {
                          final playerEntry = playerEntryAsync.value;
                          final rawRank = playerRankAsync.value ?? -1;
                          
                          int uiRank = rawRank;
                          if (rawRank == -1) {
                            uiRank = currentPlayer.registrationOrder;
                          } else {
                            final betterSeeds = _seedScholars.where((seed) {
                              if (seed.rankPoints > currentPlayer.xp) return true;
                              if (seed.rankPoints == currentPlayer.xp) {
                                return seed.registrationOrder < currentPlayer.registrationOrder;
                              }
                              return false;
                            }).length;
                            uiRank += betterSeeds;
                          }

                          return _LeaderboardRow(
                            rank: uiRank,
                            name: 'You',
                            xp: currentPlayer.xp,
                            isMe: true,
                            avatarId: playerEntry?.avatarId,
                            imageUrl: playerEntry?.avatarUrl,
                          );
                        },
                      ),
                    ],
                  ],
                );
              },
              loading: () => Column(
                children: List.generate(3, (index) => const _ShimmerRow()),
              ),
              error: (error, _) => Column(
                children: [
                  ..._seedScholars.asMap().entries.map((item) {
                    final index = item.key;
                    final entry = item.value;
                    return _LeaderboardRow(
                      rank: index + 1,
                      name: entry.displayName,
                      xp: entry.rankPoints,
                      isGold: index == 0,
                      avatarId: entry.avatarId,
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerRow extends StatelessWidget {
  const _ShimmerRow();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withValues(alpha: 0.05),
      highlightColor: Colors.white.withValues(alpha: 0.1),
      child: Container(
        padding: EdgeInsets.all(SoteriaSpacing.md),
        child: Row(
          children: [
            Container(width: 24, height: 12, color: Colors.white),
            SizedBox(width: SoteriaSpacing.sm),
            CircleAvatar(radius: 12, backgroundColor: Colors.white),
            SizedBox(width: SoteriaSpacing.md),
            Expanded(child: Container(height: 12, color: Colors.white)),
            SizedBox(width: SoteriaSpacing.md),
            Container(width: 40, height: 12, color: Colors.white),
          ],
        ),
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
    this.imageUrl,
  });

  final int rank;
  final String name;
  final int xp;
  final bool isGold;
  final bool isMe;
  final String? avatarId;
  final String? imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatar = avatarId != null
        ? ref.watch(avatarCatalogProvider).getById(avatarId!)
        : null;

    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      color: isMe ? SoteriaColors.primary.withValues(alpha: 0.1) : null,
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              rank > 0 ? rank.toString() : '-',
              style: context.bodySmall.copyWith(
                color: isGold ? SoteriaColors.gold : SoteriaColors.muted,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: SoteriaSpacing.sm),
          SoteriaAvatar(
            avatar: avatar, 
            imageUrl: imageUrl,
            size: 24, 
            rank: rank, 
            hasBorder: false
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
