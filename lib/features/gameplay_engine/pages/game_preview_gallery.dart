import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/pages/game_shell_page.dart';
import 'package:soteria/features/gameplay_engine/pages/results_screen.dart';
import 'package:soteria/features/gameplay_engine/pages/competitive_results_screen.dart';
import 'package:soteria/features/gameplay_engine/pages/competitive_review_screen.dart';
import 'package:soteria/features/gameplay_engine/pages/answer_review_screen.dart';
import 'package:soteria/features/gameplay_engine/providers/competitive_results_provider.dart';
import 'package:soteria/features/gameplay_engine/providers/settlement_provider.dart';
import 'package:soteria/features/gameplay_engine/models/competitive_settlement.dart';
import 'package:soteria/features/gameplay_engine/models/competitive_session.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/competitive_settlement_repository.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/competitive_stats_repository.dart';
import 'package:soteria/features/dashboard/presentation/screens/practice_lobby_screen.dart';
import 'package:soteria/features/preview_gallery/models/mock_data_factory.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/gameplay_engine/pages/competitive_playing_view.dart';
import 'package:soteria/features/gameplay_engine/widgets/competitive_overlays.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';

class GameEnginePreviewGallery extends StatelessWidget {
  const GameEnginePreviewGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeGradientScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _PreviewHeader(title: 'PRACTICE MODE'),
            _PreviewSection(
              title: 'Gameplay (Practice)',
              child: _GamePreview(config: GameConfiguration.practice()),
            ),
            const _PreviewHeader(title: 'PRO MODE COMPETITIVE'),
            _PreviewSection(
              title: 'Gameplay (Winning Expert)',
              child: ProviderScope(
                overrides: [
                  gameEngineProvider(
                    MockDataFactory.createExpertMatchConfig(),
                  ).overrideWith(
                    (ref) => _MockGameEngine(
                      MockDataFactory.createWinningProState(),
                    ),
                  ),
                ],
                child: CompetitivePlayingView(
                  config: MockDataFactory.createExpertMatchConfig(),
                ),
              ),
            ),
            _PreviewSection(
              title: 'Connection Lost Overlay',
              child: ConnectionLostOverlay(onRetry: () {}),
            ),
            _PreviewSection(
              title: 'Pro Paused View',
              child: ProPausedView(onResume: () {}, onQuit: () {}),
            ),
            const _PreviewHeader(title: 'PRO MODE RESULTS & SETTLEMENT'),
            _PreviewSection(
              title: 'Pro Result (Winner - Settled)',
              child: ProviderScope(
                overrides: [
                  settlementProvider.overrideWith(
                    (ref) => _MockSettlementNotifier(
                      MockDataFactory.createMockSettlement(
                        result: MockDataFactory.createMockResult(),
                      ),
                    ),
                  ),
                ],
                child: CompetitiveResultsScreen(
                  result: MockDataFactory.createMockResult(),
                  session: MockDataFactory.createMockCompetitiveSession(),
                  onPlayAgain: () {},
                  onHome: () {},
                ),
              ),
            ),
            _PreviewSection(
              title: 'Pro Result (Champion Win - 3x)',
              child: ProviderScope(
                overrides: [
                  settlementProvider.overrideWith(
                    (ref) => _MockSettlementNotifier(
                      MockDataFactory.createMockSettlement(
                        result: MockDataFactory.createMockResult(
                          isPerfect: true,
                        ),
                        wagered: 1000,
                        won: 3000,
                      ),
                    ),
                  ),
                ],
                child: CompetitiveResultsScreen(
                  result: MockDataFactory.createMockResult(isPerfect: true),
                  session: MockDataFactory.createMockCompetitiveSession(
                    fee: 1000,
                    difficulty: 'expert',
                  ),
                  onPlayAgain: () {},
                  onHome: () {},
                ),
              ),
            ),
            _PreviewSection(
              title: 'Pro Result (Heavy Loss)',
              child: ProviderScope(
                overrides: [
                  settlementProvider.overrideWith(
                    (ref) => _MockSettlementNotifier(
                      MockDataFactory.createMockSettlement(
                        result: MockDataFactory.createFailedResult(),
                        wagered: 500,
                        won: 0,
                      ),
                    ),
                  ),
                ],
                child: CompetitiveResultsScreen(
                  result: MockDataFactory.createFailedResult(),
                  session: MockDataFactory.createMockCompetitiveSession(
                    fee: 500,
                  ),
                  onPlayAgain: () {},
                  onHome: () {},
                ),
              ),
            ),
            _PreviewSection(
              title: 'Pro Result (Offline - Sync Pending)',
              child: ProviderScope(
                overrides: [
                  settlementProvider.overrideWith(
                    (ref) => _MockSettlementNotifier(
                      MockDataFactory.createMockSettlement(
                        result: MockDataFactory.createMockResult(),
                        status: SettlementStatus.offline,
                      ),
                    ),
                  ),
                ],
                child: CompetitiveResultsScreen(
                  result: MockDataFactory.createMockResult(),
                  session: MockDataFactory.createMockCompetitiveSession(),
                  onPlayAgain: () {},
                  onHome: () {},
                ),
              ),
            ),
            _PreviewSection(
              title: 'Pro Result (Settlement Pending)',
              child: ProviderScope(
                overrides: [
                  settlementProvider.overrideWith(
                    (ref) => _MockSettlementNotifier(null, isLoading: true),
                  ),
                ],
                child: CompetitiveResultsScreen(
                  result: MockDataFactory.createMockResult(),
                  session: MockDataFactory.createMockCompetitiveSession(),
                  onPlayAgain: () {},
                  onHome: () {},
                ),
              ),
            ),
            _PreviewSection(
              title: 'Pro Result (Settlement Failed)',
              child: ProviderScope(
                overrides: [
                  settlementProvider.overrideWith(
                    (ref) => _MockSettlementNotifier(
                      null,
                      error: 'Network Timeout: Integrity validation failed.',
                    ),
                  ),
                ],
                child: CompetitiveResultsScreen(
                  result: MockDataFactory.createMockResult(),
                  session: MockDataFactory.createMockCompetitiveSession(),
                  onPlayAgain: () {},
                  onHome: () {},
                ),
              ),
            ),
            _PreviewSection(
              title: 'Pro Answer Review',
              child: CompetitiveReviewScreen(
                items: MockDataFactory.createMockCompetitiveReviews(),
              ),
            ),
            const _PreviewHeader(title: 'PRACTICE MODE SCREENS'),
            _PreviewSection(
              title: 'Practice Lobby',
              child: const PracticeLobbyScreen(),
            ),
            _PreviewSection(
              title: 'Results (Perfect Score)',
              child: ResultsScreen(
                result: MockDataFactory.createMockResult(isPerfect: true),
                onPlayAgain: () {},
                onHome: () {},
              ),
            ),
            _PreviewSection(
              title: 'Results (Failed Session)',
              child: ResultsScreen(
                result: MockDataFactory.createFailedResult(),
                onPlayAgain: () {},
                onHome: () {},
              ),
            ),
            _PreviewSection(
              title: 'Results (Offline Sync Pending)',
              child: ResultsScreen(
                result: MockDataFactory.createOfflineResult(),
                onPlayAgain: () {},
                onHome: () {},
              ),
            ),
            _PreviewSection(
              title: 'Answer Review',
              child: AnswerReviewScreen(
                reviews: MockDataFactory.createMockReviews(),
              ),
            ),
            const _PreviewHeader(title: 'RESPONSIVE STATES'),
            _PreviewSection(
              title: 'Tablet Layout (Results)',
              height: 800,
              width: 900,
              child: ResultsScreen(
                result: MockDataFactory.createMockResult(),
                onPlayAgain: () {},
                onHome: () {},
              ),
            ),
            SizedBox(height: SoteriaSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}

class _PreviewHeader extends StatelessWidget {
  final String title;
  const _PreviewHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      color: Colors.white.withValues(alpha: 0.05),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          letterSpacing: 2.0,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _PreviewSection extends StatelessWidget {
  final String title;
  final Widget child;
  final double height;
  final double? width;

  const _PreviewSection({
    required this.title,
    required this.child,
    this.height = 600,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
        Center(
          child: Container(
            height: height,
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white10),
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: child,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _GamePreview extends ConsumerWidget {
  final GameConfiguration config;
  const _GamePreview({required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Inject mock questions for preview
    final questions = MockDataFactory.createMockQuestions(5);

    // Auto-start session for preview
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameEngineProvider(config).notifier).startSession(questions);
    });

    return ClipRRect(child: GameShellPage(config: config));
  }
}

class _MockGameEngine extends GameEngine {
  _MockGameEngine(GameState initialState)
    : super(config: const GameConfiguration(mode: GameMode.pro)) {
    state = initialState;
  }
}

class _MockSettlementNotifier extends SettlementNotifier {
  final CompetitiveSettlement? mockSettlement;
  final bool isLoading;
  final String? error;

  _MockSettlementNotifier(
    this.mockSettlement, {
    this.isLoading = false,
    this.error,
  }) : super(
         settlementRepo: _MockSettlementRepo(),
         statsRepo: _MockStatsRepo(),
         ref: ProviderContainer().read(providerContainerProvider),
       ) {
    if (isLoading) {
      state = const AsyncValue.loading();
    } else if (error != null) {
      state = AsyncValue.error(error!, StackTrace.current);
    } else {
      state = AsyncValue.data(mockSettlement);
    }
  }

  @override
  Future<void> finalizeSession({
    required CompetitiveSession session,
    required GameResult result,
    required String uid,
  }) async {
    // Do nothing in mock
  }
}

final providerContainerProvider = Provider((ref) => ref);

class _MockSettlementRepo implements CompetitiveSettlementRepository {
  @override
  Future<void> finalizeSettlement(CompetitiveSettlement settlement) async {}
  @override
  String generateSettlementId() => 'mock_id';
  @override
  Future<CompetitiveSettlement?> getSettlementBySession(
    String sessionId,
  ) async => null;
  @override
  Future<void> syncOfflineSettlement(CompetitiveSettlement settlement) async {}
}

class _MockStatsRepo implements CompetitiveStatsRepository {
  @override
  Future<void> updatePlayerStats(
    String uid,
    GameResult result,
    int coinsDelta,
  ) async {}
}
