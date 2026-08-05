import 'identity_exception.dart';

class VerificationResult {
  final bool isSuccess;
  final IdentityException? error;
  final String? verificationToken;

  const VerificationResult.success({this.verificationToken})
      : isSuccess = true,
        error = null;

  const VerificationResult.failure(this.error)
      : isSuccess = false,
        verificationToken = null;
}
