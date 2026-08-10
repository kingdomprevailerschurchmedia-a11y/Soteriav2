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
      children: [
        SizedBox(height: SoteriaSpacing.md),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'What are your ',
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.sp,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: 'goals?',
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.sp,
                  color: const Color(0xFF7C4DFF),
                ),
              ),
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.w, bottom: 10.h),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    color: Color(0xFF7C4DFF),
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Select all that apply. You can change these anytime.',
          style: context.bodySmall.copyWith(
            color: SoteriaColors.textSecondary.withValues(alpha: 0.6),
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        ...goals.map((goal) {
          final title = goal['title'] as String;
          final isSelected = state.goals.contains(title);
          final isGold = goal['isGold'] as bool;

          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: GestureDetector(
              onTap: () => notifier.toggleGoal(title),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF7C4DFF)
                        : Colors.white.withValues(alpha: 0.1),
                    width: 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF7C4DFF).withValues(alpha: 0.2),
                            blurRadius: 10,
                            spreadRadius: 1,
                          )
                        ]
                      : null,
                ),
                child: GlassSurface(
                  borderRadius: BorderRadius.circular(20.r),
                  opacity: 0.05,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Row(
                      children: [
                        // Icon Container
                        Container(
                          width: 56.w,
                          height: 56.w,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              goal['icon'] as IconData,
                              color: isGold ? SoteriaColors.gold : const Color(0xFF7C4DFF),
                              size: 28.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        // Text Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: context.titleMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                goal['subtitle'] as String,
                                style: context.bodySmall.copyWith(
                                  color: SoteriaColors.textSecondary.withValues(alpha: 0.6),
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Checkbox
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF5B3FD9) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF7C4DFF)
                                  : Colors.white.withValues(alpha: 0.2),
                              width: 1.5,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 18,
                                )
                              : null,
                        ),
                      ],
                    ),
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
