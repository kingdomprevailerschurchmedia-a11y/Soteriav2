import 'identity_exception.dart';

class VerificationResult {
  final bool isSuccess;
  final IdentityException? error;
  final String? verificationToken;

  const VerificationResult.success({this.verificationToken})
<<<<<<< HEAD
    : isSuccess = true,
      error = null;

  const VerificationResult.failure(this.error)
    : isSuccess = false,
      verificationToken = null;
=======
      : isSuccess = true,
        error = null;

  const VerificationResult.failure(this.error)
      : isSuccess = false,
        verificationToken = null;
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
}
