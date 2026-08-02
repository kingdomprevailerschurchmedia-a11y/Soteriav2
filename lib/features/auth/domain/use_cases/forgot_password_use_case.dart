import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository _repository;
  ForgotPasswordUseCase(this._repository);

  Future<void> execute(String email) {
    return _repository.sendPasswordResetEmail(email);
  }
}
