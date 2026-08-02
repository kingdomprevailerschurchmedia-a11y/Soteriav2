enum VerificationType {
  emailVerification,
  passwordRecovery,
  phoneVerification,
  mfa,
  walletVerification,
  prizeVerification,
  deviceVerification,
}

extension VerificationTypeX on VerificationType {
  String get title {
    switch (this) {
      case VerificationType.emailVerification:
        return 'Verify Email';
      case VerificationType.passwordRecovery:
        return 'Recover Password';
      case VerificationType.phoneVerification:
        return 'Verify Phone';
      case VerificationType.mfa:
        return 'Two-Factor Auth';
      case VerificationType.walletVerification:
        return 'Verify Wallet';
      case VerificationType.prizeVerification:
        return 'Claim Prize';
      case VerificationType.deviceVerification:
        return 'New Device';
    }
  }

  String get description {
    switch (this) {
      case VerificationType.emailVerification:
        return 'Verify your email to secure your account.';
      case VerificationType.passwordRecovery:
        return 'Reset your password securely.';
      default:
        return 'Identity verification required.';
    }
  }
}
