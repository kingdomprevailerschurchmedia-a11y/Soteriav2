import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/features/personalization/providers/personalization_notifier.dart';

class StepSummary extends ConsumerWidget {
  const StepSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalizationProvider);
    final notifier = ref.read(personalizationProvider.notifier);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      children: [
        SizedBox(height: SoteriaSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Review ',
                      style: context.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'your profile',
                      style: context.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                        color: const Color(0xFF7C4DFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, top: 4.h),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Color(0xFF7C4DFF),
                size: 24,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'Tell us about yourself so we can personalize your experience.',
          style: context.bodySmall.copyWith(
            color: SoteriaColors.textSecondary.withValues(alpha: 0.6),
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: SoteriaSpacing.xl),

        // Academic Level Section
        _SummarySection(
          title: 'Academic Level',
          icon: Icons.school_outlined,
          onEdit: () => notifier.setStep(0),
          child: _buildAcademicLevel(context, state.academicLevel),
        ),

        SizedBox(height: 24.h),

        // Interests Section
        _SummarySection(
          title: 'Interests',
          icon: Icons.star_outline_rounded,
          onEdit: () => notifier.setStep(1),
          child: _buildInterests(context, state.interests, (i) => notifier.toggleInterest(i)),
        ),

        SizedBox(height: 24.h),

        // Goals Section
        _SummarySection(
          title: 'Your Goals',
          icon: Icons.track_changes_rounded,
          onEdit: () => notifier.setStep(2),
          child: _buildGoals(context, state.goals),
        ),

        SizedBox(height: 40.h),
      ],
    );
  }

  Widget _buildAcademicLevel(BuildContext context, String? level) {
    final icon = switch (level) {
      'Secondary School' => Icons.school_rounded,
      'University' => Icons.account_balance_rounded,
      'Graduate' => Icons.workspace_premium_rounded,
      'Professional' => Icons.business_center_rounded,
      'General Knowledge' => Icons.menu_book_rounded,
      _ => Icons.help_outline_rounded,
    };

    final subtitle = switch (level) {
      'Secondary School' => 'High school / Secondary education',
      'University' => 'Undergraduate degree',
      'Graduate' => 'Master\'s / Postgraduate',
      'Professional' => 'Working professional / Vocational',
      'General Knowledge' => 'Build a strong foundation across various topics.',
      _ => '',
    };

    return GlassSurface(
      borderRadius: BorderRadius.circular(20.r),
      opacity: 0.05,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: const Color(0xFF7C4DFF), size: 24.w),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level ?? 'Not selected',
                    style: context.titleMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: context.bodySmall.copyWith(
                        color: SoteriaColors.textSecondary.withValues(alpha: 0.6),
                        fontSize: 12.sp,
                      ),
                    ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: const Color(0xFF7C4DFF), size: 24.w),
          ],
        ),
      ),
    );
  }

  Widget _buildInterests(BuildContext context, Set<String> interests, Function(String) onRemove) {
    return GlassSurface(
      borderRadius: BorderRadius.circular(20.r),
      opacity: 0.05,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: [
            ...interests.map((interest) {
              final icon = switch (interest) {
                'Science' => Icons.science_outlined,
                'Technology' => Icons.computer_rounded,
                'Business' => Icons.business_center_outlined,
                'Medicine' => Icons.favorite_border_rounded,
                'Arts' => Icons.palette_outlined,
                'History' => Icons.account_balance_outlined,
                'Sports' => Icons.sports_basketball_outlined,
                'Current Affairs' => Icons.newspaper_rounded,
                'Programming' => Icons.code_rounded,
                'Mathematics' => Icons.calculate_outlined,
                'Engineering' => Icons.settings_outlined,
                'Languages' => Icons.chat_bubble_outline_rounded,
                'Law' => Icons.gavel_rounded,
                'Finance' => Icons.bar_chart_rounded,
                'Psychology' => Icons.psychology_outlined,
                'Design' => Icons.brush_rounded,
                _ => Icons.star_border_rounded,
              };

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF5B3FD9).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFF7C4DFF).withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 16.w, color: Colors.white),
                    SizedBox(width: 8.w),
                    Text(
                      interest,
                      style: context.labelMedium.copyWith(color: Colors.white),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => onRemove(interest),
                      child: Icon(Icons.close, size: 14.w, color: Colors.white.withValues(alpha: 0.6)),
                    ),
                  ],
                ),
              );
            }),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2), style: BorderStyle.solid),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: 16.w, color: SoteriaColors.textSecondary),
                  SizedBox(width: 4.w),
                  Text(
                    'Add more',
                    style: context.labelMedium.copyWith(color: SoteriaColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoals(BuildContext context, Set<String> goals) {
    return GlassSurface(
      borderRadius: BorderRadius.circular(20.r),
      opacity: 0.05,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: goals.map((goal) {
            final icon = switch (goal) {
              'Practice Daily' => Icons.timer_outlined,
              'Improve GPA' => Icons.trending_up_rounded,
              'Prepare for Exams' => Icons.assignment_outlined,
              'Compete Nationally' => Icons.emoji_events_outlined,
              'Earn Rewards' => Icons.card_giftcard_rounded,
              'Learn New Things' => Icons.lightbulb_outline_rounded,
              _ => Icons.track_changes_rounded,
            };

            final subtitle = switch (goal) {
              'Practice Daily' => 'Build a consistent learning habit.',
              'Improve GPA' => 'Achieve better academic results.',
              'Prepare for Exams' => 'Targeted practice for success.',
              'Compete Nationally' => 'Rise through the ranks.',
              'Earn Rewards' => 'Unlock badges, coins, and prizes.',
              'Learn New Things' => 'Explore topics that inspire you.',
              _ => '',
            };

            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C4DFF).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(icon, color: const Color(0xFF7C4DFF), size: 20.w),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goal,
                          style: context.titleMedium.copyWith(color: Colors.white, fontSize: 16.sp),
                        ),
                        if (subtitle.isNotEmpty)
                          Text(
                            subtitle,
                            style: context.bodySmall.copyWith(
                              color: SoteriaColors.textSecondary.withValues(alpha: 0.6),
                              fontSize: 12.sp,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: SoteriaColors.gold, width: 1.5),
                    ),
                    child: const Icon(Icons.check, color: SoteriaColors.gold, size: 16),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({
    required this.title,
    required this.icon,
    required this.child,
    required this.onEdit,
  });

  final String title;
  final IconData icon;
  final Widget child;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: SoteriaColors.gold, size: 18.w),
                SizedBox(width: 8.w),
                Text(
                  title.toUpperCase(),
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.gold,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: onEdit,
              child: Row(
                children: [
                  Text(
                    'Edit',
                    style: TextStyle(color: const Color(0xFF7C4DFF), fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.edit_outlined, color: const Color(0xFF7C4DFF), size: 16.w),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        child,
      ],
    );
  }
}
