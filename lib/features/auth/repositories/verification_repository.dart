import '../models/verification_result.dart';
import '../models/verification_type.dart';

abstract class VerificationRepository {
<<<<<<< HEAD
  Future<VerificationResult> requestVerification(
    VerificationType type,
    String target,
  );
  Future<VerificationResult> verifyCode(
    VerificationType type,
    String target,
    String code,
  );
=======
  Future<VerificationResult> requestVerification(VerificationType type, String target);
  Future<VerificationResult> verifyCode(VerificationType type, String target, String code);
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
  Future<void> resendCode(VerificationType type, String target);
}

class MockVerificationRepository implements VerificationRepository {
  @override
<<<<<<< HEAD
  Future<VerificationResult> requestVerification(
    VerificationType type,
    String target,
  ) async {
=======
  Future<VerificationResult> requestVerification(VerificationType type, String target) async {
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
    await Future.delayed(const Duration(seconds: 1));
    return const VerificationResult.success();
  }

  @override
<<<<<<< HEAD
  Future<VerificationResult> verifyCode(
    VerificationType type,
    String target,
    String code,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    if (code == '000000') {
      return const VerificationResult.success(
        verificationToken: 'valid-token-123',
      );
=======
  Future<VerificationResult> verifyCode(VerificationType type, String target, String code) async {
    await Future.delayed(const Duration(seconds: 1));
    if (code == '000000') {
      return const VerificationResult.success(verificationToken: 'valid-token-123');
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
    }
    return const VerificationResult.failure(null);
  }

  @override
  Future<void> resendCode(VerificationType type, String target) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
