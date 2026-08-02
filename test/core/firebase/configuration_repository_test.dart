import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/core/firebase/config/repositories/firebase_configuration_repository.dart';
import 'package:soteria/core/firebase/config/constants/remote_config_keys.dart';

@GenerateMocks([IRemoteConfigService])
import 'configuration_repository_test.mocks.dart';

void main() {
  late FirebaseConfigurationRepository repository;
  late MockIRemoteConfigService mockService;

  setUp(() {
    mockService = MockIRemoteConfigService();
    repository = FirebaseConfigurationRepository(mockService);
  });

  group('FirebaseConfigurationRepository', () {
    test('getConfiguration should map service values to typed model', () {
      // Setup generic defaults first
      when(mockService.getInt(any)).thenReturn(0);
      when(mockService.getBool(any)).thenReturn(false);
      when(mockService.getDouble(any)).thenReturn(0.0);
      when(mockService.getString(any)).thenReturn('');

      // Setup specific stubs
      when(
        mockService.getInt(RemoteConfigKeys.defaultQuestionTimer),
      ).thenReturn(20);
      when(
        mockService.getBool(RemoteConfigKeys.enablePractice),
      ).thenReturn(true);
      when(
        mockService.getBool(RemoteConfigKeys.enableProMode),
      ).thenReturn(false);
      when(
        mockService.getDouble(RemoteConfigKeys.questionTransitionDelay),
      ).thenReturn(2.5);
      when(
        mockService.getString(RemoteConfigKeys.maintenanceMessage),
      ).thenReturn('Hello');

      final config = repository.getConfiguration();

      expect(config.gameplay.defaultQuestionTimer, 20);
      expect(config.features.enablePractice, true);
      expect(config.features.enableProMode, false);
      expect(config.gameplay.questionTransitionDelay, 2.5);
      expect(config.maintenance.message, 'Hello');
    });
  });
}
