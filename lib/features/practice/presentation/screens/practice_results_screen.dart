import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/widgets/feedback/soteria_loader.dart';
import '../../../gameplay_engine/models/game_state.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../providers/practice_providers.dart';
import '../states/practice_result_state.dart';
import '../../domain/models/practice_result.dart';
import '../../../../core/navigation/soteria_routes.dart';

class PracticeResultsScreen extends ConsumerStatefulWidget {
  const PracticeResultsScreen({super.key, required this.gameState});

  final GameState gameState;

  @override
  ConsumerState<PracticeResultsScreen> createState() => _PracticeResultsScreenState();
}

class _PracticeResultsScreenState extends ConsumerState<PracticeResultsScreen> {
  String _reviewFilter = 'all';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(practiceResultProvider.notifier).finalize(widget.gameState);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(practiceResultProvider);

    return SafeGradientScaffold(
      body: state.when(
        initial: () => const Center(child: SoteriaLoader()),
        calculating: () => const Center(child: SoteriaLoader()),
        error: (msg) => Center(child: Text('Error: $msg', style: const TextStyle(color: Colors.white))),
        success: (result) => _buildContent(context, result),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PracticeResult result) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildAppBar(context),
        SliverPadding(
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              SoteriaFadeIn(
                child: _buildScoreHeader(context, result),
              ),
              SizedBox(height: SoteriaSpacing.xl),
              
              if (result.insights.isNotEmpty) ...[
                SoteriaSlideUp(
                  delay: const Duration(milliseconds: 200),
                  child: _buildSectionHeader(context, 'Learning Insights'),
                ),
                SoteriaSlideUp(
                  delay: const Duration(milliseconds: 300),
                  child: _buildInsightsList(context, result),
                ),
                SizedBox(height: SoteriaSpacing.xl),
              ],

              if (result.recommendation != null) ...[
                SoteriaSlideUp(
                  delay: const Duration(milliseconds: 400),
                  child: _buildSectionHeader(context, 'Next Recommended Step'),
                ),
                SoteriaSlideUp(
                  delay: const Duration(milliseconds: 500),
                  child: _buildRecommendationCard(context, result.recommendation!),
                ),
                SizedBox(height: SoteriaSpacing.xl),
              ],

              SoteriaSlideUp(
                delay: const Duration(milliseconds: 600),
                child: _buildSectionHeader(context, 'Category Performance'),
              ),
              ...result.categoryPerformance.values.map((p) => SoteriaSlideUp(
                delay: const Duration(milliseconds: 700),
                child: _buildCategoryRow(context, p),
              )),
              SizedBox(height: SoteriaSpacing.xl),

              SoteriaSlideUp(
                delay: const Duration(milliseconds: 800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSectionHeader(context, 'Question Review'),
                    _buildReviewFilter(context),
                  ],
                ),
              ),
              SoteriaSlideUp(
                delay: const Duration(milliseconds: 900),
                child: _buildReviewList(context, result),
              ),
              SizedBox(height: SoteriaSpacing.xl),

              SoteriaSlideUp(
                delay: const Duration(milliseconds: 1000),
                child: _buildActions(context, result),
              ),
              SizedBox(height: SoteriaSpacing.xxl),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      title: Text(
        'Practice Results',
        style: context.titleLarge.copyWith(color: SoteriaColors.gold),
      ),
      backgroundColor: SoteriaColors.backgroundBottomRight,
      pinned: true,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildScoreHeader(BuildContext context, PracticeResult result) {
    return SoteriaCard(
      child: Column(
        children: [
          Text(
            '${(result.accuracy * 100).toStringAsFixed(0)}%',
            style: context.headlineLarge.copyWith(color: SoteriaColors.gold, fontWeight: FontWeight.bold, fontSize: 48.sp),
          ),
          Text(
            'ACCURACY',
            style: context.labelSmall.copyWith(color: Colors.white38, letterSpacing: 2),
          ),
          SizedBox(height: 8.h),
          Text(
            result.performanceMessage ?? '',
            style: context.bodyMedium.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SoteriaSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetric('CORRECT', '${result.correctAnswers}', SoteriaColors.success),
              _buildMetric('INCORRECT', '${result.incorrectAnswers}', SoteriaColors.error),
              _buildMetric('XP', '+${result.xpEarned}', SoteriaColors.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 24.sp)),
        Text(label, style: TextStyle(color: Colors.white38, fontSize: 10.sp, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildInsightsList(BuildContext context, PracticeResult result) {
    return Column(
      children: result.insights.map((insight) => _buildInsightCard(context, insight)).toList(),
    );
  }

  Widget _buildInsightCard(BuildContext context, LearningInsight insight) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: SoteriaCard(
        opacity: 0.03,
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Icon(
              insight.isPositive ? Icons.check_circle_outline_rounded : Icons.info_outline_rounded,
              color: insight.isPositive ? SoteriaColors.success : SoteriaColors.warning,
              size: 24.sp,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    insight.title,
                    style: context.labelSmall.copyWith(
                      color: insight.isPositive ? SoteriaColors.success : SoteriaColors.warning,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    insight.description,
                    style: context.bodyMedium.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(BuildContext context, PracticeRecommendation rec) {
    return SoteriaCard(
      isElevated: true,
      glowColor: SoteriaColors.primary,
      hasGlow: true,
      padding: EdgeInsets.all(20.w),
      onTap: () {
        ref.read(practiceResultProvider.notifier).practiceAgain(rec);
        context.go(SoteriaRoutes.practiceSession);
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rec.title,
                  style: context.titleMedium.copyWith(color: SoteriaColors.gold, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                Text(
                  rec.description,
                  style: context.bodySmall.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Icon(Icons.arrow_forward_ios_rounded, color: SoteriaColors.gold, size: 16.sp),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(BuildContext context, CategoryPerformance p) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(p.categoryId.toUpperCase(), style: context.labelMedium.copyWith(color: Colors.white70)),
          ),
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: p.accuracy,
                backgroundColor: Colors.white10,
                valueColor: AlwaysStoppedAnimation<Color>(
                  p.accuracy >= 0.8 ? SoteriaColors.success : (p.accuracy >= 0.5 ? SoteriaColors.warning : SoteriaColors.error),
                ),
                minHeight: 8.h,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text('${(p.accuracy * 100).toStringAsFixed(0)}%', style: context.labelSmall.copyWith(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildReviewFilter(BuildContext context) {
    return Row(
      children: [
        _FilterChip(
          label: 'ALL',
          isSelected: _reviewFilter == 'all',
          onTap: () => setState(() => _reviewFilter = 'all'),
        ),
        SizedBox(width: 8.w),
        _FilterChip(
          label: 'INCORRECT',
          isSelected: _reviewFilter == 'incorrect',
          onTap: () => setState(() => _reviewFilter = 'incorrect'),
        ),
      ],
    );
  }

  Widget _buildReviewList(BuildContext context, PracticeResult result) {
    var items = result.reviewItems;
    if (_reviewFilter == 'incorrect') {
      items = items.where((i) => !i.isCorrect).toList();
    }

    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: Text('No questions to show.', style: context.bodySmall.copyWith(color: Colors.white38)),
        ),
      );
    }

    return Column(
      children: items.asMap().entries.map((entry) {
        final i = entry.key;
        final item = entry.value;
        return _buildReviewCard(context, i + 1, item);
      }).toList(),
    );
  }

  Widget _buildReviewCard(BuildContext context, int number, QuestionReviewItem item) {
    return Card(
      color: Colors.white.withValues(alpha: 0.05),
      margin: EdgeInsets.only(bottom: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
        title: Text('Question $number', style: context.labelLarge.copyWith(color: item.isCorrect ? SoteriaColors.success : (item.isSkipped ? Colors.white38 : SoteriaColors.error))),
        subtitle: Text(item.questionText, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.bodySmall.copyWith(color: Colors.white60)),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.questionText, style: context.bodyMedium.copyWith(color: Colors.white)),
                SizedBox(height: 16.h),
                if (item.explanation != null) ...[
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: SoteriaColors.gold.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb_outline_rounded, color: SoteriaColors.gold, size: 16.sp),
                            SizedBox(width: 8.w),
                            Text('EXPLANATION', style: context.labelSmall.copyWith(color: SoteriaColors.gold, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(item.explanation!, style: context.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.9), height: 1.4)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.md),
      child: Text(
        title.toUpperCase(),
        style: context.labelSmall.copyWith(color: SoteriaColors.gold, letterSpacing: 1.5, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildActions(BuildContext context, PracticeResult result) {
    return Column(
      children: [
        SoteriaButton.primary(
          label: 'PRACTICE AGAIN',
          onPressed: () => context.go(SoteriaRoutes.practice),
          size: SoteriaButtonSize.lg,
          icon: Icons.refresh_rounded,
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.secondary(
          label: 'VIEW HISTORY',
          onPressed: () => context.push(SoteriaRoutes.practiceHistory),
          size: SoteriaButtonSize.lg,
          icon: Icons.history_rounded,
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.secondary(
          label: 'RETURN HOME',
          onPressed: () => context.go(SoteriaRoutes.main),
          size: SoteriaButtonSize.lg,
          icon: Icons.home_rounded,
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? SoteriaColors.gold : Colors.white10,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: context.labelSmall.copyWith(
            color: isSelected ? Colors.black : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
