import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/components/soteria_state_views.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/features/preview_gallery/models/mock_data_factory.dart';
import 'package:soteria/features/tournaments/domain/models/tournament_status.dart';
import 'package:soteria/features/tournaments/domain/models/tournament_type.dart';
import 'package:soteria/features/tournaments/presentation/providers/tournament_details_provider.dart';
import 'package:soteria/features/tournaments/presentation/providers/tournament_discovery_provider.dart';
import 'package:soteria/features/tournaments/presentation/providers/tournament_registration_provider.dart';
import 'package:soteria/features/tournaments/presentation/providers/tournament_gameplay_provider.dart';
import 'package:soteria/features/tournaments/presentation/providers/tournament_leaderboard_provider.dart';
import 'package:soteria/features/tournaments/presentation/screens/tournament_details_screen.dart';
import 'package:soteria/features/tournaments/presentation/screens/tournament_discovery_screen.dart';
import 'package:soteria/features/tournaments/presentation/screens/tournament_lobby_screen.dart';
import 'package:soteria/features/tournaments/presentation/screens/tournament_results_screen.dart';
import 'package:soteria/features/tournaments/presentation/widgets/tournament_card.dart';
import 'package:soteria/features/tournaments/presentation/widgets/tournament_countdown_widget.dart';

class TournamentPreviewGallery extends StatelessWidget {
  const TournamentPreviewGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('Tournament Gallery'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _PreviewHeader(title: 'WIDGETS'),
            _PreviewSection(
              title: 'Tournament Card (Registration Open)',
              height: 320,
              child: TournamentCard(
                tournament: MockDataFactory.createMockTournament(
                  status: TournamentStatus.registrationOpen,
                ),
                onTap: () {},
              ),
            ),
            _PreviewSection(
              title: 'Tournament Card (Live)',
              height: 320,
              child: TournamentCard(
                tournament: MockDataFactory.createMockTournament(
                  status: TournamentStatus.live,
                ),
                onTap: () {},
              ),
            ),
            _PreviewSection(
              title: 'Tournament Card (Completed)',
              height: 320,
              child: TournamentCard(
                tournament: MockDataFactory.createMockTournament(
                  status: TournamentStatus.completed,
                ),
                onTap: () {},
              ),
            ),
            _PreviewSection(
              title: 'Countdown Widget',
              height: 150,
              child: Center(
                child: TournamentCountdownWidget(
                  targetDate: DateTime.now().add(
                    const Duration(hours: 1, minutes: 30),
                  ),
                  label: 'Tournament Starts In',
                ),
              ),
            ),
            const _PreviewHeader(title: 'SCREENS'),
            _PreviewSection(
              title: 'Discovery Screen (List)',
              child: ProviderScope(
                overrides: [
                  tournamentDiscoveryProvider.overrideWith(
                    (ref) => Stream.value([
                      MockDataFactory.createMockTournament(
                        name: 'Summer Cup 2026',
                        status: TournamentStatus.live,
                        registeredPlayers: 500,
                      ),
                      MockDataFactory.createMockTournament(
                        name: 'Cyber Sentinel',
                        status: TournamentStatus.registrationOpen,
                        registeredPlayers: 42,
                      ),
                      MockDataFactory.createMockTournament(
                        name: 'Legacy Clash',
                        status: TournamentStatus.upcoming,
                        registeredPlayers: 0,
                      ),
                    ]),
                  ),
                ],
                child: const TournamentDiscoveryScreen(),
              ),
            ),
            _PreviewSection(
              title: 'Details Screen (Registration Open)',
              child: ProviderScope(
                overrides: [
                  tournamentDetailsProvider('mock_details_open').overrideWith(
                    (ref) => Stream.value(
                      MockDataFactory.createMockTournament(
                        id: 'mock_details_open',
                        status: TournamentStatus.registrationOpen,
                      ),
                    ),
                  ),
                  isRegisteredForTournamentProvider(
                    'mock_details_open',
                  ).overrideWith((ref) => Future.value(false)),
                ],
                child: const TournamentDetailsScreen(
                  tournamentId: 'mock_details_open',
                ),
              ),
            ),
            _PreviewSection(
              title: 'Details Screen (Registered)',
              child: ProviderScope(
                overrides: [
                  tournamentDetailsProvider('mock_registered').overrideWith(
                    (ref) => Stream.value(
                      MockDataFactory.createMockTournament(
                        id: 'mock_registered',
                        status: TournamentStatus.registrationOpen,
                      ),
                    ),
                  ),
                  isRegisteredForTournamentProvider(
                    'mock_registered',
                  ).overrideWith((ref) => Future.value(true)),
                ],
                child: const TournamentDetailsScreen(
                  tournamentId: 'mock_registered',
                ),
              ),
            ),
            const _PreviewHeader(title: 'SCENARIOS'),
            _PreviewSection(
              title: 'Discovery Screen (Large Scale)',
              child: ProviderScope(
                overrides: [
                  tournamentDiscoveryProvider.overrideWith(
                    (ref) => Stream.value([
                      MockDataFactory.createMockTournament(
                        name: 'National Championship 2026',
                        type: TournamentType.national,
                        status: TournamentStatus.registrationOpen,
                        registeredPlayers: 850,
                        maxPlayers: 1000,
                        prizePool: 50000,
                      ),
                      MockDataFactory.createMockTournament(
                        name: 'University League',
                        type: TournamentType.university,
                        status: TournamentStatus.live,
                        registeredPlayers: 450,
                      ),
                      MockDataFactory.createMockTournament(
                        name: 'Regional Qualifier',
                        status: TournamentStatus.upcoming,
                      ),
                    ]),
                  ),
                ],
                child: const TournamentDiscoveryScreen(),
              ),
            ),
            _PreviewSection(
              title: 'Details Screen (Tournament Full)',
              child: ProviderScope(
                overrides: [
                  tournamentDetailsProvider('full').overrideWith(
                    (ref) => Stream.value(
                      MockDataFactory.createMockTournament(
                        id: 'full',
                        name: 'Sold Out Event',
                        status: TournamentStatus.registrationOpen,
                        registeredPlayers: 500,
                        maxPlayers: 500,
                      ),
                    ),
                  ),
                  isRegisteredForTournamentProvider(
                    'full',
                  ).overrideWith((ref) => Future.value(false)),
                ],
                child: const TournamentDetailsScreen(tournamentId: 'full'),
              ),
            ),
            _PreviewSection(
              title: 'Lobby Screen (Starting Soon)',
              child: ProviderScope(
                overrides: [
                  tournamentDetailsProvider('starting').overrideWith(
                    (ref) => Stream.value(
                      MockDataFactory.createMockTournament(
                        id: 'starting',
                        status: TournamentStatus.startingSoon,
                        startTime: DateTime.now().add(
                          const Duration(seconds: 45),
                        ),
                      ),
                    ),
                  ),
                ],
                child: const TournamentLobbyScreen(tournamentId: 'starting'),
              ),
            ),
            _PreviewSection(
              title: 'Results Screen (Podium Finish)',
              child: ProviderScope(
                overrides: [
                  playerTournamentRankingProvider('podium').overrideWith(
                    (ref) => Future.value(
                      MockDataFactory.createMockTournamentRanking(
                        rank: 2,
                        prize: MockDataFactory.createMockTournamentReward(
                          coins: 1000,
                          xp: 500,
                          titles: ['Podium Challenger'],
                        ),
                      ),
                    ),
                  ),
                ],
                child: const TournamentResultsScreen(tournamentId: 'podium'),
              ),
            ),
            _PreviewSection(
              title: 'Discovery - Empty State',
              child: ProviderScope(
                overrides: [
                  tournamentDiscoveryProvider.overrideWith(
                    (ref) => Stream.value([]),
                  ),
                ],
                child: const TournamentDiscoveryScreen(),
              ),
            ),
            _PreviewSection(
              title: 'Discovery - Error State',
              child: ProviderScope(
                overrides: [
                  tournamentDiscoveryProvider.overrideWith(
                    (ref) => Stream.error('Network integrity failure'),
                  ),
                ],
                child: const TournamentDiscoveryScreen(),
              ),
            ),
            _PreviewSection(
              title: 'Discovery - Offline State',
              child: ProviderScope(
                overrides: [
                  tournamentDiscoveryProvider.overrideWith(
                    (ref) => const Stream.empty(),
                  ),
                ],
                child: const SafeGradientScaffold(
                  body: SoteriaOfflineView(onRetry: _nop),
                ),
              ),
            ),
            SizedBox(height: SoteriaSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}

void _nop() {}

class _MockTournamentGameplayNotifier extends TournamentGameplayNotifier {
  _MockTournamentGameplayNotifier(TournamentGameplayState initialState)
    : super(
        tournamentId: 'mock',
        ref: ProviderContainer().read(providerContainerProvider),
      );
}

final providerContainerProvider = Provider((ref) => ref);

class TournamentGameplayHeader extends StatelessWidget {
  final int score;
  final int streak;
  final int questionIndex;
  final int totalQuestions;

  const TournamentGameplayHeader({
    super.key,
    required this.score,
    required this.streak,
    required this.questionIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        SoteriaSpacing.lg,
        24,
        SoteriaSpacing.lg,
        SoteriaSpacing.md,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'QUESTION $questionIndex / $totalQuestions',
                style: const TextStyle(color: Colors.white70, fontSize: 10),
              ),
              Text(
                'Score: $score',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.bolt_rounded, color: Colors.blue, size: 16),
                const SizedBox(width: 4),
                Text(
                  'STREAK: $streak',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
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
  }) : width = null;

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
