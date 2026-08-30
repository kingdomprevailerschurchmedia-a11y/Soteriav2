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
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/design_system/gradients/soteria_gradients.dart';

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
    return Container(
      decoration: const BoxDecoration(
        gradient: SoteriaGradients.primaryBackground,
      ),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: SoteriaSpacing.md),
                SoteriaFadeIn(
                  child: RepaintBoundary(
                    child: _buildScoreHeader(context, result),
                  ),
                ),
                SizedBox(height: SoteriaSpacing.xl),
                
                SoteriaSlideUp(
                  delay: const Duration(milliseconds: 200),
                  child: _buildSectionHeader(context, 'Learning Insights'),
                ),
                SoteriaSlideUp(
                  delay: const Duration(milliseconds: 300),
                  child: RepaintBoundary(
                    child: _buildInsightsList(context, result),
                  ),
                ),
                SizedBox(height: SoteriaSpacing.xl),

                if (result.recommendation != null) ...[
                  SoteriaSlideUp(
                    delay: const Duration(milliseconds: 400),
                    child: _buildSectionHeader(context, 'Next Recommended Step'),
                  ),
                  SoteriaSlideUp(
                    delay: const Duration(milliseconds: 500),
                    child: RepaintBoundary(
                      child: _buildRecommendationCard(context, result.recommendation!),
                    ),
                  ),
                  SizedBox(height: SoteriaSpacing.xl),
                ],

                SoteriaSlideUp(
                  delay: const Duration(milliseconds: 600),
                  child: _buildSectionHeader(context, 'Category Performance'),
                ),
                ...result.categoryPerformance.values.map((p) => SoteriaSlideUp(
                  delay: const Duration(milliseconds: 700),
                  child: RepaintBoundary(
                    child: _buildCategoryRow(context, p),
                  ),
                )),
                
                SoteriaSlideUp(
                  delay: const Duration(milliseconds: 750),
                  child: _buildDetailedBreakdownRow(context),
                ),
                
                SizedBox(height: SoteriaSpacing.xl),

                SoteriaSlideUp(
                  delay: const Duration(milliseconds: 800),
                  child: _buildReviewSection(context, result),
                ),

                SizedBox(height: SoteriaSpacing.xl),

                SoteriaSlideUp(
                  delay: const Duration(milliseconds: 900),
                  child: _buildFinalSummaryCard(context, result),
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
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      title: Text(
        'Practice Results',
        style: context.titleMedium.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16.sp),
        ),
        onPressed: () => context.go(SoteriaRoutes.main),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }

  Widget _buildScoreHeader(BuildContext context, PracticeResult result) {
    return SoteriaCard(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Row(
        children: [
          _PracticeScoreCircularProgress(
            accuracy: result.accuracy,
          ),
          SizedBox(width: 24.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      result.accuracy >= 0.9 ? 'Exceptional!' : (result.accuracy >= 0.7 ? 'Great Job!' : 'Keep Practicing!'),
                      style: context.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text('🎉', style: TextStyle(fontSize: 16.sp)),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  result.accuracy >= 0.9 ? 'Mastery achieved.' : 'You\'re getting stronger.',
                  style: context.bodySmall.copyWith(color: Colors.white54),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _PracticeMetric(
                      label: 'CORRECT',
                      value: '${result.correctAnswers}',
                      color: SoteriaColors.success,
                    ),
                    _PracticeMetric(
                      label: 'XP',
                      value: '+${result.xpEarned}',
                      color: SoteriaColors.xpColor,
                    ),
                    _PracticeMetric(
                      label: 'COINS',
                      value: '+${result.coinsEarned}',
                      color: SoteriaColors.gold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsList(BuildContext context, PracticeResult result) {
    if (result.insights.isEmpty) {
      // Fallback mastery insight if list is empty
      return _buildInsightCard(context, const LearningInsight(
        title: 'Mastery Level',
        description: 'You demonstrated exceptional knowledge in this session.',
        type: LearningInsightType.strength,
        isPositive: true,
      ));
    }
    return Column(
      children: result.insights.map((insight) => _buildInsightCard(context, insight)).toList(),
    );
  }

  Widget _buildInsightCard(BuildContext context, LearningInsight insight) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: SoteriaCard(
        opacity: 0.05,
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            _HexagonIcon(
              color: insight.isPositive ? SoteriaColors.success : SoteriaColors.warning,
              icon: insight.isPositive ? Icons.check_rounded : Icons.info_rounded,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    insight.title,
                    style: context.labelMedium.copyWith(
                      color: insight.isPositive ? SoteriaColors.success : SoteriaColors.warning,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    insight.description,
                    style: context.bodySmall.copyWith(color: Colors.white70),
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
      padding: EdgeInsets.all(16.w),
      opacity: 0.1,
      borderColor: const Color(0xFF6B4EEA).withValues(alpha: 0.3),
      onTap: () {
        ref.read(practiceResultProvider.notifier).practiceAgain(rec);
        context.go(SoteriaRoutes.practiceSession);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SoteriaRadius.lg),
          gradient: LinearGradient(
            colors: [
              const Color(0xFF6B4EEA).withValues(alpha: 0.2),
              const Color(0xFF6B4EEA).withValues(alpha: 0.05),
            ],
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: const Color(0xFF6B4EEA).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(Icons.bolt_rounded, color: const Color(0xFF6B4EEA), size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rec.title,
                    style: context.titleSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2.h),
                  RichText(
                    text: TextSpan(
                      style: context.bodySmall.copyWith(color: Colors.white60),
                      children: [
                        const TextSpan(text: 'Try '),
                        TextSpan(
                          text: rec.difficulty.name.toUpperCase(),
                          style: const TextStyle(color: Color(0xFF6B4EEA), fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: ' for more challenge.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.white54, size: 24.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow(BuildContext context, CategoryPerformance p) {
    return SoteriaCard(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      opacity: 0.05,
      child: Row(
        children: [
          _HexagonIcon(
            color: const Color(0xFF6B4EEA),
            icon: _getCategoryIcon(p.categoryId),
            size: 40.r,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      p.categoryId.toUpperCase(),
                      style: context.labelMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${(p.accuracy * 100).toInt()}%',
                      style: context.labelMedium.copyWith(
                        color: SoteriaColors.success,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: LinearProgressIndicator(
                    value: p.accuracy,
                    minHeight: 6.h,
                    backgroundColor: Colors.white.withValues(alpha: 0.05),
                    valueColor: const AlwaysStoppedAnimation<Color>(SoteriaColors.success),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDetailedBreakdownRow(BuildContext context) {
    return SoteriaCard(
      opacity: 0.03,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      onTap: () {
        // Handle detailed breakdown
      },
      child: Row(
        children: [
          Icon(Icons.bar_chart_rounded, color: Colors.white54, size: 20.sp),
          SizedBox(width: 12.w),
          Text(
            'View detailed breakdown',
            style: context.bodySmall.copyWith(color: Colors.white54),
          ),
          const Spacer(),
          Icon(Icons.chevron_right_rounded, color: Colors.white54, size: 20.sp),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Text(
        title.toUpperCase(),
        style: context.labelSmall.copyWith(
          color: SoteriaColors.gold, 
          letterSpacing: 1.2, 
          fontWeight: FontWeight.bold,
          fontSize: 10.sp,
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context, PracticeResult result) {
    return GestureDetector(
      onTap: () => context.go(SoteriaRoutes.practice),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6B4EEA), Color(0xFF2E1A8A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6B4EEA).withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bolt_rounded, color: SoteriaColors.gold, size: 24.sp),
            SizedBox(width: 12.w),
            Text(
              'PRACTICE AGAIN',
              style: context.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(width: 12.w),
            Icon(Icons.chevron_right_rounded, color: Colors.white, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewSection(BuildContext context, PracticeResult result) {
    var items = result.reviewItems;
    if (_reviewFilter == 'incorrect') {
      items = items.where((i) => !i.isCorrect).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionHeader(context, 'Question Review'),
            Row(
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
            ),
          ],
        ),
        SizedBox(height: 16.h),
        if (items.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Text(
                'No questions to show.',
                style: context.bodySmall.copyWith(color: Colors.white38),
              ),
            ),
          )
        else
          ...items.asMap().entries.map((entry) {
            return _buildReviewCard(context, entry.key + 1, entry.value);
          }),
      ],
    );
  }

  Widget _buildReviewCard(BuildContext context, int number, QuestionReviewItem item) {
    return RepaintBoundary(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1638).withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF6B4EEA).withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6B4EEA).withValues(alpha: 0.05),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: item.isCorrect ? SoteriaColors.success : SoteriaColors.error,
                  width: 1,
                ),
              ),
              child: Icon(
                item.isCorrect ? Icons.check_rounded : Icons.close_rounded,
                color: item.isCorrect ? SoteriaColors.success : SoteriaColors.error,
                size: 16.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6B4EEA).withValues(alpha: 0.6),
                    const Color(0xFF2E1A8A).withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: context.titleSmall.copyWith(
                    color: Colors.white,
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
                    'Question $number',
                    style: context.labelSmall.copyWith(
                      color: item.isCorrect ? SoteriaColors.success : SoteriaColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    item.questionText,
                    style: context.bodySmall.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 20.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinalSummaryCard(BuildContext context, PracticeResult result) {
    return SoteriaCard(
      padding: EdgeInsets.all(20.w),
      opacity: 0.1,
      child: Row(
        children: [
          Container(
            width: 56.r,
            height: 56.r,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6B4EEA).withValues(alpha: 0.4),
                  const Color(0xFF2E1A8A).withValues(alpha: 0.6),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(Icons.assignment_turned_in_rounded, color: const Color(0xFF6B4EEA), size: 28.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.accuracy >= 0.9 ? 'Great Job!' : 'Session Complete',
                  style: context.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  result.correctAnswers == result.totalQuestions 
                    ? 'You answered all questions correctly.'
                    : 'Review your results to improve.',
                  style: context.bodySmall.copyWith(color: Colors.white54),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          _PracticeScoreCircularProgressSmall(accuracy: result.accuracy),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String categoryId) {
    switch (categoryId.toLowerCase()) {
      case 'science':
        return Icons.science_rounded;
      case 'history':
        return Icons.history_edu_rounded;
      case 'math':
        return Icons.calculate_rounded;
      default:
        return Icons.lightbulb_rounded;
    }
  }
}

class _PracticeScoreCircularProgress extends StatelessWidget {
  const _PracticeScoreCircularProgress({required this.accuracy});
  final double accuracy;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.r,
      height: 120.r,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer Glow
          Container(
            width: 110.r,
            height: 110.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: SoteriaColors.gold.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          // Circular Progress
          SizedBox(
            width: 100.r,
            height: 100.r,
            child: CircularProgressIndicator(
              value: accuracy,
              strokeWidth: 8.r,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation<Color>(SoteriaColors.gold),
            ),
          ),
          // Score text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(accuracy * 100).toInt()}%',
                style: context.titleLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
              ),
              Text(
                'ACCURACY',
                style: context.labelSmall.copyWith(
                  color: Colors.white54,
                  fontSize: 8.sp,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          // Bottom Star Badge
          Positioned(
            bottom: -5.r,
            child: Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1638),
                shape: BoxShape.circle,
                border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.5), width: 1),
              ),
              child: _HexagonIcon(
                color: SoteriaColors.gold,
                icon: Icons.star_rounded,
                size: 20.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PracticeScoreCircularProgressSmall extends StatelessWidget {
  const _PracticeScoreCircularProgressSmall({required this.accuracy});
  final double accuracy;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64.r,
      height: 64.r,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 60.r,
            height: 60.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF6B4EEA).withValues(alpha: 0.2), width: 4.r),
            ),
          ),
          SizedBox(
            width: 60.r,
            height: 60.r,
            child: CircularProgressIndicator(
              value: accuracy,
              strokeWidth: 4.r,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(SoteriaColors.gold),
            ),
          ),
          // Add glow
          Container(
            width: 50.r,
            height: 50.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: SoteriaColors.gold.withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(accuracy * 100).toInt()}%',
                style: context.labelMedium.copyWith(
                  color: SoteriaColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ACCURACY',
                style: context.labelSmall.copyWith(
                  color: Colors.white38,
                  fontSize: 6.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PracticeMetric extends StatelessWidget {
  const _PracticeMetric({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: context.titleMedium.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: Colors.white38,
            fontSize: 8.sp,
          ),
        ),
      ],
    );
  }
}

class _HexagonIcon extends StatelessWidget {
  const _HexagonIcon({
    required this.color,
    required this.icon,
    this.size = 48,
  });
  final Color color;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _HexagonPainter(
          color: color,
          glowColor: color.withValues(alpha: 0.3),
        ),
        child: Center(
          child: Icon(icon, color: color, size: (size * 0.5).sp),
        ),
      ),
    );
  }
}

class _HexagonPainter extends CustomPainter {
  _HexagonPainter({required this.color, required this.glowColor});
  final Color color;
  final Color glowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final glowPaint = Paint()
      ..color = glowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 4);

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.5, 0);
    path.lineTo(w, h * 0.25);
    path.lineTo(w, h * 0.75);
    path.lineTo(w * 0.5, h);
    path.lineTo(0, h * 0.75);
    path.lineTo(0, h * 0.25);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _HexagonPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.glowColor != glowColor;
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
