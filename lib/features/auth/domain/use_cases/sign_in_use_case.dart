import '../../models/authentication_result.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _repository;
  SignInUseCase(this._repository);

  Future<AuthenticationResult> execute(String email, String password) {
    return _repository.signInWithEmail(email, password);
  }
}
