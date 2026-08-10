import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/radius/soteria_radius.dart';
import '../../../domain/models/quiz_result.dart';
import '../../../domain/models/quiz_enums.dart';

class QuizHistoryCard extends StatelessWidget {
  const QuizHistoryCard({super.key, required this.result, required this.onTap});

  final QuizResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Material(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(SoteriaRadius.lg),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(SoteriaRadius.lg),
          child: Container(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(SoteriaRadius.lg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _CategoryBadge(category: result.category),
                    const Spacer(),
                    Text(
                      _formatDate(result.completedAt),
                      style: context.labelSmall.copyWith(color: Colors.white38),
                    ),
                  ],
                ),
                SizedBox(height: SoteriaSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result.gameMode.name.toUpperCase(),
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.secondary,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${result.finalScore} PTS',
                          style: context.titleLarge.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.bolt_rounded,
                              color: SoteriaColors.primary,
                              size: 14.sp,
                            ),
                            Text(
                              '+${result.xpEarned} XP',
                              style: context.labelMedium.copyWith(
                                color: SoteriaColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: _getRatingColor(
                              result.accuracy,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${(result.accuracy * 100).round()}% ACCURACY',
                            style: context.labelSmall.copyWith(
                              color: _getRatingColor(result.accuracy),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final d = DateTime(date.year, date.month, date.day);

    if (d == today) {
      return 'Today · ${DateFormat.Hm().format(date)}';
    } else if (d == yesterday) {
      return 'Yesterday · ${DateFormat.Hm().format(date)}';
    } else {
      return DateFormat('MMM d · Hm').format(date);
    }
  }

  Color _getRatingColor(double accuracy) {
    if (accuracy >= 0.9) return SoteriaColors.success;
    if (accuracy >= 0.7) return SoteriaColors.warning;
    return SoteriaColors.error;
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(SoteriaRadius.sm),
      ),
      child: Text(
        category,
        style: context.labelSmall.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
