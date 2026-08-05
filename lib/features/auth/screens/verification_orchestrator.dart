import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/widgets/feedback/soteria_linear_progress.dart';
<<<<<<< HEAD
import 'package:soteria/core/navigation/navigation_service.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
=======
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
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
<<<<<<< HEAD
  ConsumerState<VerificationOrchestrator> createState() =>
      _VerificationOrchestratorState();
}

class _VerificationOrchestratorState
    extends ConsumerState<VerificationOrchestrator> {
=======
  ConsumerState<VerificationOrchestrator> createState() => _VerificationOrchestratorState();
}

class _VerificationOrchestratorState extends ConsumerState<VerificationOrchestrator> {
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
<<<<<<< HEAD
    Future.microtask(() {
      ref.read(verificationProvider.notifier).init(widget.type);
    });
=======
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onContinue(VerificationState state) async {
<<<<<<< HEAD
    final notifier = ref.read(verificationProvider.notifier);
    
    if (state.step == VerificationStep.request) {
      await notifier.submitRequest();
    } else if (state.step == VerificationStep.sent) {
      if (state.type == VerificationType.emailVerification || 
          state.type == VerificationType.passwordRecovery) {
        // Trigger an immediate manual check
        await notifier.checkVerificationStatus();
      } else {
        _advance(VerificationStep.otp);
      }
    } else if (state.step == VerificationStep.success) {
      ref.read(navigationServiceProvider).go(SoteriaRoutes.main);
    } else if (state.step == VerificationStep.resetPassword) {
      // Password reset logic would go here
=======
    final notifier = ref.read(verificationProvider(widget.type).notifier);
    final repository = ref.read(verificationRepositoryProvider);

    if (state.step == VerificationStep.request) {
      await notifier.requestVerification(repository);
      _advance(VerificationStep.otp);
    } else if (state.step == VerificationStep.sent) {
      _advance(VerificationStep.otp);
    } else if (state.step == VerificationStep.otp) {
      await notifier.verifyCode(repository);
      // Notifier handles step change to success or resetPassword
    } else if (state.step == VerificationStep.success || state.step == VerificationStep.resetPassword) {
      // Final navigation (Placeholder)
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
    }
  }

  void _advance(VerificationStep nextStep) {
    _pageController.animateToPage(
      _getPageIndex(nextStep),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  int _getPageIndex(VerificationStep step) {
    switch (step) {
<<<<<<< HEAD
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
=======
      case VerificationStep.request: return 0;
      case VerificationStep.sent: return 1;
      case VerificationStep.otp: return 2;
      case VerificationStep.success: return 3;
      case VerificationStep.resetPassword: return 4;
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final state = ref.watch(verificationProvider);

    // Sync PageView with state step
    ref.listen<VerificationState>(verificationProvider, (prev, next) {
=======
    final state = ref.watch(verificationProvider(widget.type));
    
    // Sync PageView with state step
    ref.listen<VerificationState>(verificationProvider(widget.type), (prev, next) {
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
      if (prev?.step != next.step) {
        _pageController.animateToPage(
          _getPageIndex(next.step),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    return SafeGradientScaffold(
      body: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            child: Column(
              children: [
                Text(
                  'Identity',
                  style: context.titleLarge.copyWith(color: SoteriaColors.gold),
                ),
                SizedBox(height: SoteriaSpacing.md),
                SoteriaLinearProgress(
                  progress: (_getPageIndex(state.step) + 1) / 4.0,
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
<<<<<<< HEAD
                      style: context.bodySmall.copyWith(
                        color: SoteriaColors.error,
                      ),
=======
                      style: context.bodySmall.copyWith(color: SoteriaColors.error),
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
                      textAlign: TextAlign.center,
                    ),
                  ),
                SoteriaButton.primary(
                  label: _getButtonLabel(state.step),
                  isLoading: state.isLoading,
<<<<<<< HEAD
                  onPressed: _isButtonEnabled(state)
                      ? () => _onContinue(state)
                      : null,
=======
                  onPressed: _isButtonEnabled(state) ? () => _onContinue(state) : null,
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getButtonLabel(VerificationStep step) {
    switch (step) {
<<<<<<< HEAD
      case VerificationStep.request:
        return 'Send Code';
      case VerificationStep.otp:
        return 'Verify Code';
      case VerificationStep.resetPassword:
        return 'Reset Password';
      default:
        return 'Continue';
=======
      case VerificationStep.request: return 'Send Code';
      case VerificationStep.otp: return 'Verify Code';
      case VerificationStep.resetPassword: return 'Reset Password';
      default: return 'Continue';
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
    }
  }

  bool _isButtonEnabled(VerificationState state) {
    if (state.step == VerificationStep.request) return state.target.isNotEmpty;
    if (state.step == VerificationStep.otp) return state.otp.length == 6;
    return true;
  }
}
