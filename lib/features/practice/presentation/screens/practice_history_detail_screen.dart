import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_back_button.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/features/practice/domain/models/practice_result.dart';

class PracticeHistoryDetailScreen extends ConsumerWidget {
  final PracticeResult result;

  const PracticeHistoryDetailScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeGradientScaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          SliverPadding(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildScoreHeader(context),
                SizedBox(height: SoteriaSpacing.xl),
                _buildSectionHeader(context, 'Category Performance'),
                ...result.categoryPerformance.values.map((p) => _buildCategoryRow(context, p)),
                SizedBox(height: SoteriaSpacing.xl),
                _buildSectionHeader(context, 'Question Review'),
                _buildReviewList(context),
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
        'Practice Details',
        style: context.titleLarge.copyWith(color: SoteriaColors.gold),
      ),
      backgroundColor: Colors.transparent,
      leadingWidth: 60,
      leading: const Padding(
        padding: EdgeInsets.only(left: 16),
        child: Center(child: SoteriaBackButton()),
      ),
    );
  }

  Widget _buildScoreHeader(BuildContext context) {
    return SoteriaCard(
      child: Column(
        children: [
          Text(
            DateFormat('MMMM d, yyyy • h:mm a').format(result.completedAt),
            style: context.labelSmall.copyWith(color: Colors.white38),
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            '${(result.accuracy * 100).toStringAsFixed(0)}%',
            style: context.headlineLarge.copyWith(color: SoteriaColors.gold, fontWeight: FontWeight.bold, fontSize: 48.sp),
          ),
          Text(
            'ACCURACY',
            style: context.labelSmall.copyWith(color: Colors.white38, letterSpacing: 2),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetric('CORRECT', '${result.correctAnswers}', SoteriaColors.success),
              _buildMetric('INCORRECT', '${result.incorrectAnswers}', SoteriaColors.error),
              _buildMetric('TIME', _formatDuration(result.totalTime), SoteriaColors.primary),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '${minutes}m ${seconds}s';
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 24.sp)),
        Text(label, style: TextStyle(color: Colors.white38, fontSize: 10.sp, fontWeight: FontWeight.w600)),
      ],
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

  Widget _buildReviewList(BuildContext context) {
    return Column(
      children: result.reviewItems.asMap().entries.map((entry) {
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
}
