abstract class UsernameService {
  Future<bool> isUsernameAvailable(String username);
  bool isReserved(String username);
}

class MockUsernameService implements UsernameService {
  final _reserved = {'admin', 'soteria', 'moderator'};

  @override
  Future<bool> isUsernameAvailable(String username) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return !username.contains('taken');
  }

  @override
  bool isReserved(String username) => _reserved.contains(username.toLowerCase());
}
