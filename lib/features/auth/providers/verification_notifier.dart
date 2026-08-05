import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< HEAD
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
=======
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
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
  }

  void updateTarget(String target) {
    state = state.copyWith(target: target, error: null);
  }

  void updateOtp(String otp) {
    state = state.copyWith(otp: otp, error: null);
  }

<<<<<<< HEAD
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
=======
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
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
      );
    }
  }

<<<<<<< HEAD
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

=======
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

>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
  void setStep(VerificationStep step) {
    state = state.copyWith(step: step);
  }
}

<<<<<<< HEAD
final verificationProvider =
    NotifierProvider<VerificationNotifier, VerificationState>(
      VerificationNotifier.new,
    );
=======
final verificationProvider = 
    StateNotifierProvider.family<VerificationNotifier, VerificationState, VerificationType>((ref, type) {
  return VerificationNotifier(type);
});

final verificationRepositoryProvider = Provider<VerificationRepository>((ref) => MockVerificationRepository());
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
