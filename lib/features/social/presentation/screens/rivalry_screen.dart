import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/data/avatar_catalog.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../player/presentation/providers/public_profile_providers.dart';
import '../providers/rivalry_providers.dart';
import '../../domain/models/head_to_head_summary.dart';
import '../../../player/domain/models/competitive_activity_event.dart';
import '../../../player/presentation/providers/activity_providers.dart';
import '../../../player/presentation/widgets/activity/competitive_activity_card.dart';
import '../../../player/presentation/widgets/presence/competitive_quick_actions.dart';
import '../../../player/presentation/widgets/presence/player_presence_indicator.dart';
import '../../../player/presentation/widgets/presence/presence_label.dart';

class RivalryScreen extends ConsumerWidget {
  final String rivalId;

  const RivalryScreen({super.key, required this.rivalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(headToHeadProvider(rivalId));
    final rivalProfileAsync = ref.watch(publicProfileProvider(rivalId));
    final activityAsync = ref.watch(rivalryActivityProvider(rivalId));

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('RIVALRY'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        child: Column(
          children: [
            _buildRivalHeader(context, rivalProfileAsync),
            SizedBox(height: SoteriaSpacing.xl),
            summaryAsync.when(
              data: (summary) => Column(
                children: [
                  _buildRecordCard(context, summary),
                  SizedBox(height: SoteriaSpacing.lg),
                  _buildStreakCard(context, summary),
                  SizedBox(height: SoteriaSpacing.xl),
                  _buildActivitySection(context, activityAsync),
                  SizedBox(height: SoteriaSpacing.xxl),
                  rivalProfileAsync.maybeWhen(
                    data: (profile) => _buildActions(context, profile),
                    orElse: () => const SizedBox.shrink(),
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text('Error loading rivalry: $err'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRivalHeader(BuildContext context, AsyncValue<dynamic> profileAsync) {
    return Column(
      children: [
        profileAsync.when(
          data: (profile) => Column(
            children: [
              Stack(
                children: [
                  SoteriaAvatar(
                    avatar: AvatarCatalog().getById(profile?.avatarId ?? 'socrates'),
                    size: 100,
                    imageUrl: profile?.photoUrl,
                  ),
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: PlayerPresenceIndicator(userId: rivalId, size: 24),
                  ),
                ],
              ),
              SizedBox(height: SoteriaSpacing.md),
              Text(
                profile?.displayName ?? 'Rival',
                style: context.headlineMedium.copyWith(fontWeight: FontWeight.w900),
              ),
              PresenceLabel(userId: rivalId),
              Text(
                profile?.rankTier ?? 'Unranked',
                style: context.bodyMedium.copyWith(color: SoteriaColors.gold, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => const Icon(Icons.error, size: 50),
        ),
      ],
    );
  }

  Widget _buildRecordCard(BuildContext context, HeadToHeadSummary summary) {
    return GlassSurface(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        children: [
          Text('CAREER RECORD', style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 2)),
          SizedBox(height: SoteriaSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatItem(label: 'WINS', value: summary.playerAWins.toString(), color: SoteriaColors.success),
              _StatItem(label: 'MATCHES', value: summary.totalMatches.toString()),
              _StatItem(label: 'LOSSES', value: summary.playerBWins.toString(), color: SoteriaColors.error),
            ],
          ),
          SizedBox(height: SoteriaSpacing.md),
          LinearProgressIndicator(
            value: summary.playerAWinRate,
            backgroundColor: SoteriaColors.error.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation(SoteriaColors.success),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakCard(BuildContext context, HeadToHeadSummary summary) {
    final playerAhead = summary.playerAWins > summary.playerBWins;
    final leadCount = (summary.playerAWins - summary.playerBWins).abs();

    return GlassSurface(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CURRENT STREAK', style: context.labelSmall.copyWith(color: SoteriaColors.muted)),
                  Text(
                    summary.playerACurrentStreak > 0 
                      ? '${summary.playerACurrentStreak} Wins' 
                      : (summary.playerBCurrentStreak > 0 ? '${summary.playerBCurrentStreak} Losses' : 'No streak'),
                    style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (leadCount > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('LEAD', style: context.labelSmall.copyWith(color: SoteriaColors.muted)),
                    Text(
                      playerAhead ? 'You are $leadCount ahead' : 'Rival is $leadCount ahead',
                      style: context.bodyLarge.copyWith(color: playerAhead ? SoteriaColors.success : SoteriaColors.warning, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection(BuildContext context, AsyncValue<List<CompetitiveActivityEvent>> activityAsync) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('RECENT RIVALRY ACTIVITY', style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 2)),
        SizedBox(height: SoteriaSpacing.md),
        activityAsync.when(
          data: (events) {
            if (events.isEmpty) return const Text('No recent activity recorded.');
            return Column(
              children: events.map((e) => CompetitiveActivityCard(event: e, isLast: e == events.last)).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const Text('Error loading activity'),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, dynamic profile) {
    return Column(
      children: [
        if (profile != null)
          CompetitiveQuickActions(userId: rivalId, profile: profile),
        SizedBox(height: SoteriaSpacing.md),
        TextButton(
          onPressed: () => context.push('/social/head-to-head/$rivalId'),
          child: const Text('VIEW ALL MATCHES', style: TextStyle(color: SoteriaColors.muted)),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _StatItem({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: context.headlineSmall.copyWith(fontWeight: FontWeight.w900, color: color ?? Colors.white)),
        Text(label, style: context.labelSmall.copyWith(color: SoteriaColors.muted)),
      ],
    );
  }
}
