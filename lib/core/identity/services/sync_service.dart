abstract class SyncService {
  Future<void> syncProfile();
  Future<void> syncProgress();
  Future<void> queueUpdate(String key, dynamic value);
  Stream<double> get syncProgressStream;
}

class MockSyncService implements SyncService {
  @override
  Future<void> syncProfile() async {}

  @override
  Future<void> syncProgress() async {}

  @override
  Future<void> queueUpdate(String key, dynamic value) async {}

  @override
  Stream<double> get syncProgressStream => const Stream.empty();
}
