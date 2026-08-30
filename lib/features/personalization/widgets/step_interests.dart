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

    return RepaintBoundary(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
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
                            fontSize: 24.sp,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'interests',
                          style: context.headlineMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp,
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
                    size: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              'Tell us about yourself so we can personalize your experience.',
              style: context.bodySmall.copyWith(
                color: SoteriaColors.textSecondary.withValues(alpha: 0.6),
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: SoteriaSpacing.lg),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: interests.map((interest) {
                final label = interest['label'] as String;
                final icon = interest['icon'] as IconData;
                final isSelected = state.interests.contains(label);

                return GestureDetector(
                  onTap: () => notifier.toggleInterest(label),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF5B3FD9).withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF7C4DFF)
                            : Colors.white.withValues(alpha: 0.1),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          size: 20.w,
                          color: isSelected ? Colors.white : Colors.white60,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          label,
                          style: context.bodyMedium.copyWith(
                            color: isSelected ? Colors.white : Colors.white60,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
