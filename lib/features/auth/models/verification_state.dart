import 'package:flutter/foundation.dart';
import 'verification_type.dart';

enum VerificationStep { request, sent, otp, success, resetPassword }

@immutable
class VerificationState {
  final VerificationType type;
  final VerificationStep step;
  final String target;
  final String otp;
  final bool isLoading;
  final String? error;
  final int countdown;
  final String? verificationToken;

<<<<<<< HEAD
  const VerificationState(
    this.type, {
=======
  const VerificationState({
    required this.type,
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
    this.step = VerificationStep.request,
    this.target = '',
    this.otp = '',
    this.isLoading = false,
    this.error,
    this.countdown = 0,
    this.verificationToken,
  });

  VerificationState copyWith({
    VerificationStep? step,
    String? target,
    String? otp,
    bool? isLoading,
    String? error,
    int? countdown,
    String? verificationToken,
  }) {
    return VerificationState(
<<<<<<< HEAD
      type,
=======
      type: type,
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
      step: step ?? this.step,
      target: target ?? this.target,
      otp: otp ?? this.otp,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      countdown: countdown ?? this.countdown,
      verificationToken: verificationToken ?? this.verificationToken,
    );
  }
}
