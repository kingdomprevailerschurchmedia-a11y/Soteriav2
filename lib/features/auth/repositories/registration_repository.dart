import '../models/registration_draft.dart';

abstract class RegistrationRepository {
  Future<void> register(RegistrationDraft draft);
}

class MockRegistrationRepository implements RegistrationRepository {
  @override
  Future<void> register(RegistrationDraft draft) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
