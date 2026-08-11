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
import '../models/verification_state.dart';
import '../models/verification_type.dart';
import '../providers/verification_notifier.dart';
import '../widgets/verification_step_request.dart';
import '../widgets/verification_step_sent.dart';
import '../widgets/verification_step_otp.dart';
import '../widgets/verification_step_success.dart';
import '../widgets/verification_step_reset_password.dart';

class VerificationOrchestrator extends ConsumerStatefulWidget {
  const VerificationOrchestrator({super.key, required this.type});
  final VerificationType type;

  @override
  ConsumerState<VerificationOrchestrator> createState() =>
      _VerificationOrchestratorState();
}

class _VerificationOrchestratorState
    extends ConsumerState<VerificationOrchestrator> {
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

  void _onContinue(VerificationState state) async {
    final notifier = ref.read(verificationProvider(widget.type).notifier);

    if (state.step == VerificationStep.request) {
      await notifier.submitRequest();
    } else if (state.step == VerificationStep.sent) {
      if (widget.type == VerificationType.emailVerification ||
          widget.type == VerificationType.passwordRecovery) {
        await notifier.checkVerificationStatus();
      } else {
        notifier.setStep(VerificationStep.otp);
      }
    } else if (state.step == VerificationStep.success) {
      ref.read(navigationServiceProvider).go(SoteriaRoutes.main);
    }
  }

  int _getPageIndex(VerificationStep step) {
    switch (step) {
      case VerificationStep.request:
        return 0;
      case VerificationStep.sent:
        return 1;
      case VerificationStep.otp:
        return 2;
      case VerificationStep.success:
        return 3;
      case VerificationStep.resetPassword:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(verificationProvider(widget.type));

    // Sync PageView with state step
    ref.listen<VerificationState>(verificationProvider(widget.type), (
      prev,
      next,
    ) {
      if (prev?.step != next.step) {
        _pageController.animateToPage(
          _getPageIndex(next.step),
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
          if (state.step == VerificationStep.sent || state.step == VerificationStep.otp) {
            ref.read(verificationProvider(widget.type).notifier).setStep(VerificationStep.request);
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.fromLTRB(
                SoteriaSpacing.md,
                SoteriaSpacing.lg,
                SoteriaSpacing.lg,
                SoteriaSpacing.md,
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            if (state.step == VerificationStep.sent || state.step == VerificationStep.otp) {
                              ref.read(verificationProvider(widget.type).notifier).setStep(VerificationStep.request);
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withValues(alpha: 0.05),
                          ),
                        ),
                      ),
                      Text(
                        'Identity',
                        style: context.titleLarge.copyWith(
                          color: SoteriaColors.gold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SoteriaSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: SoteriaLinearProgress(
                          progress: (_getPageIndex(state.step) + 1) / 3.0,
                          color: SoteriaColors.gold,
                        ),
                      ),
                      SizedBox(width: SoteriaSpacing.md),
                      Text(
                        'Step ${_getPageIndex(state.step) + 1} of 3',
                        style: context.bodySmall.copyWith(
                          color: SoteriaColors.textSecondary,
                        ),
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
                children: [
                  VerificationStepRequest(type: widget.type),
                  VerificationStepSent(type: widget.type),
                  VerificationStepOtp(type: widget.type),
                  const VerificationStepSuccess(),
                  VerificationStepResetPassword(type: widget.type),
                ],
              ),
            ),

            // Footer
            Padding(
              padding: EdgeInsets.all(SoteriaSpacing.lg),
              child: Column(
                children: [
                  if (state.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        state.error!,
                        style: context.bodySmall.copyWith(
                          color: SoteriaColors.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  SoteriaButton.primary(
                    label: _getButtonLabel(state.step),
                    isLoading: state.isLoading,
                    size: SoteriaButtonSize.lg,
                    uppercase: false,
                    trailingIcon: Icons.arrow_forward_rounded,
                    onPressed: _isButtonEnabled(state)
                        ? () => _onContinue(state)
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getButtonLabel(VerificationStep step) {
    switch (step) {
      case VerificationStep.request:
        return 'Send Code';
      case VerificationStep.otp:
        return 'Verify Code';
      case VerificationStep.resetPassword:
        return 'Reset Password';
      default:
        return 'Continue';
    }
  }

  bool _isButtonEnabled(VerificationState state) {
    if (state.step == VerificationStep.request) return state.target.isNotEmpty;
    if (state.step == VerificationStep.otp) return state.otp.length == 6;
    return true;
  }
}
