import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/features/personalization/providers/personalization_notifier.dart';

class StepGoals extends ConsumerWidget {
  const StepGoals({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalizationProvider);
    final notifier = ref.read(personalizationProvider.notifier);

    final goals = [
      {
        'title': 'Practice Daily',
        'subtitle': 'Build a consistent learning habit',
        'icon': Icons.timer_outlined,
        'isGold': true,
      },
      {
        'title': 'Improve GPA',
        'subtitle': 'Master academic subjects',
        'icon': Icons.trending_up_rounded,
        'isGold': true,
      },
      {
        'title': 'Prepare for Exams',
        'subtitle': 'Targeted practice for success',
        'icon': Icons.assignment_outlined,
        'isGold': false,
      },
      {
        'title': 'Compete Nationally',
        'subtitle': 'Rise through the ranks',
        'icon': Icons.emoji_events_outlined,
        'isGold': false,
      },
      {
        'title': 'Earn Rewards',
        'subtitle': 'Get recognized for your skills',
        'icon': Icons.card_giftcard_rounded,
        'isGold': false,
      },
      {
        'title': 'Learn New Things',
        'subtitle': 'Explore topics that inspire you',
        'icon': Icons.lightbulb_outline_rounded,
        'isGold': false,
      },
    ];

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        SizedBox(height: 40.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'What are your\n',
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 28.sp,
                      color: const Color(0xFF2E1A8A),
                      height: 1.1,
                    ),
                  ),
                  TextSpan(
                    text: 'goals?',
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 28.sp,
                      color: SoteriaColors.gold,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Select all that apply. You can change\nthese anytime in your settings.',
              style: context.bodyLarge.copyWith(
                color: const Color(0xFF2E1A8A).withValues(alpha: 0.6),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ...goals.map((goal) {
          final title = goal['title'] as String;
          final isSelected = state.goals.contains(title);

          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: GestureDetector(
              onTap: () => notifier.toggleGoal(title),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 66.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: isSelected
                      ? SoteriaColors.gold.withValues(alpha: 0.1)
                      : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? SoteriaColors.gold
                        : Colors.black.withValues(alpha: 0.05),
                    width: isSelected ? 1.5 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    children: [
                      // Icon Container
                      Container(
                        width: 38.w,
                        height: 38.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3EFFF),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Icon(
                            goal['icon'] as IconData,
                            color: const Color(0xFF2E1A8A),
                            size: 18.w,
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      // Text Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.titleMedium.copyWith(
                                color: const Color(0xFF2E1A8A),
                                fontWeight: FontWeight.w900,
                                fontSize: 13.sp,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              goal['subtitle'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.bodySmall.copyWith(
                                color: const Color(0xFF2E1A8A).withValues(
                                  alpha: 0.5,
                                ),
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Checkbox Indicator
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 22.w,
                        height: 22.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? SoteriaColors.gold
                              : const Color(0xFFF3EFFF),
                        ),
                        child: Icon(
                          isSelected ? Icons.check : Icons.add,
                          color: isSelected ? Colors.black : const Color(0xFF2E1A8A),
                          size: 14.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
        SizedBox(height: 40.h),
      ],
    );
  }
}
