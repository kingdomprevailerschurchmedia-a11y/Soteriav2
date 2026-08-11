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
import '../../../features/quiz/preview/question_loader_previews.dart';
import '../../../features/quiz/preview/gameplay_previews.dart';
import '../../../features/quiz/preview/recovery_previews.dart';
import '../../../features/quiz/preview/results_previews.dart';
import '../../../features/quiz/preview/certification_previews.dart';
import '../../../features/analytics/preview/analytics_previews.dart';
import '../../../features/player/preview/progression_previews.dart';
import '../../../features/player/preview/leaderboard_previews.dart';
import '../../../features/player/preview/season_previews.dart';
import '../../../features/player/preview/competitive_history_previews.dart';

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
      id: 'onboarding-p1',
      title: 'Onboarding - Page 1',
      description: 'Premium welcome: Compete. Learn. Rise.',
      category: PreviewCategory.onboarding,
      builder: (context) => const OnboardingScreen(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'onboarding-tablet',
      title: 'Onboarding - Tablet',
      description: 'Adaptive layout for large screens',
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

  r.registerPreview(
    PreviewItem(
      id: 'progression-card-gold',
      title: 'Progression Card - Gold',
      description: 'Premium progression surface',
      category: PreviewCategory.profile,
      builder: (context) => ProgressionPreviews.cardGold(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'level-up-celebration',
      title: 'Level Up Celebration',
      description: 'Fullscreen achievement overlay',
      category: PreviewCategory.profile,
      builder: (context) => ProgressionPreviews.levelUp(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'rank-promotion',
      title: 'Rank Promotion',
      description: 'Tier ascension celebration',
      category: PreviewCategory.profile,
      builder: (context) => ProgressionPreviews.promotion(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'rank-demotion',
      title: 'Rank Demotion',
      description: 'Tier regression notice',
      category: PreviewCategory.profile,
      builder: (context) => ProgressionPreviews.demotion(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'rank-badges',
      title: 'Rank Badges',
      description: 'Competitive tier identity',
      category: PreviewCategory.profile,
      builder: (context) => ProgressionPreviews.rankBadges(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'leaderboard-top',
      title: 'Leaderboard - Top 20',
      description: 'Global rankings with podium',
      category: PreviewCategory.profile,
      builder: (context) => LeaderboardPreviews.topList(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'leaderboard-mid',
      title: 'Leaderboard - Mid Rank',
      description: 'Surrounding rank position',
      category: PreviewCategory.profile,
      builder: (context) => LeaderboardPreviews.midRank(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'leaderboard-empty',
      title: 'Leaderboard - Empty',
      description: 'No competitive data state',
      category: PreviewCategory.profile,
      builder: (context) => LeaderboardPreviews.empty(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'season-active',
      title: 'Season - Active',
      description: 'Standard season status',
      category: PreviewCategory.profile,
      builder: (context) => SeasonPreviews.active(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'season-ending',
      title: 'Season - Ending Soon',
      description: 'High urgency countdown',
      category: PreviewCategory.profile,
      builder: (context) => SeasonPreviews.endingSoon(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'season-upcoming',
      title: 'Season - Upcoming',
      description: 'Future season countdown',
      category: PreviewCategory.profile,
      builder: (context) => SeasonPreviews.upcoming(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'season-completed',
      title: 'Season - Completed',
      description: 'Post-season status',
      category: PreviewCategory.profile,
      builder: (context) => SeasonPreviews.completed(),
    ),
  );

  // --- Competitive History ---
  r.registerPreview(
    PreviewItem(
      id: 'competitive-history',
      title: 'Competitive History',
      description: 'Career achievement archive',
      category: PreviewCategory.profile,
      builder: (context) => CompetitiveHistoryPreviews.fullHistory(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'history-empty',
      title: 'History - Empty',
      description: 'New player journey start',
      category: PreviewCategory.profile,
      builder: (context) => CompetitiveHistoryPreviews.empty(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'history-loading',
      title: 'History - Loading',
      description: 'Skeleton loading state',
      category: PreviewCategory.profile,
      builder: (context) => CompetitiveHistoryPreviews.loading(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'history-error',
      title: 'History - Error',
      description: 'Failure state recovery',
      category: PreviewCategory.profile,
      builder: (context) => CompetitiveHistoryPreviews.error(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'history-unranked',
      title: 'History - Unranked',
      description: 'Participation without rank',
      category: PreviewCategory.profile,
      builder: (context) => CompetitiveHistoryPreviews.unranked(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'history-reduced-motion',
      title: 'History - Reduced Motion',
      description: 'Accessibility mode verification',
      category: PreviewCategory.profile,
      builder: (context) => CompetitiveHistoryPreviews.reducedMotion(),
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

  // --- Quiz Data Pipeline ---
  r.registerPreview(
    PreviewItem(
      id: 'question-loader-loaded',
      title: 'Questions Loaded',
      description: 'Mock data source list',
      category: PreviewCategory.quizData,
      builder: (context) => const QuestionLoaderLoadedPreview(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'question-loader-empty',
      title: 'Questions Empty',
      description: 'Empty collection state',
      category: PreviewCategory.quizData,
      builder: (context) => const QuestionLoaderEmptyPreview(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'question-loader-error',
      title: 'Questions Error',
      description: 'Remote failure simulation',
      category: PreviewCategory.quizData,
      builder: (context) => const QuestionLoaderErrorPreview(),
    ),
  );

  // --- Gameplay ---
  r.registerPreview(
    PreviewItem(
      id: 'gameplay-active',
      title: 'Active Gameplay',
      description: 'Premium session UI',
      category: PreviewCategory.gameplay,
      builder: (context) => GameplayPreviews.active(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'gameplay-timer-warning',
      title: 'Timer Warning',
      description: 'Critical timer state',
      category: PreviewCategory.gameplay,
      builder: (context) => GameplayPreviews.timerWarning(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'gameplay-timer-critical',
      title: 'Timer Critical',
      description: 'Critical urgency state',
      category: PreviewCategory.gameplay,
      builder: (context) => GameplayPreviews.timerCritical(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'gameplay-expired',
      title: 'Timer Expired',
      description: 'Timeout transition state',
      category: PreviewCategory.gameplay,
      builder: (context) => GameplayPreviews.expired(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'gameplay-selected',
      title: 'Answer Selected',
      description: 'Locked interaction state',
      category: PreviewCategory.gameplay,
      builder: (context) => GameplayPreviews.selected(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'gameplay-correct',
      title: 'Correct Answer',
      description: 'Success feedback state',
      category: PreviewCategory.gameplay,
      builder: (context) => GameplayPreviews.correct(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'gameplay-incorrect',
      title: 'Incorrect Answer',
      description: 'Error feedback & reveal',
      category: PreviewCategory.gameplay,
      builder: (context) => GameplayPreviews.incorrect(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'gameplay-5050',
      title: '50/50 Activated',
      description: 'Hidden options state',
      category: PreviewCategory.gameplay,
      builder: (context) => GameplayPreviews.fiftyFiftyActivated(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'gameplay-paused',
      title: 'Timer Paused',
      description: 'Power-up pause state',
      category: PreviewCategory.gameplay,
      builder: (context) => GameplayPreviews.timerPaused(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'gameplay-audience',
      title: 'Audience Poll',
      description: 'Results distribution UI',
      category: PreviewCategory.gameplay,
      builder: (context) => GameplayPreviews.audienceResults(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'gameplay-loading',
      title: 'Gameplay Loading',
      description: 'Session initialization',
      category: PreviewCategory.gameplay,
      builder: (context) => GameplayPreviews.loading(),
    ),
  );

  // --- Recovery ---
  r.registerPreview(
    PreviewItem(
      id: 'recovery-available',
      title: 'Recovery Available',
      description: 'Active session found dialog',
      category: PreviewCategory.gameplay,
      builder: (context) => RecoveryPreviews.available(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'recovery-recovering',
      title: 'Recovering State',
      description: 'Restoration in progress',
      category: PreviewCategory.gameplay,
      builder: (context) => RecoveryPreviews.recovering(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'recovery-failed',
      title: 'Recovery Failed',
      description: 'Error during restoration',
      category: PreviewCategory.gameplay,
      builder: (context) => RecoveryPreviews.failed(),
    ),
  );

  // --- Results ---
  r.registerPreview(
    PreviewItem(
      id: 'results-excellent',
      title: 'Excellent Results',
      description: 'High performance summary',
      category: PreviewCategory.gameplay,
      builder: (context) => ResultsPreviews.excellent(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'results-perfect',
      title: 'Perfect Quiz',
      description: '100% accuracy hero state',
      category: PreviewCategory.gameplay,
      builder: (context) => ResultsPreviews.perfect(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'results-average',
      title: 'Average Results',
      description: 'Mixed performance summary',
      category: PreviewCategory.gameplay,
      builder: (context) => ResultsPreviews.average(),
    ),
  );

  // --- Analytics ---
  r.registerPreview(
    PreviewItem(
      id: 'analytics-dashboard',
      title: 'Performance Dashboard',
      description: 'Personal intelligence hub',
      category: PreviewCategory.analytics,
      builder: (context) => const AnalyticsPreviews(),
    ),
  );

  // --- Certification ---
  r.registerPreview(
    PreviewItem(
      id: 'quiz-certification',
      title: 'Quiz E2E Certification',
      description: 'Hardening & integration pass',
      category: PreviewCategory.devTools,
      builder: (context) => const CertificationPreviews(),
    ),
  );
}
