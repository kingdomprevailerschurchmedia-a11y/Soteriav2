import '../../models/authentication_result.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;
  SignUpUseCase(this._repository);

  Future<AuthenticationResult> execute(String email, String password) {
    return _repository.signUpWithEmail(email, password);
  }
}
