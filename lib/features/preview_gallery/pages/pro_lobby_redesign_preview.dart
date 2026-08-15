import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/dashboard/presentation/screens/pro_lobby_screen.dart';
import 'package:soteria/features/dashboard/presentation/providers/pro_lobby_providers.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/preview_gallery/models/mock_data_factory.dart';
import 'package:soteria/features/gameplay_engine/models/pro_session_config.dart';
import 'package:soteria/features/gameplay_engine/models/pro_mode_access.dart';

class ProLobbyRedesignPreview extends StatefulWidget {
  const ProLobbyRedesignPreview({super.key});

  @override
  State<ProLobbyRedesignPreview> createState() =>
      _ProLobbyRedesignPreviewState();
}

class _ProLobbyRedesignPreviewState extends State<ProLobbyRedesignPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pro Lobby Redesign'),
        backgroundColor: Colors.transparent,
      ),
      body: ProviderScope(
        overrides: [
          currentPlayerProvider.overrideWithValue(
            MockDataFactory.createMockPlayer(),
          ),
          proLobbyProvider.overrideWith(
            () => _MockProLobbyNotifier(),
          ),
        ],
        child: const ProLobbyScreen(),
      ),
    );
  }
}

class _MockProLobbyNotifier extends ProLobbyNotifier {
  @override
  ProLobbyState build() {
    return ProLobbyState(
      config: const ProSessionConfig(
        difficulty: ProDifficulty.intermediate,
        questionCount: 10,
        entryFee: 100,
      ),
      access: const ProModeAccessResult(
        state: ProModeAccessState.allowed,
        isAllowed: true,
      ),
    );
  }

  @override
  void updateDifficulty(ProDifficulty difficulty) {
    state = state.copyWith(
      config: state.config.copyWith(difficulty: difficulty),
    );
  }

  @override
  void updateQuestionCount(int count) {
    state = state.copyWith(
      config: state.config.copyWith(questionCount: count),
    );
  }
}
