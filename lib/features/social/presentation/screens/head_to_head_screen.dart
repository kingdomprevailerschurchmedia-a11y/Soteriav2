import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../player/presentation/providers/public_profile_providers.dart';
import '../../../player/presentation/widgets/match_history/competitive_match_history_card.dart';
import '../../../player/domain/models/competitive_result.dart';
import '../providers/rivalry_providers.dart';

class HeadToHeadScreen extends ConsumerWidget {
  final String rivalId;

  const HeadToHeadScreen({super.key, required this.rivalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rivalryAsync = ref.watch(headToHeadProvider(rivalId));
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
                  _buildVersusHeader(context, rivalProfileAsync),
                  SizedBox(height: SoteriaSpacing.lg),
                  rivalryAsync.when(
                    data: (rivalry) => _buildStatsSummary(context, rivalry),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (err, _) => Text('Error loading stats: $err'),
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

  Widget _buildVersusHeader(BuildContext context, AsyncValue<dynamic> rivalProfileAsync) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Column(
          children: [
            SoteriaAvatar(size: 64, isOnline: true),
            SizedBox(height: 8),
            Text('YOU', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
          child: Text('VS', style: context.headlineSmall.copyWith(color: SoteriaColors.primary, fontWeight: FontWeight.w900)),
        ),
        rivalProfileAsync.when(
          data: (profile) => Column(
            children: [
              SoteriaAvatar(
                avatar: AvatarCatalog().getById(profile?.avatarId ?? 'socrates'),
                size: 64,
                imageUrl: profile?.photoUrl,
              ),
              const SizedBox(height: 8),
              Text(profile?.displayName ?? 'Rival', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          loading: () => const SizedBox(width: 64, height: 64, child: CircularProgressIndicator()),
          error: (_, __) => const Icon(Icons.error),
        ),
      ],
    );
  }

  Widget _buildStatsSummary(BuildContext context, dynamic rivalry) {
    return Column(
      children: [
        GlassSurface(
          borderRadius: BorderRadius.circular(16.r),
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(label: 'YOU', value: rivalry.wins.toString()),
              _StatItem(label: 'MATCHES', value: rivalry.matchesPlayed.toString(), isMuted: true),
              _StatItem(label: 'RIVAL', value: rivalry.losses.toString()),
            ],
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        if (rivalry.recentForm.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('FORM: ', style: context.labelSmall.copyWith(color: SoteriaColors.muted)),
              ...rivalry.recentForm.map<Widget>((outcome) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: outcome == CompetitiveOutcome.win ? SoteriaColors.success : SoteriaColors.error,
                  shape: BoxShape.circle,
                ),
              )).toList(),
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
