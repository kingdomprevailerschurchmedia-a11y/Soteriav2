import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/firebase/config/models/app_configuration.dart';
import 'package:soteria/core/firebase/config/providers/configuration_providers.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/features/dashboard/presentation/screens/pro_lobby_screen.dart';
import 'package:soteria/features/dashboard/presentation/providers/pro_lobby_providers.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/preview_gallery/models/mock_data_factory.dart';

class ProLobbyPreviewPage extends StatelessWidget {
  const ProLobbyPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeGradientScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _PreviewSection(
              title: 'Pro Lobby - Expert Player',
              child: ProviderScope(
                overrides: [
                  currentPlayerProvider.overrideWithValue(
                    MockDataFactory.createExpertPlayer(),
                  ),
                  configurationProvider.overrideWithValue(
                    AppConfiguration.defaults().copyWith(
                      features: const FeatureConfig.defaults().copyWith(
                        enableProMode: true,
                      ),
                    ),
                  ),
                ],
                child: ProLobbyScreen(
                  tournament: MockDataFactory.createMockTournament(),
                ),
              ),
            ),
            _PreviewSection(
              title: 'Pro Lobby - Insufficient Coins',
              child: ProviderScope(
                overrides: [
                  currentPlayerProvider.overrideWithValue(
                    MockDataFactory.createLowCoinPlayer(),
                  ),
                ],
                child: ProLobbyScreen(
                  tournament: MockDataFactory.createMockTournament(),
                ),
              ),
            ),
            _PreviewSection(
              title: 'Pro Lobby - Level Required',
              child: ProviderScope(
                overrides: [
                  currentPlayerProvider.overrideWithValue(
                    MockDataFactory.createNewPlayer(),
                  ),
                ],
                child: ProLobbyScreen(
                  tournament: MockDataFactory.createMockTournament(),
                ),
              ),
            ),
            _PreviewSection(
              title: 'Pro Lobby - Offline State',
              child: ProviderScope(
                overrides: [
                  proLobbyProvider.overrideWith(_OfflineProLobbyNotifier.new),
                ],
                child: ProLobbyScreen(
                  tournament: MockDataFactory.createMockTournament(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfflineProLobbyNotifier extends ProLobbyNotifier {
  @override
  ProLobbyState build() {
    return const ProLobbyState(isOffline: true);
  }
}

class _PreviewSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _PreviewSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 800, child: child),
        const Divider(color: Colors.white24),
      ],
    );
  }
}
