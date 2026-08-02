import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/verification_state.dart';
import '../models/verification_type.dart';
import '../repositories/verification_repository.dart';
import '../services/countdown_service.dart';

class VerificationNotifier extends StateNotifier<VerificationState> {
  VerificationNotifier(this._type) : super(VerificationState(type: _type)) {
    _countdownService = CountdownService();
    _countdownService.stream.listen((seconds) {
      if (mounted) {
        state = state.copyWith(countdown: seconds);
      }
    });
  }

  final VerificationType _type;
  late final CountdownService _countdownService;

  @override
  void dispose() {
    _countdownService.dispose();
    super.dispose();
  }

  void updateTarget(String target) {
    state = state.copyWith(target: target, error: null);
  }

  void updateOtp(String otp) {
    state = state.copyWith(otp: otp, error: null);
  }

  Future<void> requestVerification(VerificationRepository repository) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await repository.requestVerification(_type, state.target);
    
    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        step: VerificationStep.sent,
      );
      _countdownService.start(60);
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.error?.userMessage ?? 'Failed to request verification.',
      );
    }
  }

  Future<void> verifyCode(VerificationRepository repository) async {
    if (state.otp.length < 6) return;
    
    state = state.copyWith(isLoading: true, error: null);
    final result = await repository.verifyCode(_type, state.target, state.otp);
    
    if (result.isSuccess) {
      final nextStep = _type == VerificationType.passwordRecovery 
          ? VerificationStep.resetPassword 
          : VerificationStep.success;
          
      state = state.copyWith(
        isLoading: false,
        step: nextStep,
        verificationToken: result.verificationToken,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: 'Invalid verification code.',
      );
    }
  }

  Future<void> resendCode(VerificationRepository repository) async {
    if (state.countdown > 0) return;
    
    state = state.copyWith(isLoading: true, error: null);
    await repository.resendCode(_type, state.target);
    state = state.copyWith(isLoading: false);
    _countdownService.start(60);
  }

  void setStep(VerificationStep step) {
    state = state.copyWith(step: step);
  }
}

final verificationProvider = 
    StateNotifierProvider.family<VerificationNotifier, VerificationState, VerificationType>((ref, type) {
  return VerificationNotifier(type);
});

final verificationRepositoryProvider = Provider<VerificationRepository>((ref) => MockVerificationRepository());
