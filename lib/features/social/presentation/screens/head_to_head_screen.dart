import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/avatar/data/avatar_catalog.dart';
import 'package:soteria/core/network/providers/connectivity_providers.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/features/player/presentation/providers/public_profile_providers.dart';
import 'package:soteria/features/player/presentation/widgets/match_history/competitive_match_history_card.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import 'package:soteria/features/social/domain/models/head_to_head_summary.dart';
import '../providers/rivalry_providers.dart';
import '../../../player/presentation/widgets/presence/competitive_quick_actions.dart';
import '../../../player/presentation/widgets/presence/player_presence_indicator.dart';
import '../../../player/presentation/widgets/presence/presence_label.dart';

class HeadToHeadScreen extends ConsumerWidget {
  final String rivalId;

  const HeadToHeadScreen({super.key, required this.rivalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(headToHeadProvider(rivalId));
    final matchesAsync = ref.watch(headToHeadMatchesProvider(rivalId));
    final rivalProfileAsync = ref.watch(publicProfileProvider(rivalId));

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('HEAD-TO-HEAD'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(SoteriaSpacing.lg),
              child: Column(
                children: [
                  _buildVersusHeader(context, ref, rivalProfileAsync),
                  SizedBox(height: SoteriaSpacing.lg),
                  summaryAsync.when(
                    data: (summary) => _buildStatsSummary(context, summary),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (err, _) => Text('Error loading stats: $err'),
                  ),
                  SizedBox(height: SoteriaSpacing.xl),
                  rivalProfileAsync.maybeWhen(
                    data: (profile) => profile != null 
                      ? CompetitiveQuickActions(userId: rivalId, profile: profile)
                      : const SizedBox.shrink(),
                    orElse: () => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md),
            sliver: SliverToBoxAdapter(
              child: Text(
                'RECENT MATCHES',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 2),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(SoteriaSpacing.md),
            sliver: matchesAsync.when(
              data: (matches) {
                if (matches.isEmpty) {
                  return const SliverToBoxAdapter(child: Center(child: Text('No matches recorded yet.')));
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CompetitiveMatchHistoryCard(match: matches[index]),
                    ),
                    childCount: matches.length,
                  ),
                );
              },
              loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
              error: (err, _) => SliverToBoxAdapter(child: Text('Error loading matches: $err')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersusHeader(BuildContext context, WidgetRef ref, AsyncValue<dynamic> rivalProfileAsync) {
    final isOnline = ref.watch(isOnlineProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SoteriaAvatar(size: 64, isOnline: isOnline, showStatus: true),
            const SizedBox(height: 8),
            const Text('YOU', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
          child: Text('VS', style: context.headlineSmall.copyWith(color: SoteriaColors.primary, fontWeight: FontWeight.w900)),
        ),
        rivalProfileAsync.when(
          data: (profile) => Column(
            children: [
              Stack(
                children: [
                  SoteriaAvatar(
                    avatar: AvatarCatalog().getById(profile?.avatarId ?? 'socrates'),
                    size: 64,
                    imageUrl: profile?.photoUrl,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: PlayerPresenceIndicator(userId: rivalId, size: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(profile?.displayName ?? 'Rival', style: const TextStyle(fontWeight: FontWeight.bold)),
              PresenceLabel(userId: rivalId),
            ],
          ),
          loading: () => const SizedBox(width: 64, height: 64, child: CircularProgressIndicator()),
          error: (_, _) => const Icon(Icons.error),
        ),
      ],
    );
  }

  Widget _buildStatsSummary(BuildContext context, HeadToHeadSummary summary) {
    return Column(
      children: [
        GlassSurface(
          borderRadius: BorderRadius.circular(16.r),
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(label: 'YOU', value: summary.playerAWins.toString()),
                  _StatItem(label: 'MATCHES', value: summary.totalMatches.toString(), isMuted: true),
                  _StatItem(label: 'RIVAL', value: summary.playerBWins.toString()),
                ],
              ),
              const Divider(color: SoteriaColors.border, height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatDetail(label: 'WIN RATE', value: '${(summary.playerAWinRate * 100).toInt()}%'),
                  _StatDetail(label: 'STREAK', value: summary.playerACurrentStreak.toString(), 
                    color: summary.playerACurrentStreak > 0 ? SoteriaColors.success : null),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        if (summary.recentResults.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('RECENT: ', style: context.labelSmall.copyWith(color: SoteriaColors.muted)),
              ...summary.recentResults.map<Widget>((outcome) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: outcome == CompetitiveOutcome.win ? SoteriaColors.success : 
                        (outcome == CompetitiveOutcome.loss ? SoteriaColors.error : SoteriaColors.muted),
                  shape: BoxShape.circle,
                ),
              )),
            ],
          ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isMuted;

  const _StatItem({required this.label, required this.value, this.isMuted = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: context.headlineMedium.copyWith(fontWeight: FontWeight.w900, color: isMuted ? SoteriaColors.muted : Colors.white)),
        Text(label, style: context.labelSmall.copyWith(color: SoteriaColors.muted)),
      ],
    );
  }
}

class _StatDetail extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _StatDetail({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: color ?? Colors.white)),
        Text(label, style: context.labelSmall.copyWith(color: SoteriaColors.muted, fontSize: 10)),
      ],
    );
  }
}
