import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
import '../widgets/milestone_card.dart';
import '../providers/reward_providers.dart';
import 'package:soteria/features/player/presentation/providers/milestone_providers.dart';
import 'package:soteria/features/player/presentation/providers/season_providers.dart';
import '../../domain/models/competitive_season.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/design_system/components/soteria_stats_widgets.dart';
import '../../../../core/design_system/components/soteria_back_button.dart';
import '../../../../features/player/providers/player_providers.dart';
import 'milestones_screen.dart';

class CompetitiveRankOverviewScreen extends ConsumerWidget {
  const CompetitiveRankOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rankProgressAsync = ref.watch(rankProgressProvider);

    return SafeGradientScaffold(
      body: rankProgressAsync.when(
        data: (progress) => _buildContent(context, ref, progress),
        loading: () => const Center(child: CircularProgressIndicator(color: SoteriaColors.primary)),
        error: (e, st) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline_rounded, color: SoteriaColors.error, size: 48),
              SizedBox(height: SoteriaSpacing.md),
              Text('Failed to load rank data: $e', style: context.bodyMedium),
              SoteriaSpacing.gapMD,
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(competitiveProgressionProvider);
                  ref.invalidate(rankProgressProvider);
                },
                child: const Text('RETRY'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    RankProgress progress,
  ) {
    return Column(
      children: [
        _Header(),
        Expanded(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _RankSummaryCard(progress: progress),
                    SoteriaSpacing.gapMD,
                    _CareerBestCard(),
                    SoteriaSpacing.gapMD,
                    _MilestonesSection(),
                    SoteriaSpacing.gapMD,
                    _HistorySection(),
                    SizedBox(height: 80.h), // Bottom nav space
                  ]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Header extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(currentPlayerProvider);
    
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back Button
            const SoteriaBackButton(),
            
            // Title
            Text(
              'COMPETITIVE RANK',
              style: context.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                fontSize: 18.sp,
              ),
            ),
            
            // Coin Balance
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1638).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: SoteriaCoinWidget(
                amount: player?.coins ?? 0,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RankSummaryCard extends ConsumerWidget {
  final RankProgress progress;

  const _RankSummaryCard({required this.progress});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positionAsync = ref.watch(playerRankPositionProvider);
    final currentSeasonAsync = ref.watch(currentSeasonProvider);

    return GlassSurface(
      borderRadius: BorderRadius.circular(20.r),
      opacity: 0.05,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Emblem
                SizedBox(
                  width: 90.r,
                  height: 90.r,
                  child: Center(
                    child: CompetitiveRankBadge(
                      tierId: progress.tier.id,
                      rankName: progress.currentRank,
                      size: RankBadgeSize.large,
                      hasGlow: true,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                // Rank Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CURRENT RANK',
                        style: context.labelSmall.copyWith(
                          color: SoteriaColors.textSecondary,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600,
                          fontSize: 9.sp,
                        ),
                      ),
                      // Removed redundant rank name text as it's baked into the badge
                      Row(
                        children: [
                          Icon(Icons.military_tech_rounded, 
                               color: SoteriaColors.secondary, size: 14.sp),
                          SizedBox(width: 4.w),
                          Text(
                            '${progress.currentRP} RP',
                            style: context.bodySmall.copyWith(
                              color: SoteriaColors.textSecondary,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${progress.currentRP} RP',
                            style: context.labelSmall.copyWith(
                              color: Colors.white70,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (!progress.isMaxRank)
                            Text(
                              'TO ${progress.nextRank?.toUpperCase()}',
                              style: context.labelSmall.copyWith(
                                color: SoteriaColors.textSecondary,
                                fontSize: 8.sp,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      // Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: LinearProgressIndicator(
                          value: progress.progressPercentage,
                          minHeight: 4.h,
                          backgroundColor: Colors.white.withValues(alpha: 0.05),
                          valueColor: const AlwaysStoppedAnimation<Color>(SoteriaColors.secondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Divider
          Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
          
          // Footer tiles
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  child: _FooterTile(
                    icon: Icons.public_rounded,
                    label: 'GLOBAL RANK',
                    value: positionAsync.when(
                      data: (pos) => pos > 0 ? '#$pos' : 'Unranked',
                      loading: () => '...',
                      error: (_, _) => 'N/A',
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _FooterTile(
                    icon: Icons.calendar_today_rounded,
                    label: 'SEASON',
                    value: currentSeasonAsync.when(
                      data: (season) => season?.displayName ?? season?.name ?? 'Active',
                      loading: () => '...',
                      error: (_, _) => 'N/A',
                    ),
                    showChevron: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showChevron;

  const _FooterTile({
    required this.icon,
    required this.label,
    required this.value,
    this.showChevron = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: SoteriaColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: SoteriaColors.secondary, size: 16.sp),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.textSecondary,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: context.bodySmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (showChevron)
            Icon(Icons.chevron_right_rounded, color: Colors.white24, size: 14.sp),
        ],
      ),
    );
  }
}

class _CareerBestCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(currentUserPersonalRecordsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CAREER BEST',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.secondary,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w900,
            fontSize: 10.sp,
          ),
        ),
        SoteriaSpacing.gapSM,
        GlassSurface(
          borderRadius: BorderRadius.circular(16.r),
          opacity: 0.05,
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: recordsAsync.when(
              data: (records) {
                final bestRank = records.where((r) => r.type == CompetitiveRecordType.bestRankReached).firstOrNull;
                final rankValue = bestRank?.displayValue ?? 'Unranked';

                return Row(
                  children: [
                    Container(
                      width: 52.r,
                      height: 52.r,
                      decoration: BoxDecoration(
                        color: SoteriaColors.gold.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                        border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.1)),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/trophy_icon.png',
                          width: 28.sp,
                          height: 28.sp,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'HIGHEST RANK ACHIEVED',
                            style: context.labelSmall.copyWith(
                              color: SoteriaColors.textSecondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 9.sp,
                            ),
                          ),
                          Text(
                            rankValue,
                            style: context.headlineSmall.copyWith(
                              color: SoteriaColors.gold,
                              fontWeight: FontWeight.w900,
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: LinearProgressIndicator(color: SoteriaColors.gold)),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }
}

class _MilestonesSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nextMilestoneAsync = ref.watch(nextCompetitiveMilestoneProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'COMPETITIVE MILESTONES',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.secondary,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w900,
                fontSize: 10.sp,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MilestonesScreen()),
              ),
              child: Text(
                'VIEW ALL',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.secondary,
                  fontWeight: FontWeight.w900,
                  fontSize: 9.sp,
                ),
              ),
            ),
          ],
        ),
        SoteriaSpacing.gapSM,
        nextMilestoneAsync.when(
          data: (next) => next != null
              ? MilestoneCard(
                  progress: next,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const MilestonesScreen()),
                  ),
                )
              : const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator(color: SoteriaColors.secondary)),
          error: (_, __) => const SizedBox.shrink(),
        ),
        SoteriaSpacing.gapMD,
        // Pagination dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Dot(isActive: true),
            SizedBox(width: 6.w),
            _Dot(isActive: false),
            SizedBox(width: 6.w),
            _Dot(isActive: false),
          ],
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final bool isActive;
  const _Dot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 8.w : 6.w,
      height: isActive ? 8.w : 6.w,
      decoration: BoxDecoration(
        color: isActive ? SoteriaColors.secondary : Colors.white.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _HistorySection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'COMPETITIVE HISTORY',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w900,
            fontSize: 10.sp,
          ),
        ),
        SoteriaSpacing.gapSM,
        const RankHistorySection(),
      ],
    );
  }
}
