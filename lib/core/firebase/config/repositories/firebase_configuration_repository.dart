import 'dart:convert';
import '../../../../features/gameplay_engine/models/pro_mode_config.dart';
import '../../../../features/tournaments/domain/models/tournament_config.dart';
import '../../services/firebase_interfaces.dart';
import '../constants/remote_config_keys.dart';
import '../models/app_configuration.dart';
import 'configuration_repository.dart';

class FirebaseConfigurationRepository implements ConfigurationRepository {
  final IRemoteConfigService _remoteConfig;

  FirebaseConfigurationRepository(this._remoteConfig);

  @override
  Future<void> fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }

  @override
  AppConfiguration getConfiguration() {
    return AppConfiguration(
      gameplay: GameplayConfig(
        defaultQuestionTimer: _remoteConfig.getInt(
          RemoteConfigKeys.defaultQuestionTimer,
        ),
        minTimer: _remoteConfig.getInt(RemoteConfigKeys.minTimer),
        maxTimer: _remoteConfig.getInt(RemoteConfigKeys.maxTimer),
        questionTransitionDelay: _remoteConfig.getDouble(
          RemoteConfigKeys.questionTransitionDelay,
        ),
        pointsPerCorrect: _remoteConfig.getInt(
          RemoteConfigKeys.pointsPerCorrect,
        ),
        wrongAnswerPenalty: _remoteConfig.getInt(
          RemoteConfigKeys.wrongAnswerPenalty,
        ),
        streakBonus: _remoteConfig.getInt(RemoteConfigKeys.streakBonus),
        perfectRoundBonus: _remoteConfig.getInt(
          RemoteConfigKeys.perfectRoundBonus,
        ),
      ),
      features: FeatureConfig(
        enablePractice: _remoteConfig.getBool(RemoteConfigKeys.enablePractice),
        enableProMode: _remoteConfig.getBool(RemoteConfigKeys.enableProMode),
        enableTournament: _remoteConfig.getBool(
          RemoteConfigKeys.enableTournament,
        ),
        enableVersus: _remoteConfig.getBool(RemoteConfigKeys.enableVersus),
        enableMarketplace: _remoteConfig.getBool(
          RemoteConfigKeys.enableMarketplace,
        ),
        enableAICoach: _remoteConfig.getBool(RemoteConfigKeys.enableAICoach),
        enableClubs: _remoteConfig.getBool(RemoteConfigKeys.enableClubs),
        enableFriends: _remoteConfig.getBool(RemoteConfigKeys.enableFriends),
        enablePremium: _remoteConfig.getBool(RemoteConfigKeys.enablePremium),
      ),
      rewards: RewardConfig(
        dailyFreeGames: _remoteConfig.getInt(RemoteConfigKeys.dailyFreeGames),
        practiceXpMultiplier: _remoteConfig.getDouble(
          RemoteConfigKeys.practiceXpMultiplier,
        ),
        tournamentXpMultiplier: _remoteConfig.getDouble(
          RemoteConfigKeys.tournamentXpMultiplier,
        ),
        leaderboardRefreshInterval: _remoteConfig.getInt(
          RemoteConfigKeys.leaderboardRefreshInterval,
        ),
      ),
      lifelines: LifelineConfig(
        enableFiftyFifty: _remoteConfig.getBool(
          RemoteConfigKeys.enableFiftyFifty,
        ),
        enablePauseTimer: _remoteConfig.getBool(
          RemoteConfigKeys.enablePauseTimer,
        ),
        enableAskAudience: _remoteConfig.getBool(
          RemoteConfigKeys.enableAskAudience,
        ),
        maxUsesPerMatch: _remoteConfig.getInt(
          RemoteConfigKeys.maxLifelinesPerMatch,
        ),
      ),
      maintenance: MaintenanceConfig(
        isEnabled: _remoteConfig.getBool(RemoteConfigKeys.maintenanceEnabled),
        message: _remoteConfig.getString(RemoteConfigKeys.maintenanceMessage),
        minAppVersion: _remoteConfig.getString(RemoteConfigKeys.minAppVersion),
        forceUpgrade: _remoteConfig.getBool(RemoteConfigKeys.forceUpgrade),
      ),
      proMode: _parseProModeConfig(),
      tournament: TournamentConfig(
        maxRegistration: _remoteConfig.getInt(
          RemoteConfigKeys.tournamentMaxRegistration,
        ),
        defaultFee: _remoteConfig.getDouble(
          RemoteConfigKeys.tournamentDefaultFee,
        ),
      ),
      rawValues: getAllRawValues(),
    );
  }

  ProModeConfig _parseProModeConfig() {
    try {
      final feesStr = _remoteConfig.getString(RemoteConfigKeys.proModeFees);
      final multsStr = _remoteConfig.getString(
        RemoteConfigKeys.proModeMultipliers,
      );

      final Map<String, dynamic> feesMap = feesStr.isNotEmpty
          ? jsonDecode(feesStr)
          : {};
      final Map<String, dynamic> multsMap = multsStr.isNotEmpty
          ? jsonDecode(multsStr)
          : {};

      return ProModeConfig(
        entryFees: feesMap.map((k, v) => MapEntry(int.parse(k), v as int)),
        difficultyMultipliers: multsMap.map((k, v) => MapEntry(k, v as double)),
        riskFactor: _remoteConfig.getDouble(RemoteConfigKeys.proModeRiskFactor),
        minLevelRequirement: _remoteConfig.getInt(
          RemoteConfigKeys.proModeMinLevel,
        ),
      );
    } catch (_) {
      return ProModeConfig.defaults();
    }
  }

  @override
  Map<String, dynamic> getAllRawValues() {
    // This is simplified. In a real SDK we'd iterate over all keys.
    // For now, we'll manually collect the keys we care about.
    return {
      RemoteConfigKeys.defaultQuestionTimer: _remoteConfig.getInt(
        RemoteConfigKeys.defaultQuestionTimer,
      ),
      RemoteConfigKeys.maintenanceEnabled: _remoteConfig.getBool(
        RemoteConfigKeys.maintenanceEnabled,
      ),
      RemoteConfigKeys.maintenanceMessage: _remoteConfig.getString(
        RemoteConfigKeys.maintenanceMessage,
      ),
      // ... more as needed for debug screen
    };
  }

  @override
  DateTime getLastFetchTime() {
    return _remoteConfig.instance.lastFetchTime;
  }
}
