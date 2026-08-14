import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../../../player/presentation/providers/public_profile_providers.dart';
import '../../../player/presentation/widgets/competitive_rank_badge.dart';
import '../../domain/models/player_rivalry.dart';
import '../screens/head_to_head_screen.dart';

class RivalryCard extends ConsumerWidget {
  final PlayerRivalry rivalry;

  const RivalryCard({super.key, required this.rivalry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rivalProfileAsync = ref.watch(publicProfileProvider(rivalry.rivalId));

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HeadToHeadScreen(rivalId: rivalry.rivalId)),
      ),
      child: GlassSurface(
        borderRadius: BorderRadius.circular(20.r),
        opacity: 0.08,
        padding: EdgeInsets.all(SoteriaSpacing.md),
        child: rivalProfileAsync.when(
          data: (profile) {
            if (profile == null) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SoteriaAvatar(
                      avatar: AvatarCatalog().getById(profile.avatarId),
                      size: 40,
                      imageUrl: profile.photoUrl,
                    ),
                    SizedBox(width: SoteriaSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profile.displayName, style: context.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              CompetitiveRankBadge(
                                rankName: profile.currentRank,
                                tierId: profile.rankTier.toLowerCase(),
                                size: RankBadgeSize.small,
                              ),
                              SizedBox(width: 4.w),
                              Text('${profile.rankPoints} RP', style: context.labelSmall.copyWith(color: SoteriaColors.gold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildRecordTag(context),
                  ],
                ),
                SizedBox(height: SoteriaSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Last played ${_formatDate(rivalry.lastMatchAt)}',
                      style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                    ),
                    const Icon(Icons.chevron_right_rounded, color: SoteriaColors.muted),
                  ],
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          error: (_, __) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildRecordTag(BuildContext context) {
    final lead = rivalry.wins - rivalry.losses;
    final text = lead > 0 ? 'YOU LEAD' : lead < 0 ? 'RIVAL LEADS' : 'TIED';
    final color = lead > 0 ? SoteriaColors.success : lead < 0 ? SoteriaColors.error : SoteriaColors.muted;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        '$text ${rivalry.wins}–${rivalry.losses}',
        style: context.labelSmall.copyWith(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
