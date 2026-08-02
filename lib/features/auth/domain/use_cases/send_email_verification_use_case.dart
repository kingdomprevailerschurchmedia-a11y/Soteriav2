import '../repositories/auth_repository.dart';

class SendEmailVerificationUseCase {
  final AuthRepository _repository;
  SendEmailVerificationUseCase(this._repository);

  Future<void> execute() {
    return _repository.sendEmailVerification();
  }
}
