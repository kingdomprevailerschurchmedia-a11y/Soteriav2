import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/navigation/soteria_routes.dart';
import '../providers/history_providers.dart';
import '../widgets/history/quiz_history_card.dart';
import '../widgets/history/performance_summary_widgets.dart';
import '../widgets/history/history_filter_bar.dart';
import '../../domain/usecases/history/get_category_performance_use_case.dart';

class QuizHistoryScreen extends ConsumerWidget {
  const QuizHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyListProvider);
    final summaryAsync = ref.watch(performanceSummaryProvider);
    final categoryAsync = ref.watch(categoryPerformanceProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: Text(
          'QUIZ HISTORY',
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded, color: Colors.white70),
            onPressed: () => _showClearHistoryDialog(context, ref),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(historyListProvider);
          ref.invalidate(performanceSummaryProvider);
          ref.invalidate(categoryPerformanceProvider);
        },
        color: SoteriaColors.primary,
        backgroundColor: SoteriaColors.background,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.md)),
            SliverToBoxAdapter(child: HistoryFilterBar()),
            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

            summaryAsync.when(
              data: (summary) => SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                sliver: SliverToBoxAdapter(
                  child: summary.totalQuizzes > 0
                      ? PerformanceSummarySection(summary: summary)
                      : const SizedBox.shrink(),
                ),
              ),
              loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              error: (_, __) =>
                  const SliverToBoxAdapter(child: SizedBox.shrink()),
            ),

            categoryAsync.when(
              data: (performances) => SliverPadding(
                padding: EdgeInsets.all(SoteriaSpacing.lg),
                sliver: SliverToBoxAdapter(
                  child: (performances as List<CategoryPerformance>).isNotEmpty
                      ? CategoryPerformanceList(performances: performances)
                      : const SizedBox.shrink(),
                ),
              ),
              loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              error: (_, __) =>
                  const SliverToBoxAdapter(child: SizedBox.shrink()),
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'RECENT QUIZZES',
                  style: context.labelMedium.copyWith(
                    color: Colors.white70,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(SoteriaSpacing.lg),
              sliver: historyAsync.when(
                data: (results) {
                  if (results.isEmpty) {
                    return SliverToBoxAdapter(child: _EmptyState());
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => QuizHistoryCard(
                        result: results[index],
                        onTap: () => context.push(
                          '${SoteriaRoutes.quizHistory}/detail',
                          extra: results[index],
                        ),
                      ),
                      childCount: results.length,
                    ),
                  );
                },
                loading: () => SliverToBoxAdapter(child: _LoadingState()),
                error: (err, _) => SliverToBoxAdapter(
                  child: _ErrorState(message: err.toString()),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 100.h)),
          ],
        ),
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SoteriaColors.background,
        title: Text(
          'Clear Quiz History?',
          style: context.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This will permanently remove your saved quiz history from this device.',
          style: context.bodyMedium.copyWith(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'CANCEL',
              style: context.labelLarge.copyWith(color: Colors.white38),
            ),
          ),
          TextButton(
            onPressed: () {
              // Implementation of clear history
              Navigator.pop(context);
            },
            child: Text(
              'CLEAR HISTORY',
              style: context.labelLarge.copyWith(color: SoteriaColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40.h),
        Icon(Icons.history_rounded, size: 64.sp, color: Colors.white10),
        SizedBox(height: SoteriaSpacing.lg),
        Text(
          'No Quizzes Yet',
          style: context.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SoteriaSpacing.sm),
        Text(
          'Complete your first quiz to start building\nyour performance history.',
          textAlign: TextAlign.center,
          style: context.bodyMedium.copyWith(color: Colors.white38),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        ElevatedButton(
          onPressed: () => context.go(SoteriaRoutes.main),
          style: ElevatedButton.styleFrom(
            backgroundColor: SoteriaColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SoteriaRadius.md),
            ),
          ),
          child: const Text('START A QUIZ'),
        ),
      ],
    );
  }
}

class _LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          height: 100.h,
          margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(SoteriaRadius.lg),
          ),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: SoteriaColors.error,
            size: 48.sp,
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            'Unable to load quiz history',
            style: context.bodyLarge.copyWith(color: Colors.white),
          ),
          Text(
            message,
            style: context.bodySmall.copyWith(color: Colors.white38),
          ),
        ],
      ),
    );
  }
}
