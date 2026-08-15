import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:soteria/core/utils/identity_validator.dart';
import '../models/verification_state.dart';
import '../models/verification_type.dart';
import 'auth_providers.dart';
import '../services/countdown_service.dart';

class VerificationNotifier extends StateNotifier<VerificationState> {
  final dynamic _ref; // Using dynamic to avoid Ref conflict for a moment
  final VerificationType _type;
  late final CountdownService _countdownService;

  VerificationNotifier(this._ref, this._type)
    : super(VerificationState(_type)) {
    _countdownService = CountdownService();
    _countdownService.stream.listen((seconds) {
      if (mounted) {
        state = state.copyWith(countdown: seconds);
      }
    });
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
      switch (_type) {
        case VerificationType.emailVerification:
          await _ref.read(sendEmailVerificationUseCaseProvider).execute();
          state = state.copyWith(isLoading: false, step: VerificationStep.sent);
          _countdownService.start(60);
          break;
        case VerificationType.passwordRecovery:
          await _ref.read(forgotPasswordUseCaseProvider).execute(state.target);
          state = state.copyWith(isLoading: false, step: VerificationStep.sent);
          _countdownService.start(60);
          break;
        default:
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

  Future<void> resendCode() async {
    if (state.countdown > 0) return;

    state = state.copyWith(isLoading: true, error: null);
    try {
      if (_type == VerificationType.emailVerification) {
        await _ref.read(sendEmailVerificationUseCaseProvider).execute();
      } else if (_type == VerificationType.passwordRecovery) {
        await _ref.read(forgotPasswordUseCaseProvider).execute(state.target);
      }
      state = state.copyWith(isLoading: false);
      _countdownService.start(60);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to resend code.');
    }
  }

  Future<void> checkVerificationStatus() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final isVerified = await _ref
          .read(checkAuthStateUseCaseProvider)
          .isEmailVerified();

      if (mounted) {
        if (isVerified) {
          state = state.copyWith(
            isLoading: false,
            step: VerificationStep.success,
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            error: 'Email not verified yet. Please check your inbox.',
          );
        }
      }
    } catch (e) {
      if (mounted) {
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

  @override
  void dispose() {
    _countdownService.dispose();
    super.dispose();
  }
}

final verificationProvider =
    StateNotifierProvider.family<
      VerificationNotifier,
      VerificationState,
      VerificationType
    >((ref, type) => VerificationNotifier(ref, type));
