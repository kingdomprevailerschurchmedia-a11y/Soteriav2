import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../providers/rank_providers.dart';
import '../providers/leaderboard_providers.dart';
import '../providers/personal_record_providers.dart';
import '../../domain/models/competitive_personal_record.dart';
import '../../domain/models/rank_progress.dart';
import '../widgets/competitive_rank_badge.dart';
import '../widgets/rank_progress_bar.dart';
import '../widgets/rank_history_section.dart';

class CompetitiveRankOverviewScreen extends ConsumerWidget {
  const CompetitiveRankOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rankProgressAsync = ref.watch(rankProgressProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('COMPETITIVE RANK'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SoteriaPage(
        child: rankProgressAsync.when(
          data: (progress) => _buildContent(context, ref, progress),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    RankProgress progress,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Section
          _buildHeroSection(context, progress),

          SizedBox(height: SoteriaSpacing.xxl),

          // Stats Grid
          _buildStatsGrid(context, ref),

          SizedBox(height: SoteriaSpacing.xxl),

          // Career Best
          _buildCareerBestSection(context, ref),

          SizedBox(height: SoteriaSpacing.xxl),

          // Recent Rank History
          const RankHistorySection(),

          SizedBox(height: SoteriaSpacing.xxxl),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, RankProgress progress) {
    return Center(
      child: Column(
        children: [
          CompetitiveRankBadge(
            tierId: progress.tier.id,
            rankName: progress.currentRank,
            size: RankBadgeSize.extraLarge,
            hasGlow: true,
          ),
          SizedBox(height: SoteriaSpacing.xl),
          Text(
            progress.currentRank.toUpperCase(),
            style: context.displaySmall.copyWith(
              color: SoteriaColors.textPrimary,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: SoteriaSpacing.xs),
          Text(
            '${progress.currentRP} Rank Points',
            style: context.titleMedium.copyWith(
              color: SoteriaColors.textSecondary,
            ),
          ),
          SizedBox(height: SoteriaSpacing.xxl),
          RankProgressBar(
            progress: progress,
            variant: RankProgressVariant.hero,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, WidgetRef ref) {
    final positionAsync = ref.watch(playerRankPositionProvider);

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: SoteriaSpacing.md,
      crossAxisSpacing: SoteriaSpacing.md,
      childAspectRatio: 1.5,
      children: [
        _StatCard(
          label: 'GLOBAL POSITION',
          value: positionAsync.when(
            data: (pos) => '#$pos',
            loading: () => '...',
            error: (_, _) => 'N/A',
          ),
          icon: Icons.public_rounded,
        ),
        _StatCard(
          label: 'CURRENT SEASON',
          value: 'SEASON 5', // Hardcoded for now, should be from currentSeasonProvider
          icon: Icons.event_note_rounded,
        ),
      ],
    );
  }

  Widget _buildCareerBestSection(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(currentUserPersonalRecordsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CAREER BEST',
          style: context.titleSmall.copyWith(
            color: SoteriaColors.textSecondary,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        recordsAsync.when(
          data: (records) {
            final bestRank = records.firstWhere(
              (r) => r.type == CompetitiveRecordType.bestRankReached,
              orElse: () => records.first, // Placeholder
            );
            return _StatCard(
              label: 'HIGHEST RANK ACHIEVED',
              value: bestRank.displayValue,
              icon: Icons.emoji_events_rounded,
              color: SoteriaColors.gold,
            );
          },
          loading: () => const LinearProgressIndicator(),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = color ?? SoteriaColors.textPrimary;

    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: SoteriaColors.surface,
        borderRadius: BorderRadius.circular(SoteriaSpacing.md),
        border: Border.all(color: SoteriaColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: effectiveColor, size: 20.w),
          SizedBox(height: SoteriaSpacing.sm),
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.textSecondary,
              fontSize: 10.sp,
            ),
          ),
          Text(
            value,
            style: context.titleLarge.copyWith(
              color: effectiveColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
