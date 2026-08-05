import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/widgets/feedback/soteria_linear_progress.dart';
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

    return SafeGradientScaffold(
      body: Column(
        children: [
          // Header & Progress
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Opacity(
                        opacity: state.currentStep > 0 ? 1.0 : 0.0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: state.currentStep > 0 ? _onBack : null,
                        ),
                      ),
                    ),
                    Text(
                      'Personalization',
                      style: context.titleLarge.copyWith(
                        color: SoteriaColors.gold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SoteriaSpacing.md),
                SoteriaLinearProgress(
                  progress: state.progress,
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
              children: const [
                StepAcademicLevel(),
                StepInterests(),
                StepGoals(),
                StepNotifications(),
                StepSummary(),
              ],
            ),
          ),

          // Footer
          Padding(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            child: SoteriaButton.primary(
              label: state.currentStep == 4 ? 'Complete Profile' : 'Continue',
              onPressed: isValid
                  ? () => _onContinue(state.currentStep, isValid)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
