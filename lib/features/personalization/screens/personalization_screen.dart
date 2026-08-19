import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
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

    ref.listen(personalizationProvider.select((s) => s.currentStep), (
      previous,
      next,
    ) {
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
        canPop: state.currentStep == 0,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          if (state.currentStep > 0) {
            _onBack();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF2E1A8A).withValues(alpha: 0.4),
                const Color(0xFF0B012A).withValues(alpha: 0.8),
              ],
            ),
          ),
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SoteriaSpacing.lg,
                  vertical: 8.h,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 4.h),
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
                                width: 36.w,
                                height: 36.w,
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
                        // Title
                        Text(
                          'Personalization',
                          style: context.titleLarge.copyWith(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Progress Bar Redesign
                    Column(
                      children: [
                        Container(
                          height: 6.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: state.progress,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF8A55FD), Color(0xFFFF4081)],
                                ),
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF8A55FD).withValues(
                                      alpha: 0.4,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'YOUR PROGRESS',
                              style: context.labelSmall.copyWith(
                                color: Colors.white.withValues(alpha: 0.4),
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w800,
                                fontSize: 9.sp,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF8A55FD).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: const Color(0xFF8A55FD).withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                'STEP ${state.currentStep + 1}/5',
                                style: context.bodySmall.copyWith(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w900,
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
                padding: EdgeInsets.symmetric(
                  horizontal: SoteriaSpacing.lg,
                  vertical: 12.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: isValid
                          ? () => _onContinue(state.currentStep, isValid)
                          : null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        height: 52.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          gradient: isValid
                              ? const LinearGradient(
                                  colors: [Color(0xFF8A55FD), Color(0xFFE58C3D)],
                                )
                              : null,
                          color: isValid ? null : Colors.white.withValues(alpha: 0.05),
                          boxShadow: isValid
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF8A55FD).withValues(alpha: 0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.currentStep == 4
                                    ? 'COMPLETE PROFILE'
                                    : 'CONTINUE',
                                style: context.titleMedium.copyWith(
                                  color: isValid ? Colors.white : SoteriaColors.muted,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: isValid ? Colors.white : SoteriaColors.muted,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified_user_rounded,
                          size: 12.sp,
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Secure & Private Profile Setup',
                          style: context.bodySmall.copyWith(
                            color: Colors.white.withValues(alpha: 0.3),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
