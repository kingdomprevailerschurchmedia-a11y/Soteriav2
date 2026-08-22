import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/dashboard/presentation/screens/practice_lobby_screen.dart';
import 'package:soteria/features/dashboard/presentation/providers/practice_lobby_providers.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/preview_gallery/models/mock_data_factory.dart';
import 'package:soteria/features/gameplay_engine/models/practice_session_config.dart';
import 'package:soteria/features/gameplay_engine/services/reward_estimator.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

class PracticeLobbyRedesignPreview extends StatefulWidget {
  const PracticeLobbyRedesignPreview({super.key});

  @override
  State<PracticeLobbyRedesignPreview> createState() =>
      _PracticeLobbyRedesignPreviewState();
}

class _PracticeLobbyRedesignPreviewState extends State<PracticeLobbyRedesignPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Lobby Redesign'),
        backgroundColor: Colors.transparent,
      ),
      body: ProviderScope(
        overrides: [
          currentPlayerProvider.overrideWithValue(
            MockDataFactory.createMockPlayer(),
          ),
          practiceLobbyProvider.overrideWith(
            () => _MockPracticeLobbyNotifier(),
          ),
        ],
        child: const PracticeLobbyScreen(),
      ),
    );
  }
}

class _MockPracticeLobbyNotifier extends PracticeLobbyNotifier {
  @override
  PracticeLobbyState build() {
    return PracticeLobbyState(
      config: const PracticeSessionConfig(
        difficulty: Difficulty.medium,
        questionCount: 10,
        useInterests: true,
      ),
      estimatedRewards: const EstimatedRewards(
        xp: 150,
        coins: 50,
        estimatedDuration: Duration(minutes: 5),
      ),
    );
  }

  @override
  void updateDifficulty(Difficulty difficulty) {
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

  @override
  void setUseInterests(bool value) {
    state = state.copyWith(
      config: state.config.copyWith(useInterests: value),
    );
  }
}
