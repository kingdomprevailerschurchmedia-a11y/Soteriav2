import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/features/personalization/providers/personalization_notifier.dart';
import 'package:soteria/features/personalization/widgets/step_academic_level.dart';
import 'package:soteria/features/personalization/widgets/step_interests.dart';
import 'package:soteria/features/personalization/widgets/step_goals.dart';
import 'package:soteria/features/personalization/widgets/step_notifications.dart';
import 'package:soteria/features/personalization/widgets/step_summary.dart';

class PersonalizationScreen extends ConsumerStatefulWidget {
  const PersonalizationScreen({super.key});

  @override
  ConsumerState<PersonalizationScreen> createState() =>
      _PersonalizationScreenState();
}

class _PersonalizationScreenState extends ConsumerState<PersonalizationScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onContinue(int currentStep, bool isValid) {
    if (isValid) {
      if (currentStep < 4) {
        ref.read(personalizationProvider.notifier).nextStep();
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        ref.read(personalizationProvider.notifier).complete();
      }
    }
  }

  void _onBack() {
    ref.read(personalizationProvider.notifier).previousStep();
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(personalizationProvider);
    final isValid = state.isStepValid(state.currentStep);

    ref.listen(personalizationProvider.select((s) => s.currentStep), (previous, next) {
      if (_pageController.hasClients && _pageController.page?.round() != next) {
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    return SafeGradientScaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          if (state.currentStep > 0) {
            _onBack();
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SoteriaSpacing.lg,
                vertical: SoteriaSpacing.md,
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Back Button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Opacity(
                          opacity: state.currentStep > 0 ? 1.0 : 0.0,
                          child: GestureDetector(
                            onTap: state.currentStep > 0 ? _onBack : null,
                            child: Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                              ),
                              child: const Icon(
                                Icons.chevron_left_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Logo & Title
                      Column(
                        children: [
                          // Glassy Diamond Logo Placeholder
                          Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              color: SoteriaColors.primary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: SoteriaColors.primary.withValues(alpha: 0.5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: SoteriaColors.primary.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Transform.rotate(
                              angle: 0.785, // 45 degrees
                              child: Center(
                                child: Transform.rotate(
                                  angle: -0.785,
                                  child: Image.asset(
                                    'assets/images/personalisation_icon.png',
                                    width: 24.w,
                                    height: 24.w,
                                    color: Colors.white,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.auto_awesome_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Personalization',
                            style: context.titleLarge.copyWith(
                              color: SoteriaColors.gold,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // Progress Bar Redesign
                  Column(
                    children: [
                      Container(
                        height: 6.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: state.progress,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  SoteriaColors.gold,
                                  Color(0xFFB8860B),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(3.r),
                              boxShadow: [
                                BoxShadow(
                                  color: SoteriaColors.gold.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                            ),
                            child: Text(
                              'Step ${state.currentStep + 1} of 5',
                              style: context.bodySmall.copyWith(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
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

            // Content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  StepAcademicLevel(),
                  StepInterests(),
                  StepGoals(),
                  StepNotifications(),
                  StepSummary(),
                ],
              ),
            ),

            // Footer Redesign
            Padding(
              padding: EdgeInsets.all(SoteriaSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: isValid ? () => _onContinue(state.currentStep, isValid) : null,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isValid ? 1.0 : 0.4,
                      child: Container(
                        height: 60.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF2E1A8A),
                              Color(0xFF5B3FD9),
                              Color(0xFF7C4DFF),
                            ],
                            stops: [0.0, 0.5, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(30.r),
                          boxShadow: [
                            BoxShadow(
                              color: SoteriaColors.primary.withValues(alpha: 0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.auto_awesome_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                              Text(
                                (state.currentStep == 4 ? 'COMPLETE PROFILE' : 'CONTINUE')
                                    .toUpperCase(),
                                style: context.titleMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        size: 14.sp,
                        color: SoteriaColors.textSecondary.withValues(alpha: 0.5),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Your information is safe and secure with us.',
                        style: context.bodySmall.copyWith(
                          color: SoteriaColors.textSecondary.withValues(alpha: 0.5),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
