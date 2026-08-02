import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/verification_state.dart';
import '../models/verification_type.dart';
import 'auth_providers.dart';
import '../services/countdown_service.dart';

class VerificationNotifier extends Notifier<VerificationState> {
  late final CountdownService _countdownService;

  @override
  VerificationState build() {
    _countdownService = CountdownService();
    _countdownService.stream.listen((seconds) {
      if (ref.mounted) {
        state = state.copyWith(countdown: seconds);
      }
    });
    return const VerificationState(VerificationType.emailVerification);
  }

  void init(VerificationType type) {
    state = VerificationState(
      type,
      step: state.step,
      target: state.target,
      otp: state.otp,
      isLoading: state.isLoading,
      error: state.error,
      countdown: state.countdown,
      verificationToken: state.verificationToken,
    );
  }

  void updateTarget(String target) {
    state = state.copyWith(target: target, error: null);
  }

  void updateOtp(String otp) {
    state = state.copyWith(otp: otp, error: null);
  }

  Future<void> submitRequest() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      switch (state.type) {
        case VerificationType.emailVerification:
          await ref.read(sendEmailVerificationUseCaseProvider).execute();
          state = state.copyWith(isLoading: false, step: VerificationStep.sent);
          _countdownService.start(60);
          break;
        case VerificationType.passwordRecovery:
          await ref.read(forgotPasswordUseCaseProvider).execute(state.target);
          state = state.copyWith(isLoading: false, step: VerificationStep.sent);
          _countdownService.start(60);
          break;
        default:
          // OTP types would go here
          state = state.copyWith(
            isLoading: false,
            error: 'This verification type is not yet implemented.',
          );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to send request. Please try again.',
      );
    }
  }

  Future<void> resendEmailVerification() async {
    if (state.countdown > 0) return;

    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(sendEmailVerificationUseCaseProvider).execute();
      state = state.copyWith(isLoading: false);
      _countdownService.start(60);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to send verification email.',
      );
    }
  }

  Future<void> checkVerificationStatus() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final isVerified = await ref
          .read(checkAuthStateUseCaseProvider)
          .isEmailVerified();
      
      if (ref.mounted) {
        if (isVerified) {
          state = state.copyWith(isLoading: false, step: VerificationStep.success);
        } else {
          state = state.copyWith(
            isLoading: false,
            error: 'Email not verified yet. Please check your inbox.',
          );
        }
      }
    } catch (e) {
      if (ref.mounted) {
        state = state.copyWith(
          isLoading: false,
          error: 'Connection error. Please try again.',
        );
      }
    }
  }

  void setStep(VerificationStep step) {
    state = state.copyWith(step: step);
  }
}

final verificationProvider =
    NotifierProvider<VerificationNotifier, VerificationState>(
      VerificationNotifier.new,
    );
