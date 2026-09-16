import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/shared/widgets/soteria_page.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import '../providers/registration_notifier.dart';
import '../models/registration_draft.dart';
import '../widgets/step_personal_identity.dart';
import '../widgets/step_account_identity.dart';
import '../widgets/step_security.dart';
import '../widgets/step_review.dart';
import '../widgets/step_registration_success.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  late final PageController _pageController;

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

  void _onContinue(RegistrationDraft state) async {
    if (state.step == RegistrationStep.review) {
      await ref.read(registrationProvider.notifier).completeRegistration();
      if (mounted && ref.read(registrationProvider).error == null) {
        ref
            .read(navigationServiceProvider)
            .go('${SoteriaRoutes.auth}/verify/emailVerification');
      }
      return;
    }

    final nextStep = RegistrationStep.values[state.step.index + 1];
    ref.read(registrationProvider.notifier).setStep(nextStep);
    _pageController.animateToPage(
      nextStep.index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onBack(RegistrationDraft state) {
    if (state.isLoading) return;
    if (state.step.index > 0) {
      final prevStep = RegistrationStep.values[state.step.index - 1];
      ref.read(registrationProvider.notifier).setStep(prevStep);
      _pageController.animateToPage(
        prevStep.index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _jumpToStep(RegistrationStep step) {
    if (ref.read(registrationProvider).isLoading) return;
    ref.read(registrationProvider.notifier).setStep(step);
    _pageController.jumpToPage(step.index);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registrationProvider);
    final isValid = ref
        .read(registrationProvider.notifier)
        .isStepValid(state.step);

    ref.listen(registrationProvider.select((s) => s.error), (previous, next) {
      if (next != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next), backgroundColor: SoteriaColors.error),
        );
      }
    });

    return SoteriaPage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            if (state.isLoading) return;
            if (state.step.index > 0 &&
                state.step != RegistrationStep.success) {
              _onBack(state);
            } else {
              Navigator.of(context).pop();
            }
          },
          child: SafeArea(
            child: Column(
              children: [
                // Header & Progress
                RepaintBoundary(
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      // Top Glow Arc (Refined)
                      Positioned(
                        top: -240.h,
                        child: RepaintBoundary(
                          child: Container(
                            width: 500.w,
                            height: 500.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  const Color(0xFF7C4DFF).withValues(alpha: 0.25),
                                  const Color(0xFF7C4DFF).withValues(alpha: 0.1),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.5, 1.0],
                              ),
                              border: Border.all(
                                color: const Color(
                                  0xFF7C4DFF,
                                ).withValues(alpha: 0.4),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SoteriaSpacing.lg,
                          vertical: SoteriaSpacing.md,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 48.h,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  if (state.step.index > 0 &&
                                      state.step != RegistrationStep.success)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: state.isLoading ? null : () => _onBack(state),
                                        child: Container(
                                          padding: EdgeInsets.all(8.w),
                                          color: Colors.transparent,
                                          child: const Icon(
                                            Icons.chevron_left_rounded,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  Text(
                                    'Create Identity',
                                    style: context.titleLarge.copyWith(
                                      color: const Color(0xFFD4AF37),
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            // Progress Bar Redesign
                            Container(
                              height: 6.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(3.r),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor:
                                    (state.step.index + 1) /
                                    RegistrationStep.values.length,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFF0D670),
                                        Color(0xFFD4AF37),
                                        Color(0xFFB8860B),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(3.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFFD4AF37,
                                        ).withValues(alpha: 0.5),
                                        blurRadius: 12,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: RepaintBoundary(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const StepPersonalIdentity(),
                        const StepAccountIdentity(),
                        const StepSecurity(),
                        StepReview(onEdit: _jumpToStep),
                        const StepRegistrationSuccess(),
                      ],
                    ),
                  ),
                ),

                // Footer
                if (state.step != RegistrationStep.success)
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      SoteriaSpacing.lg,
                      0,
                      SoteriaSpacing.lg,
                      SoteriaSpacing.lg,
                    ),
                    child: GestureDetector(
                      onTap: (isValid && !state.isLoading)
                          ? () => _onContinue(state)
                          : null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        height: 52.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          gradient: (isValid && !state.isLoading)
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFFD8B24A),
                                    Color(0xFFB8860B),
                                  ],
                                )
                              : null,
                          color: (isValid && !state.isLoading)
                              ? null
                              : Colors.white.withValues(alpha: 0.05),
                          boxShadow: (isValid && !state.isLoading)
                              ? [
                                  BoxShadow(
                                    color: SoteriaColors.gold.withValues(
                                      alpha: 0.2,
                                    ),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: state.isLoading
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: SoteriaColors.backgroundBottomRight,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.step == RegistrationStep.review
                                          ? 'Create Account'
                                          : 'Continue',
                                      style: context.titleMedium.copyWith(
                                        color: (isValid && !state.isLoading)
                                            ? SoteriaColors
                                                .backgroundBottomRight
                                            : SoteriaColors.muted,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0.2,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: (isValid && !state.isLoading)
                                          ? SoteriaColors.backgroundBottomRight
                                          : SoteriaColors.muted,
                                      size: 18,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.all(SoteriaSpacing.lg),
                    child: GestureDetector(
                      onTap: () =>
                          ref
                              .read(navigationServiceProvider)
                              .go(SoteriaRoutes.login),
                      child: Container(
                        width: double.infinity,
                        height: 52.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFD8B24A), Color(0xFFB8860B)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: SoteriaColors.gold.withValues(alpha: 0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Back to Login',
                            style: context.titleMedium.copyWith(
                              color: SoteriaColors.backgroundBottomRight,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.2,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
