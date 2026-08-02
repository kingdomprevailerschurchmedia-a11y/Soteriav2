import '../models/verification_result.dart';
import '../models/verification_type.dart';

abstract class VerificationRepository {
  Future<VerificationResult> requestVerification(VerificationType type, String target);
  Future<VerificationResult> verifyCode(VerificationType type, String target, String code);
  Future<void> resendCode(VerificationType type, String target);
}

class MockVerificationRepository implements VerificationRepository {
  @override
  Future<VerificationResult> requestVerification(VerificationType type, String target) async {
    await Future.delayed(const Duration(seconds: 1));
    return const VerificationResult.success();
  }

  @override
  Future<VerificationResult> verifyCode(VerificationType type, String target, String code) async {
    await Future.delayed(const Duration(seconds: 1));
    if (code == '000000') {
      return const VerificationResult.success(verificationToken: 'valid-token-123');
    }
    return const VerificationResult.failure(null);
  }

  @override
  Future<void> resendCode(VerificationType type, String target) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
