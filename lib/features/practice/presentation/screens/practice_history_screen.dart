import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'package:soteria/core/design_system/animations/soteria_animation_widgets.dart';
import 'package:soteria/core/design_system/components/soteria_back_button.dart';
import 'package:soteria/features/practice/presentation/providers/practice_history_providers.dart';
import 'package:soteria/features/practice/presentation/widgets/history/practice_performance_widgets.dart';
import 'package:soteria/features/practice/domain/models/practice_result.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';

class PracticeHistoryScreen extends ConsumerWidget {
  const PracticeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(practiceHistoryProvider);

    return SafeGradientScaffold(
      body: historyAsync.when(
        data: (history) => _buildContent(context, ref, history),
        loading: () => const Center(child: SoteriaLoader()),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, dynamic history) {
    if (history.totalSessions == 0) {
      return _buildEmptyState(context);
    }

    return CustomScrollView(
      cacheExtent: 1000,
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildAppBar(context),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              RepaintBoundary(child: SoteriaFadeIn(child: PracticeSummaryHeader(history: history))),
              SoteriaSpacing.gapLG,
              RepaintBoundary(
                child: SoteriaSlideUp(
                  delay: const Duration(milliseconds: 100),
                  child: PracticeTrendChart(trends: history.trends),
                ),
              ),
              SoteriaSpacing.gapLG,
              RepaintBoundary(
                child: SoteriaSlideUp(
                  delay: const Duration(milliseconds: 200),
                  child: CategoryPerformanceList(history: history),
                ),
              ),
              SoteriaSpacing.gapXL,
              Text(
                'RECENT SESSIONS',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.gold,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              SoteriaSpacing.gapMD,
            ]),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final session = history.recentSessions[index];
                return RepaintBoundary(
                  child: SoteriaSlideUp(
                    delay: Duration(milliseconds: 300 + (index * 50)),
                    child: _buildSessionCard(context, session),
                  ),
                );
              },
              childCount: history.recentSessions.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SoteriaSpacing.gapXL),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      title: Text(
        'Practice Journey',
        style: context.titleLarge.copyWith(color: SoteriaColors.gold),
      ),
      backgroundColor: SoteriaColors.backgroundBottomRight,
      elevation: 0,
      pinned: true,
      floating: true,
      leadingWidth: 60,
      leading: const Padding(
        padding: EdgeInsets.only(left: 16),
        child: Center(child: SoteriaBackButton()),
      ),
    );
  }

  Widget _buildSessionCard(BuildContext context, PracticeResult session) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: SoteriaCard(
        onTap: () {
          // Navigate to detail
          context.push('${SoteriaRoutes.practiceHistory}/${session.sessionId}', extra: session);
        },
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: _getAccuracyColor(session.accuracy).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${(session.accuracy * 100).toInt()}%',
                  style: context.labelMedium.copyWith(
                    color: _getAccuracyColor(session.accuracy),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatCategories(session),
                    style: context.labelLarge.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${session.totalQuestions} Questions • ${DateFormat('MMM d, h:mm a').format(session.completedAt)}',
                    style: context.bodySmall.copyWith(color: Colors.white38),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.white24, size: 24.sp),
          ],
        ),
      ),
    );
  }

  String _formatCategories(PracticeResult session) {
    if (session.categoryPerformance.isEmpty) return 'General Practice';
    return session.categoryPerformance.keys.take(2).join(', ').toUpperCase();
  }

  Color _getAccuracyColor(double accuracy) {
    if (accuracy >= 0.8) return SoteriaColors.success;
    if (accuracy >= 0.6) return SoteriaColors.warning;
    return SoteriaColors.error;
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SoteriaSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_edu_rounded, size: 80.sp, color: Colors.white10),
            SizedBox(height: SoteriaSpacing.xl),
            Text(
              'Your Practice journey starts here.',
              style: context.titleMedium.copyWith(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SoteriaSpacing.lg),
            Text(
              'Complete your first session to see your performance history and insights.',
              style: context.bodyMedium.copyWith(color: Colors.white38),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SoteriaSpacing.xxl),
            ElevatedButton(
              onPressed: () => context.go(SoteriaRoutes.practice),
              style: ElevatedButton.styleFrom(
                backgroundColor: SoteriaColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
              ),
              child: const Text('START PRACTICING'),
            ),
          ],
        ),
      ),
    );
  }
}
