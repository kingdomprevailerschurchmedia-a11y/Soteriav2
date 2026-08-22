import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../../../player/presentation/providers/public_profile_providers.dart';
import 'package:soteria/features/matchmaking/presentation/providers/match_result_providers.dart';
import 'package:soteria/features/matchmaking/domain/models/competitive_match_result.dart';

class CompetitiveMatchResultScreen extends ConsumerWidget {
  final String matchId;

  const CompetitiveMatchResultScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(currentMatchResultProvider(matchId));

    return SoteriaPage(
      child: Scaffold(
        backgroundColor: SoteriaColors.background,
        body: resultAsync.when(
          data: (result) {
            if (result == null) {
              return const Center(
                child: Text('Result processing...'),
              );
            }

            return Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: SoteriaColors.backgroundGradient,
              ),
              child: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _ResultHeader(outcome: result.outcome),
                    ),
                    SliverToBoxAdapter(
                      child: _ScoreComparison(
                        playerScore: result.playerScore,
                        opponentScore: result.opponentScore,
                        opponentId: result.opponentId,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: _RankChangeCard(rankChange: result.rankChange),
                    ),
                    SliverToBoxAdapter(
                      child: _RewardsSection(rewards: result.rewards),
                    ),
                    SliverToBoxAdapter(
                      child: _PerformanceStats(
                        stats: result.playerPerformance,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(SoteriaSpacing.xl),
                        child: Column(
                          children: [
                            SoteriaButton.primary(
                              label: 'REMATCH',
                              onPressed: () => ref
                                  .read(rematchControllerProvider.notifier)
                                  .requestRematch(matchId),
                            ),
                            SizedBox(height: SoteriaSpacing.md),
                            SoteriaButton.secondary(
                              label: 'VIEW REPLAY',
                              onPressed: () => GoRouter.of(context).push('/app/versus/replay/$matchId'),
                            ),
                            SizedBox(height: SoteriaSpacing.md),
                            SoteriaButton.secondary(
                              label: 'RETURN TO LOBBY',
                              onPressed: () => GoRouter.of(context).go('/app/versus'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}

class _ResultHeader extends StatelessWidget {
  final MatchOutcome outcome;
  const _ResultHeader({required this.outcome});

  @override
  Widget build(BuildContext context) {
    String title;
    Color color;
    IconData icon;

    switch (outcome) {
      case MatchOutcome.victory:
        title = 'VICTORY';
        color = SoteriaColors.success;
        icon = Icons.emoji_events_rounded;
        break;
      case MatchOutcome.defeat:
        title = 'DEFEAT';
        color = SoteriaColors.error;
        icon = Icons.sentiment_very_dissatisfied_rounded;
        break;
      case MatchOutcome.draw:
        title = 'DRAW';
        color = SoteriaColors.gold;
        icon = Icons.handshake_rounded;
        break;
      default:
        title = 'MATCH ENDED';
        color = SoteriaColors.muted;
        icon = Icons.info_outline_rounded;
    }

    return Column(
      children: [
        SizedBox(height: SoteriaSpacing.xxl),
        SoteriaScaleIn(
          child: Icon(icon, color: color, size: 64.w),
        ),
        SizedBox(height: SoteriaSpacing.md),
        Text(
          title,
          style: context.displayMedium.copyWith(
            fontWeight: FontWeight.w900,
            color: color,
            letterSpacing: 4,
          ),
        ),
      ],
    );
  }
}

class _ScoreComparison extends ConsumerWidget {
  final int playerScore;
  final int opponentScore;
  final String opponentId;

  const _ScoreComparison({
    required this.playerScore,
    required this.opponentScore,
    required this.opponentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opponentAsync = ref.watch(publicProfileProvider(opponentId));

    return Padding(
      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ScoreItem(label: 'YOU', score: playerScore, isWinner: playerScore > opponentScore),
          opponentAsync.when(
            data: (opp) => _ScoreItem(
              label: opp?.displayName.toUpperCase() ?? 'OPPONENT',
              score: opponentScore,
              isWinner: opponentScore > playerScore,
              photoUrl: opp?.photoUrl,
            ),
            loading: () => const CircularProgressIndicator(),
            error: (_, _) => _ScoreItem(label: '???', score: opponentScore, isWinner: false),
          ),
        ],
      ),
    );
  }
}

class _ScoreItem extends StatelessWidget {
  final String label;
  final int score;
  final bool isWinner;
  final String? photoUrl;

  const _ScoreItem({
    required this.label,
    required this.score,
    required this.isWinner,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SoteriaAvatar(imageUrl: photoUrl, size: 64, showGlow: isWinner),
        SizedBox(height: SoteriaSpacing.sm),
        Text(
          label,
          style: context.labelSmall.copyWith(color: SoteriaColors.muted),
        ),
        Text(
          score.toString(),
          style: context.headlineMedium.copyWith(
            fontWeight: FontWeight.w900,
            color: isWinner ? SoteriaColors.gold : Colors.white,
          ),
        ),
      ],
    );
  }
}

class _RankChangeCard extends StatelessWidget {
  final Map<String, dynamic> rankChange;
  const _RankChangeCard({required this.rankChange});

  @override
  Widget build(BuildContext context) {
    final change = rankChange['pointsChange'] ?? 0;
    final isGain = change >= 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RANK PROGRESS',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted),
              ),
              Text(
                '${rankChange['rankBefore']} → ${rankChange['rankAfter']}',
                style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: (isGain ? SoteriaColors.success : SoteriaColors.error)
                  .withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '${isGain ? '+' : ''}$change RP',
              style: TextStyle(
                color: isGain ? SoteriaColors.success : SoteriaColors.error,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardsSection extends StatelessWidget {
  final Map<String, dynamic> rewards;
  const _RewardsSection({required this.rewards});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SoteriaSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REWARDS',
            style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 1.5),
          ),
          SizedBox(height: SoteriaSpacing.md),
          Row(
            children: [
              _RewardItem(
                label: 'XP',
                value: '+${rewards['xp'] ?? 0}',
                icon: Icons.bolt_rounded,
                color: SoteriaColors.primary,
              ),
              SizedBox(width: SoteriaSpacing.md),
              _RewardItem(
                label: 'COINS',
                value: '+${rewards['coins'] ?? 0}',
                icon: Icons.monetization_on_rounded,
                color: SoteriaColors.gold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RewardItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _RewardItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(SoteriaSpacing.md),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24.w),
            SizedBox(width: SoteriaSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: context.titleMedium.copyWith(fontWeight: FontWeight.w900, color: color),
                ),
                Text(
                  label,
                  style: context.labelSmall.copyWith(color: color.withValues(alpha: 0.7), fontSize: 8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PerformanceStats extends StatelessWidget {
  final dynamic stats;
  const _PerformanceStats({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PERFORMANCE',
            style: context.labelSmall.copyWith(color: SoteriaColors.muted, letterSpacing: 1.5),
          ),
          SizedBox(height: SoteriaSpacing.md),
          _StatRow(label: 'Accuracy', value: '${(stats.accuracy * 100).toInt()}%'),
          _StatRow(label: 'Correct Answers', value: '${stats.correctAnswers}'),
          _StatRow(label: 'Avg Response', value: '${(stats.avgResponseTime.inMilliseconds / 1000).toStringAsFixed(1)}s'),
          _StatRow(label: 'Max Streak', value: '${stats.maxStreak}'),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.bodyMedium.copyWith(color: SoteriaColors.textSecondary)),
          Text(value, style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
