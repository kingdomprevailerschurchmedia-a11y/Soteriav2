import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/features/question_content/domain/entities/category.dart';
import 'package:soteria/features/personalization/providers/personalization_notifier.dart';
import 'package:soteria/features/question_content/utils/category_icons.dart';

class StepInterests extends ConsumerWidget {
  const StepInterests({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalizationProvider);
    final notifier = ref.read(personalizationProvider.notifier);

    if (state.isLoading && state.categories.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: SoteriaColors.gold));
    }

    final interests = state.categories;

    return RepaintBoundary(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Select your ',
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 28.sp,
                      color: const Color(0xFF2E1A8A),
                      height: 1.1,
                    ),
                  ),
                  TextSpan(
                    text: 'interests',
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
            SizedBox(height: 12.h),
            Text(
              'Tell us about yourself so we can personalise\nyour experience and recommendations.',
              style: context.bodyLarge.copyWith(
                color: const Color(0xFF2E1A8A).withValues(alpha: 0.6),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            if (interests.isEmpty && !state.isLoading)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.error ?? 'Failed to load interests.',
                      textAlign: TextAlign.center,
                      style: context.bodyMedium.copyWith(color: SoteriaColors.error),
                    ),
                    SizedBox(height: 12.h),
                    TextButton.icon(
                      onPressed: () => notifier.retryFetchCategories(),
                      icon: const Icon(Icons.refresh_rounded, size: 20),
                      label: Text(
                        'Try Again',
                        style: context.titleSmall.copyWith(
                          color: const Color(0xFF8A55FD),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                        backgroundColor: const Color(0xFF8A55FD).withValues(alpha: 0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: interests.map<Widget>((category) {
                  final label = category.name;
                  final icon = CategoryIcons.getIconOutlined(category.icon);
                  final isSelected = state.interests.contains(label);

                  return GestureDetector(
                    onTap: () => notifier.toggleInterest(label),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected ? null : Colors.white,
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [Color(0xFF6B38FB), Color(0xFF8A55FD)],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.black.withValues(alpha: 0.05),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            size: 18.w,
                            color: isSelected ? Colors.white : const Color(0xFF2E1A8A),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            label,
                            style: context.bodyMedium.copyWith(
                              color: isSelected ? Colors.white : const Color(0xFF2E1A8A),
                              fontWeight:
                                  isSelected ? FontWeight.w700 : FontWeight.w800,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? Colors.white.withValues(alpha: 0.2)
                                  : const Color(0xFFF3EFFF),
                            ),
                            child: Icon(
                              isSelected ? Icons.check : Icons.chevron_right_rounded,
                              size: 14.w,
                              color: isSelected ? Colors.white : const Color(0xFF2E1A8A),
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
