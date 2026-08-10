import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/widgets/feedback/soteria_linear_progress.dart';
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

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/welcomescreen_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              // Header & Progress
              Stack(
                alignment: Alignment.center,
                children: [
                  // Top Glow Arc
                  Transform.translate(
                    offset: Offset(0, -160.h),
                    child: Container(
                      width: 400.w,
                      height: 400.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF7C4DFF).withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
                        ),
                        border: Border.all(
                          color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
                          width: 2,
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
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            if (state.step.index > 0 &&
                                state.step != RegistrationStep.success)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () => _onBack(state),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            Text(
                              'Create Identity',
                              style: context.titleLarge.copyWith(
                                color: const Color(0xFFD4AF37),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Container(
                          height: 6.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
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
                                    Color(0xFFD4AF37),
                                    Color(0xFFB8860B),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(3.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFD4AF37).withValues(
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
                      ],
                    ),
                  ),
                ],
              ),

              // Content
              Expanded(
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

              // Footer
              if (state.step != RegistrationStep.success)
                Padding(
                  padding: EdgeInsets.all(SoteriaSpacing.lg),
                  child: GestureDetector(
                    onTap: isValid ? () => _onContinue(state) : null,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isValid ? 1.0 : 0.4,
                      child: Container(
                        height: 56.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF5E2BFF), Color(0xFF4A10FF)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF5E2BFF).withValues(
                                alpha: 0.4,
                              ),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child:
                              state.isLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        (state.step == RegistrationStep.review
                                                ? 'CREATE ACCOUNT'
                                                : 'CONTINUE')
                                            .toUpperCase(),
                                        style: context.titleMedium.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      const Icon(
                                        Icons.chevron_right_rounded,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                        ),
                      ),
                    ),
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.all(SoteriaSpacing.lg),
                  child: SoteriaButton.primary(
                    label: 'Check Email',
                    onPressed: () {},
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
