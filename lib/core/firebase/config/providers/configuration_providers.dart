import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/firebase_providers.dart';
import '../models/app_configuration.dart';
import '../repositories/configuration_repository.dart';
import '../repositories/firebase_configuration_repository.dart';
import '../services/configuration_coordinator.dart';

final configurationRepositoryProvider = Provider<ConfigurationRepository>((
  ref,
) {
  return FirebaseConfigurationRepository(
    ref.watch(remoteConfigServiceProvider),
  );
});

final configurationCoordinatorProvider = Provider<ConfigurationCoordinator>((
  ref,
) {
  return ConfigurationCoordinator(
    ref.watch(configurationRepositoryProvider),
    ref.watch(remoteConfigServiceProvider),
  );
});

final configurationProvider = Provider<AppConfiguration>((ref) {
  // We don't want to rebuild every time a fetch happens if we are just using defaults.
  // But we want to reflect the updated config once activated.
  // For now, let's keep it simple.
  return ref.watch(configurationCoordinatorProvider).getConfiguration();
});

final featureFlagsProvider = Provider<FeatureConfig>((ref) {
  return ref.watch(configurationProvider).features;
});

final gameplayConfigProvider = Provider<GameplayConfig>((ref) {
  return ref.watch(configurationProvider).gameplay;
});
