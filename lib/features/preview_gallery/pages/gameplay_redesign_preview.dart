import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_badge.dart';
import 'package:soteria/core/design_system/components/soteria_progress_bar.dart';
import 'package:soteria/features/preview_gallery/widgets/preview_wrapper.dart';
import 'package:soteria/features/preview_gallery/models/mock_data_factory.dart';

class GameplayRedesignPreview extends StatelessWidget {
  const GameplayRedesignPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final questions = MockDataFactory.createMockQuestions(10);
    final currentQuestion = questions[0];

    return PreviewWrapper(
      title: 'Gameplay Redesign',
      builder: (context, state) {
        return Column(
          children: [
            _buildHeader(context),
            SizedBox(height: SoteriaSpacing.md),
            _buildProgressArea(context),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(SoteriaSpacing.lg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildQuestionCard(context, currentQuestion),
                    SizedBox(height: SoteriaSpacing.xxl),
                    _buildAnswerOptions(context, currentQuestion),
                  ],
                ),
              ),
            ),
            _buildLifelines(context),
            SizedBox(height: SoteriaSpacing.xl),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.lg,
        vertical: SoteriaSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                color: SoteriaColors.gold,
                size: 18,
              ),
              SizedBox(width: 8.w),
              Text(
                '1,250',
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          _TimerDisplay(remaining: 24, total: 30),
          Row(
            children: [
              const Icon(
                Icons.favorite_rounded,
                color: SoteriaColors.error,
                size: 18,
              ),
              SizedBox(width: 4.w),
              Text(
                '3',
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressArea(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'QUESTION 4 OF 10',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SoteriaBadge(
                label: 'MEDIUM',
                variant: SoteriaBadgeVariant.info,
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.sm),
          const SoteriaProgressBar(progress: 0.4, hasGlow: true),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, dynamic question) {
    return SoteriaCard(
      hasGlow: true,
      borderColor: SoteriaColors.primary.withValues(alpha: 0.1),
      child: Column(
        children: [
          Text(
            question.text,
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 22.sp,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOptions(BuildContext context, dynamic question) {
    return Column(
      children: question.options.map<Widget>((option) {
        return Padding(
          padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
          child: SoteriaCard(
            padding: EdgeInsets.symmetric(
              horizontal: SoteriaSpacing.lg,
              vertical: SoteriaSpacing.md,
            ),
            borderColor: Colors.white.withValues(alpha: 0.05),
            child: Row(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'A',
                      style: context.labelMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: SoteriaSpacing.md),
                Expanded(
                  child: Text(
                    option.text,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLifelines(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LifelineItem(icon: Icons.exposure_minus_1_rounded, label: '50/50'),
        SizedBox(width: SoteriaSpacing.xl),
        _LifelineItem(icon: Icons.people_outline_rounded, label: 'AUDIENCE'),
        SizedBox(width: SoteriaSpacing.xl),
        _LifelineItem(icon: Icons.pause_circle_outline_rounded, label: 'PAUSE'),
      ],
    );
  }
}

class _TimerDisplay extends StatelessWidget {
  final int remaining;
  final int total;
  const _TimerDisplay({required this.remaining, required this.total});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 48.w,
          height: 48.w,
          child: CircularProgressIndicator(
            value: remaining / total,
            strokeWidth: 4,
            backgroundColor: Colors.white10,
            color: remaining < 5 ? SoteriaColors.error : SoteriaColors.primary,
          ),
        ),
        Text(
          remaining.toString(),
          style: context.labelLarge.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _LifelineItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _LifelineItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: SoteriaColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white10),
          ),
          child: Icon(icon, color: Colors.white70, size: 24.sp),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
