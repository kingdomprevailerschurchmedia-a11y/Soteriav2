import 'package:firebase_remote_config/firebase_remote_config.dart' as rc;
import 'package:flutter/foundation.dart';
import '../../services/firebase_interfaces.dart';
import '../constants/remote_config_keys.dart';
import '../models/app_configuration.dart';
import '../repositories/configuration_repository.dart';
import '../../../logging/logger_service.dart';

class ConfigurationCoordinator {
  final ConfigurationRepository _repository;
  final IRemoteConfigService _remoteConfigService;

  ConfigurationCoordinator(this._repository, this._remoteConfigService);

  Future<void> initialize() async {
    LoggerService.i('Initializing ConfigurationCoordinator', feature: 'Config');

    // 1. Set default values
    await _remoteConfigService.setDefaults({
      RemoteConfigKeys.defaultQuestionTimer: 15,
      RemoteConfigKeys.minTimer: 5,
      RemoteConfigKeys.maxTimer: 60,
      RemoteConfigKeys.questionTransitionDelay: 1.5,
      RemoteConfigKeys.pointsPerCorrect: 100,
      RemoteConfigKeys.wrongAnswerPenalty: 25,
      RemoteConfigKeys.streakBonus: 10,
      RemoteConfigKeys.perfectRoundBonus: 500,
      RemoteConfigKeys.enablePractice: true,
      RemoteConfigKeys.enableProMode: false,
      RemoteConfigKeys.enableTournament: false,
      RemoteConfigKeys.enableVersus: false,
      RemoteConfigKeys.dailyFreeGames: 5,
      RemoteConfigKeys.practiceXpMultiplier: 1.0,
      RemoteConfigKeys.tournamentXpMultiplier: 2.5,
      RemoteConfigKeys.leaderboardRefreshInterval: 300,
      RemoteConfigKeys.maintenanceEnabled: false,
      RemoteConfigKeys.maintenanceMessage:
          'Soteria is currently undergoing scheduled maintenance.',
      RemoteConfigKeys.minAppVersion: '1.0.0',
      RemoteConfigKeys.forceUpgrade: false,
    });

    // 2. Configure fetch settings
    await _remoteConfigService.instance.setConfigSettings(
      rc.RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: kDebugMode
            ? Duration.zero
            : const Duration(hours: 1),
      ),
    );

    // 3. Fetch and activate in background
    _fetchAndActivate();
  }

  Future<void> _fetchAndActivate() async {
    try {
      await _repository.fetchAndActivate();
      LoggerService.i(
        'Remote Config fetched and activated successfully',
        feature: 'Config',
      );
    } catch (e, st) {
      LoggerService.e(
        'Failed to fetch Remote Config',
        error: e,
        stackTrace: st,
        feature: 'Config',
      );
    }
  }

  AppConfiguration getConfiguration() {
    return _repository.getConfiguration();
  }
}
