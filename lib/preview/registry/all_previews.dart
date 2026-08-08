import '../models/preview_item.dart';
import '../models/preview_category.dart';
import 'preview_registry.dart';
import '../categories/design_system/token_viewer.dart';
import '../../../features/onboarding/screens/onboarding_screen.dart';
import '../../../features/dashboard/presentation/screens/pro_lobby_screen.dart';
import '../../../features/tournaments/presentation/screens/tournament_discovery_screen.dart';
import '../../../features/tournaments/presentation/screens/tournament_lobby_screen.dart';
import '../../../features/tournaments/presentation/screens/tournament_results_screen.dart';
import '../../../features/tournaments/presentation/screens/tournament_leaderboard_screen.dart';
import '../../../features/player/presentation/screens/player_profile_screen.dart';
import '../../../features/auth/presentation/widgets/logout_confirmation_dialog.dart';
import '../../../features/gameplay_engine/pages/competitive_review_screen.dart';

void registerAllPreviews() {
  final r = PreviewRegistry.instance;

  // --- Design System ---
  r.registerPreview(
    PreviewItem(
      id: 'tokens',
      title: 'Tokens',
      description: 'Colors, Typography, Spacing',
      category: PreviewCategory.designSystem,
      builder: (context) => const TokenViewer(),
    ),
  );

  // --- Screens ---
  r.registerPreview(
    PreviewItem(
      id: 'onboarding',
      title: 'Onboarding',
      description: 'Premium welcome flow',
      category: PreviewCategory.onboarding,
      builder: (context) => const OnboardingScreen(),
    ),
  );

  // --- Pro Mode ---
  r.registerPreview(
    PreviewItem(
      id: 'pro-lobby',
      title: 'Pro Lobby',
      description: 'Competitive session setup',
      category: PreviewCategory.pro,
      builder: (context) => const ProLobbyScreen(),
    ),
  );

  // --- Tournaments ---
  r.registerPreview(
    PreviewItem(
      id: 'tournament-discovery',
      title: 'Tournament Discovery',
      description: 'Live and upcoming events',
      category: PreviewCategory.tournament,
      builder: (context) => const TournamentDiscoveryScreen(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'tournament-lobby',
      title: 'Tournament Lobby',
      description: 'Waiting area with countdown',
      category: PreviewCategory.tournament,
      builder: (context) =>
          const TournamentLobbyScreen(tournamentId: 'mock_t1'),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'tournament-results',
      title: 'Tournament Results',
      description: 'Winner celebration',
      category: PreviewCategory.tournament,
      builder: (context) =>
          const TournamentResultsScreen(tournamentId: 'mock_winner'),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'tournament-leaderboard',
      title: 'Final Leaderboard',
      description: 'Top 100 ranking',
      category: PreviewCategory.tournament,
      builder: (context) =>
          const TournamentLeaderboardScreen(tournamentId: 'mock_leaderboard'),
    ),
  );

  // --- Profile ---
  r.registerPreview(
    PreviewItem(
      id: 'player-profile',
      title: 'Player Profile',
      description: 'User settings and account',
      category: PreviewCategory.profile,
      builder: (context) => const PlayerProfileScreen(),
    ),
  );

  // --- Dialogs ---
  r.registerPreview(
    PreviewItem(
      id: 'logout-confirmation',
      title: 'Logout Confirmation',
      description: 'Secure sign-out prompt',
      category: PreviewCategory.dialogs,
      builder: (context) => const LogoutConfirmationDialog(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'answer-review',
      title: 'Competitive Review',
      description: 'Detailed answer breakdown',
      category: PreviewCategory.dialogs,
      builder: (context) => const CompetitiveReviewScreen(
        items: [], // Add items if needed
      ),
    ),
  );
}
