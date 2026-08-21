import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/player/presentation/providers/match_history_providers.dart';
import 'package:soteria/features/player/presentation/providers/statistics_providers.dart';
import 'package:soteria/features/player/presentation/widgets/match_history/competitive_match_history_card.dart';
import 'package:soteria/features/player/presentation/widgets/match_history/match_history_filter_bar.dart';
import 'package:soteria/features/player/presentation/widgets/match_history/performance_insight_section.dart';
import 'package:soteria/features/player/presentation/widgets/match_history/competitive_match_details_sheet.dart';
import 'package:soteria/features/player/presentation/widgets/match_history/match_history_empty_state.dart';
import 'package:soteria/features/player/presentation/widgets/match_history/match_history_loading_state.dart';
import 'package:soteria/features/player/presentation/widgets/statistics/performance_trend_widget.dart';
import 'package:soteria/features/player/domain/models/competitive_match.dart';
import 'package:soteria/features/player/presentation/widgets/profile/statistic_card.dart';

class CompetitiveMatchHistoryScreen extends ConsumerStatefulWidget {
  const CompetitiveMatchHistoryScreen({super.key});

  @override
  ConsumerState<CompetitiveMatchHistoryScreen> createState() =>
      _CompetitiveMatchHistoryScreenState();
}

class _CompetitiveMatchHistoryScreenState
    extends ConsumerState<CompetitiveMatchHistoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final userId = ref.read(authRepositoryProvider).currentUserId;
      if (userId != null) {
        ref.read(matchHistoryProvider(userId).notifier).loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(authRepositoryProvider).currentUserId;
    if (userId == null) return const SizedBox.shrink();

    final matchesAsync = ref.watch(matchHistoryProvider(userId));
    final statsAsync = ref.watch(competitiveStatisticsProvider);
    final hasMore = ref.watch(matchHistoryProvider(userId).notifier).hasMore;

    return SafeGradientScaffold(
      appBar: AppBar(
        title: Text(
          'MATCH HISTORY',
          style: context.headlineSmall.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics_rounded, color: SoteriaColors.gold),
            onPressed: () => GoRouter.of(context).push('/app/versus/insights'),
            tooltip: 'Competitive Insights',
          ),
          SizedBox(width: 8.w),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ... (Performance Summary & Trends)
          statsAsync.when(
            data: (stats) => SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SoteriaSpacing.lg),
                    _buildPerformanceSummary(context, stats),
                    if (stats.trends.isNotEmpty) ...[
                      SizedBox(height: SoteriaSpacing.lg),
                      _buildTrendsGrid(context, stats.trends),
                    ],
                    SizedBox(height: SoteriaSpacing.xl),
                    const PerformanceInsightSection(),
                    SizedBox(height: SoteriaSpacing.lg),
                    const Divider(color: Colors.white10),
                  ],
                ),
              ),
            ),
            loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
            error: (_, _) =>
                const SliverToBoxAdapter(child: SizedBox.shrink()),
          ),

          SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),
          const SliverToBoxAdapter(child: MatchHistoryFilterBar()),
          SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),

          // Recent Matches
          matchesAsync.when(
            data: (matches) {
              if (matches.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: MatchHistoryEmptyState()),
                );
              }

              return SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == matches.length) {
                      return _buildLoadMoreIndicator();
                    }
                    return CompetitiveMatchHistoryCard(
                      match: matches[index],
                      onTap: () => _showMatchDetails(context, matches[index]),
                    );
                  }, childCount: matches.length + (hasMore ? 1 : 0)),
                ),
              );
            },
            loading: () => SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
              sliver: const SliverToBoxAdapter(
                child: MatchHistoryLoadingState(),
              ),
            ),
            error: (err, _) => SliverFillRemaining(
              child: Center(
                child: Text(
                  'Error: $err',
                  style: context.bodyMedium.copyWith(
                    color: SoteriaColors.error,
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
        ],
      ),
    );
  }

  Widget _buildPerformanceSummary(BuildContext context, dynamic stats) {
    final career = stats.career;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CAREER SUMMARY',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2.2,
          mainAxisSpacing: SoteriaSpacing.md,
          crossAxisSpacing: SoteriaSpacing.md,
          children: [
            StatisticCard(
              label: 'WIN RATE',
              value: '${(career.winRate * 100).toInt()}%',
              icon: Icons.emoji_events_rounded,
              color: SoteriaColors.success,
            ),
            StatisticCard(
              label: 'ACCURACY',
              value: '${(career.accuracy * 100).toInt()}%',
              icon: Icons.track_changes_rounded,
              color: SoteriaColors.warning,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendsGrid(BuildContext context, List<dynamic> trends) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PERFORMANCE TRENDS',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: SoteriaSpacing.md,
            crossAxisSpacing: SoteriaSpacing.md,
            childAspectRatio: 1.8,
          ),
          itemCount: trends.take(2).length,
          itemBuilder: (context, index) =>
              PerformanceTrendWidget(trend: trends[index]),
        ),
      ],
    );
  }

  Widget _buildLoadMoreIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.lg),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        strokeWidth: 2,
        color: SoteriaColors.primary,
      ),
    );
  }

  void _showMatchDetails(BuildContext context, CompetitiveMatch match) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CompetitiveMatchDetailsSheet(match: match),
    );
  }
}
