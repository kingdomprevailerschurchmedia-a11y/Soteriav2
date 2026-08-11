import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/features/personalization/providers/personalization_notifier.dart';

class StepInterests extends ConsumerWidget {
  const StepInterests({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalizationProvider);
    final notifier = ref.read(personalizationProvider.notifier);

    final interests = [
      {'label': 'Science', 'icon': Icons.science_outlined},
      {'label': 'Technology', 'icon': Icons.computer_rounded},
      {'label': 'Business', 'icon': Icons.business_center_outlined},
      {'label': 'Medicine', 'icon': Icons.favorite_border_rounded},
      {'label': 'Arts', 'icon': Icons.palette_outlined},
      {'label': 'History', 'icon': Icons.account_balance_outlined},
      {'label': 'Sports', 'icon': Icons.sports_basketball_outlined},
      {'label': 'Current Affairs', 'icon': Icons.newspaper_rounded},
      {'label': 'Programming', 'icon': Icons.code_rounded},
      {'label': 'Mathematics', 'icon': Icons.calculate_outlined},
      {'label': 'Engineering', 'icon': Icons.settings_outlined},
      {'label': 'Languages', 'icon': Icons.chat_bubble_outline_rounded},
      {'label': 'Law', 'icon': Icons.gavel_rounded},
      {'label': 'Finance', 'icon': Icons.bar_chart_rounded},
      {'label': 'Psychology', 'icon': Icons.psychology_outlined},
      {'label': 'Design', 'icon': Icons.brush_rounded},
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        text: 'Select your ',
                        style: context.headlineMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.sp,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'interests',
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
            'Choose at least one to personalize your feed.',
            style: context.bodySmall.copyWith(
              color: SoteriaColors.textSecondary.withValues(alpha: 0.6),
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: SoteriaSpacing.xl),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: interests.map((item) {
              final label = item['label'] as String;
              final icon = item['icon'] as IconData;
              final isSelected = state.interests.contains(label);

              return GestureDetector(
                onTap: () => notifier.toggleInterest(label),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF5B3FD9)
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF7C4DFF)
                          : Colors.white.withValues(alpha: 0.1),
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(
                                0xFF5B3FD9,
                              ).withValues(alpha: 0.4),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icon,
                        size: 20.w,
                        color: isSelected ? Colors.white : SoteriaColors.muted,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        label,
                        style: context.labelLarge.copyWith(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                      if (isSelected) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 10,
                            color: Color(0xFF5B3FD9),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 40.h),
          // Great choices! Banner
          if (state.interests.isNotEmpty)
            GlassSurface(
              borderRadius: BorderRadius.circular(24.r),
              opacity: 0.05,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2E1A8A), Color(0xFF5B3FD9)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: SoteriaColors.gold,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Great choices!',
                            style: context.titleMedium.copyWith(
                              color: SoteriaColors.gold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'We\'ll show you the best content based on your interests.',
                            style: context.bodySmall.copyWith(
                              color: SoteriaColors.textSecondary.withValues(
                                alpha: 0.7,
                              ),
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Decorative image placeholder
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: const Icon(
                        Icons.description_outlined,
                        color: Color(0xFF7C4DFF),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(height: SoteriaSpacing.xl),
        ],
      ),
    );
  }
}
