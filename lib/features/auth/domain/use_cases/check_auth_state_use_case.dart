import '../repositories/auth_repository.dart';

class CheckAuthStateUseCase {
  final AuthRepository _repository;
  CheckAuthStateUseCase(this._repository);

  Stream<String?> execute() => _repository.userIdChanges;

  String? get currentUserId => _repository.currentUserId;

  Future<bool> isEmailVerified() => _repository.isEmailVerified();
}
