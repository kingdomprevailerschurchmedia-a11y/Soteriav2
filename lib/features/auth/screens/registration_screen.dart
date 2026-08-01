import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/widgets/feedback/soteria_linear_progress.dart';
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

  void _onContinue(RegistrationDraft state) {
    if (state.step == RegistrationStep.success) {
      // Final navigation (Placeholder)
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
    final isValid = ref.read(registrationProvider.notifier).isStepValid(state.step);

    return SafeGradientScaffold(
      body: Column(
        children: [
          // Header & Progress
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg, vertical: SoteriaSpacing.md),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (state.step.index > 0 && state.step != RegistrationStep.success)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                          onPressed: () => _onBack(state),
                        ),
                      ),
                    Text(
                      'Create Identity',
                      style: context.titleLarge.copyWith(color: SoteriaColors.gold, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: SoteriaSpacing.md),
                SoteriaLinearProgress(
                  progress: (state.step.index + 1) / RegistrationStep.values.length,
                  color: SoteriaColors.gold,
                ),
              ],
            ),
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
              child: SoteriaButton.primary(
                label: state.step == RegistrationStep.review ? 'Create Account' : 'Continue',
                onPressed: isValid ? () => _onContinue(state) : null,
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
    );
  }
}
