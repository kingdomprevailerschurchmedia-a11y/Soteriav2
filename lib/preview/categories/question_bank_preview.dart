import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/design_system/colors/soteria_colors.dart';
import '../../core/design_system/spacing/soteria_spacing.dart';
import '../../core/design_system/typography/soteria_typography.dart';
import '../../core/widgets/glass_surface.dart';
import '../../features/question_content/domain/entities/question.dart';
import '../../features/question_content/data/seed/question_seed_data.dart';

class QuestionBankPreview extends StatelessWidget {
  const QuestionBankPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090514),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Question Bank Preview',
          style: context.titleLarge.copyWith(color: Colors.white),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        itemCount: QuestionSeedData.questions.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final q = QuestionSeedData.questions[index];
          return _QuestionCard(question: q);
        },
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final Question question;
  const _QuestionCard({required this.question});

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (question.status) {
      QuestionStatus.published => SoteriaColors.success,
      QuestionStatus.draft => SoteriaColors.muted,
      QuestionStatus.review => SoteriaColors.warning,
      _ => SoteriaColors.error,
    };

    return GlassSurface(
      borderRadius: BorderRadius.circular(20.r),
      opacity: 0.05,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    question.status.name.toUpperCase(),
                    style: context.labelSmall.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  '${question.difficulty.name.toUpperCase()} • ${question.categoryId}',
                  style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                ),
                const Spacer(),
                Text(
                  'v${question.version}',
                  style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              question.text,
              style: context.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            ...question.options.map((opt) {
              final isCorrect = question.correctOptionIds.contains(opt.id);
              return Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: isCorrect 
                    ? SoteriaColors.success.withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isCorrect 
                      ? SoteriaColors.success.withValues(alpha: 0.3)
                      : Colors.white.withValues(alpha: 0.05),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        opt.text,
                        style: context.bodyMedium.copyWith(
                          color: isCorrect ? SoteriaColors.success : Colors.white70,
                        ),
                      ),
                    ),
                    if (isCorrect)
                      const Icon(Icons.check_circle_outline, color: SoteriaColors.success, size: 16),
                  ],
                ),
              );
            }),
            if (question.explanation != null) ...[
              SizedBox(height: 8.h),
              Text(
                'Explanation:',
                style: context.labelMedium.copyWith(color: SoteriaColors.gold),
              ),
              SizedBox(height: 4.h),
              Text(
                question.explanation!,
                style: context.bodySmall.copyWith(color: SoteriaColors.muted),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
