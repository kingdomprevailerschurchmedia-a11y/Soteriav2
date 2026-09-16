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

    return RepaintBoundary(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 40.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Review ',
                  style: context.headlineMedium.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 28.sp,
                    color: const Color(0xFF2E1A8A),
                  ),
                ),
                TextSpan(
                  text: 'your profile',
                  style: context.headlineMedium.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 28.sp,
                    color: SoteriaColors.gold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tell us about yourself so we can personalize\nyour experience and recommendations.',
            style: context.bodyLarge.copyWith(
              color: const Color(0xFF2E1A8A).withValues(alpha: 0.6),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24.h),

          // Academic Level Section
          _SummarySection(
            title: 'Academic Level',
            icon: Icons.school_outlined,
            onEdit: () => notifier.setStep(0),
            child: _buildAcademicLevel(context, state.academicLevel),
          ),

          SizedBox(height: 16.h),

          // Interests Section
          _SummarySection(
            title: 'Interests',
            icon: Icons.star_outline_rounded,
            onEdit: () => notifier.setStep(1),
            child: _buildInterests(
              context,
              state.interests,
              (i) => notifier.toggleInterest(i),
            ),
          ),

          SizedBox(height: 16.h),

          // Goals Section
          _SummarySection(
            title: 'Your Goals',
            icon: Icons.track_changes_rounded,
            onEdit: () => notifier.setStep(2),
            child: _buildGoals(context, state.goals),
          ),

          SizedBox(height: 24.h),
        ],
      ),
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

    return Container(
      height: 74.h,
      decoration: BoxDecoration(
        color: SoteriaColors.gold.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: SoteriaColors.gold.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: SoteriaColors.gold.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: const Color(0xFFF3EFFF),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(icon, color: const Color(0xFF2E1A8A), size: 20.w),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    level ?? 'Not selected',
                    style: context.titleMedium.copyWith(
                      color: const Color(0xFF2E1A8A),
                      fontWeight: FontWeight.w900,
                      fontSize: 14.sp,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodySmall.copyWith(
                        color: const Color(0xFF2E1A8A).withValues(alpha: 0.5),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF3EFFF),
              ),
              child: const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF2E1A8A),
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterests(
    BuildContext context,
    Set<String> interests,
    Function(String) onRemove,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
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
                  color: SoteriaColors.gold.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: SoteriaColors.gold.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: SoteriaColors.gold.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 16.w, color: const Color(0xFF2E1A8A)),
                    SizedBox(width: 8.w),
                    Text(
                      interest,
                      style: context.bodyMedium.copyWith(
                        color: const Color(0xFF2E1A8A),
                        fontWeight: FontWeight.w800,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => onRemove(interest),
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFF3EFFF),
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          size: 12.w,
                          color: const Color(0xFF2E1A8A),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: () {}, // Handled by SummarySection Edit
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: const Color(0xFF8A55FD).withValues(alpha: 0.3),
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  size: 16.w,
                  color: const Color(0xFF8A55FD),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Add more',
                  style: context.labelMedium.copyWith(
                    color: const Color(0xFF8A55FD),
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoals(BuildContext context, Set<String> goals) {
    return Column(
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

        return Container(
          height: 66.h,
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            color: SoteriaColors.gold.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: SoteriaColors.gold.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: SoteriaColors.gold.withValues(alpha: 0.3),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3EFFF),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF2E1A8A),
                    size: 18.w,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        goal,
                        style: context.titleMedium.copyWith(
                          color: const Color(0xFF2E1A8A),
                          fontWeight: FontWeight.w900,
                          fontSize: 13.sp,
                        ),
                      ),
                      if (subtitle.isNotEmpty)
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodySmall.copyWith(
                            color:
                                const Color(0xFF2E1A8A).withValues(alpha: 0.5),
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  width: 22.w,
                  height: 22.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: SoteriaColors.gold,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: const Color(0xFF2E1A8A), size: 16.w),
                  SizedBox(width: 10.w),
                  Text(
                    title.toUpperCase(),
                    style: context.labelSmall.copyWith(
                      color: const Color(0xFF2E1A8A),
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w900,
                      fontSize: 12.sp,
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
                      style: TextStyle(
                        color: const Color(0xFF8A55FD),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.edit_outlined,
                      color: const Color(0xFF8A55FD),
                      size: 14.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        child,
      ],
    );
  }
}
