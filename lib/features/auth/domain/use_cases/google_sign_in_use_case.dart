import '../../models/authentication_result.dart';
import '../repositories/auth_repository.dart';

class GoogleSignInUseCase {
  final AuthRepository _repository;
  GoogleSignInUseCase(this._repository);

  Future<AuthenticationResult> execute() {
    return _repository.signInWithGoogle();
  }
}
