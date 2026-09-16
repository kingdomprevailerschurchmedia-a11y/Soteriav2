import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/shared/widgets/soteria_background.dart';
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

  void _onContinue(int currentStep, bool isValid, bool isLoading) {
    if (isValid && !isLoading) {
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

  void _onBack(bool isLoading) {
    if (!isLoading) {
      ref.read(personalizationProvider.notifier).previousStep();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(personalizationProvider);
    final isValid = state.isStepValid(state.currentStep);
    final isLoading = state.isLoading;

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

    return Scaffold(
      backgroundColor: SoteriaColors.backgroundBottomRight,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const SoteriaBackground(
            imagePath: 'assets/images/onboarding_bg.webp',
            showOverlay: false,
          ),
          PopScope(
            canPop: state.currentStep == 0,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              if (state.currentStep > 0 && !isLoading) {
                _onBack(isLoading);
              }
            },
            child: Column(
              children: [
                // Header Section
                SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SoteriaSpacing.lg,
                  vertical: 8.h,
                ),
                child: Column(
                  children: [
                    // Segmented Progress Bar
                    Row(
                      children: List.generate(5, (index) {
                        final isActive = index == state.currentStep;
                        final isPassed = index < state.currentStep;
                        return Expanded(
                          child: Container(
                            height: 3.h,
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            decoration: BoxDecoration(
                              color: (isActive || isPassed)
                                  ? const Color(0xFF8A55FD)
                                  : const Color(0xFFE0E0E0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        // Back Button
                        if (state.currentStep > 0)
                          GestureDetector(
                            onTap: !isLoading ? () => _onBack(isLoading) : null,
                            child: Container(
                              width: 28.w,
                              height: 28.w,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.5),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black.withValues(alpha: 0.1),
                                ),
                              ),
                              child: const Icon(
                                Icons.chevron_left_rounded,
                                color: Color(0xFF2E1A8A),
                                size: 18,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

              // Content
              Expanded(
                child: RepaintBoundary(
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
              ),

              // Footer Redesign
              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SoteriaSpacing.lg,
                    vertical: 16.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: (isValid && !isLoading)
                            ? () =>
                                _onContinue(state.currentStep, isValid, isLoading)
                            : null,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          height: 52.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            gradient: (isValid && !isLoading)
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFFD8B24A),
                                      Color(0xFFB8860B),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )
                                : null,
                            color: (isValid && !isLoading)
                                ? null
                                : const Color(0xFFE0E0E0),
                            boxShadow: (isValid && !isLoading)
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.2,
                                      ),
                                      blurRadius: 15,
                                      offset: const Offset(0, 8),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: isLoading
                                ? SizedBox(
                                    width: 20.w,
                                    height: 20.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        state.currentStep == 4
                                            ? 'Complete Profile'
                                            : 'Continue',
                                        style: context.titleMedium.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.2,
                                          fontSize: 17.sp,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: const BoxDecoration(
                              color: Color(0xFF8A55FD),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              size: 10.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Secure & Private Profile Setup',
                            style: context.bodySmall.copyWith(
                              color: const Color(0xFF8A55FD).withValues(
                                alpha: 0.6,
                              ),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
