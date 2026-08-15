import 'dart:ui';
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
import '../../../features/player/preview/competitive_profile_previews.dart';
import '../../../features/player/preview/statistics_previews.dart';
import '../../../features/player/preview/milestone_previews.dart';
import '../../../features/player/preview/leaderboard_insights_previews.dart';
import '../../../features/player/preview/personal_record_previews.dart';
import '../../../features/notifications/preview/notification_previews.dart';
import '../../../features/player/preview/activity_previews.dart';
import '../../../features/player/preview/goal_previews.dart';
import '../../../features/player/preview/mission_previews.dart';
import '../../../features/player/preview/streak_previews.dart';
import '../../../features/player/preview/match_history_previews.dart';
import '../../../features/player/preview/rematch_previews.dart';
import 'package:soteria/features/player/preview/presence_previews.dart';
import '../../../features/player/preview/reward_previews.dart';
import '../../../features/player/preview/rank_polish_previews.dart';
import '../../../features/player/preview/public_profile_preview.dart';
import '../../../features/player/preview/challenge_previews.dart';
import '../../../features/matchmaking/preview/matchmaking_previews.dart';
import '../../../features/matchmaking/preview/match_lifecycle_previews.dart';
import '../../../features/matchmaking/preview/competitive_insights_previews.dart';
import '../../../features/matchmaking/preview/match_replay_previews.dart';
import '../categories/taxonomy_preview.dart';
import '../categories/question_bank_preview.dart';
import '../personalization/personalization_preview.dart';
import '../practice/practice_previews.dart';
import '../pro_mode/pro_mode_previews.dart';
import '../pro_mode/pro_gameplay_previews.dart';
import '../../features/dashboard/presentation/screens/practice_lobby_screen.dart';
import '../../features/practice/presentation/screens/practice_gameplay_screen.dart';
import '../../features/practice/presentation/screens/practice_results_screen.dart';
import '../../features/gameplay_engine/models/game_state.dart';

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

  r.registerPreview(
    PreviewItem(
      id: 'taxonomy-foundation',
      title: 'Question Taxonomy',
      description: 'Categories, Subcategories, and Topics',
      category: PreviewCategory.gameplay,
      builder: (context) => const TaxonomyPreview(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'question-bank-foundation',
      title: 'Question Bank',
      description: 'Unified repository for all game modes',
      category: PreviewCategory.gameplay,
      builder: (context) => const QuestionBankPreview(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'personalization-bridge',
      title: 'Personalization & Selection',
      description: 'User interests mapping to question pool',
      category: PreviewCategory.gameplay,
      builder: (context) => const PersonalizationPreview(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'practice-setup',
      title: 'Practice Mode - Setup',
      description: 'Configuration for category and difficulty',
      category: PreviewCategory.gameplay,
      builder: (context) => PracticePreviews.setup(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'practice-results-perfect',
      title: 'Practice Mode - Results (Perfect)',
      description: '100% accuracy screen',
      category: PreviewCategory.gameplay,
      builder: (context) => PracticePreviews.resultsPerfect(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'practice-results-average',
      title: 'Practice Mode - Results (Average)',
      description: 'Mixed performance summary',
      category: PreviewCategory.gameplay,
      builder: (context) => PracticePreviews.resultsAverage(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'practice-results-poor',
      title: 'Practice Mode - Results (Poor)',
      description: 'Low accuracy screen with review',
      category: PreviewCategory.gameplay,
      builder: (context) => PracticePreviews.resultsPoor(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'practice-improvement',
      title: 'Practice Mode - Improvement',
      description: 'Showing comparison with previous session',
      category: PreviewCategory.gameplay,
      builder: (context) => PracticePreviews.improvementInsight(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'practice-weakness',
      title: 'Practice Mode - Weakness Insight',
      description: 'Identified learning gap',
      category: PreviewCategory.gameplay,
      builder: (context) => PracticePreviews.weakCategoryInsight(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'practice-difficulty-insight',
      title: 'Practice Mode - Difficulty Insight',
      description: 'Performance by level',
      category: PreviewCategory.gameplay,
      builder: (context) => PracticePreviews.difficultyInsight(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'practice-history-empty',
      title: 'Practice Journey - Empty',
      description: 'New user history state',
      category: PreviewCategory.gameplay,
      builder: (context) => PracticePreviews.historyEmpty(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'practice-history-full',
      title: 'Practice Journey - Active',
      description: 'History with trends and stats',
      category: PreviewCategory.gameplay,
      builder: (context) => PracticePreviews.historyFull(),
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

  r.registerPreview(
    PreviewItem(
      id: 'notification-center',
      title: 'Notification Center',
      description: 'Unified event awareness',
      category: PreviewCategory.notifications,
      builder: (context) => NotificationPreviews.center(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'notification-banner',
      title: 'In-App Banner',
      description: 'Real-time competitive alert',
      category: PreviewCategory.notifications,
      builder: (context) => NotificationPreviews.banner(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'notification-empty',
      title: 'Notifications - Empty',
      description: 'All caught up state',
      category: PreviewCategory.notifications,
      builder: (context) => NotificationPreviews.empty(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'competitive-activity',
      title: 'Career Timeline',
      description: 'Chronological career journal',
      category: PreviewCategory.profile,
      builder: (context) => ActivityPreviews.full(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'activity-empty',
      title: 'Activity - Empty',
      description: 'New journey start',
      category: PreviewCategory.profile,
      builder: (context) => ActivityPreviews.empty(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'competitive-goals',
      title: 'Competitive Goals',
      description: 'Long-term player objectives',
      category: PreviewCategory.profile,
      builder: (context) => GoalPreviews.full(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'competitive-missions',
      title: 'Competitive Missions',
      description: 'Daily & Weekly objectives',
      category: PreviewCategory.profile,
      builder: (context) => MissionPreviews.full(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'mission-details',
      title: 'Mission Details',
      description: 'Objective deep dive',
      category: PreviewCategory.profile,
      builder: (context) => MissionPreviews.details(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'mission-history',
      title: 'Mission History',
      description: 'Completed career objectives',
      category: PreviewCategory.profile,
      builder: (context) => MissionPreviews.history(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'missions-empty',
      title: 'Missions - Empty',
      description: 'All caught up state',
      category: PreviewCategory.profile,
      builder: (context) => MissionPreviews.empty(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'goals-empty',
      title: 'Goals - Empty',
      description: 'All missions completed',
      category: PreviewCategory.profile,
      builder: (context) => GoalPreviews.empty(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'streak-win3',
      title: 'Streak - 3 Wins',
      description: 'Active win streak state',
      category: PreviewCategory.profile,
      builder: (context) => StreakPreviews.win3(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'streak-win10',
      title: 'Streak - 10 Wins (Peak)',
      description: 'Maximum momentum state',
      category: PreviewCategory.profile,
      builder: (context) => StreakPreviews.win10(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'competitive-match-history',
      title: 'Match History',
      description: 'Competitive results and performance',
      category: PreviewCategory.profile,
      builder: (context) => MatchHistoryPreviews.full(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'match-history-empty',
      title: 'Match History - Empty',
      description: 'New journey state',
      category: PreviewCategory.profile,
      builder: (context) => MatchHistoryPreviews.empty(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'player-search',
      title: 'Player Search',
      description: 'Find competitors by name',
      category: PreviewCategory.profile,
      builder: (context) => PublicProfilePreviews.search(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'public-profile-elite',
      title: 'Public Profile - Elite',
      description: 'Prestigious competitor view',
      category: PreviewCategory.profile,
      builder: (context) => PublicProfilePreviews.elite(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'public-profile-new',
      title: 'Public Profile - New',
      description: 'Initial competitive identity',
      category: PreviewCategory.profile,
      builder: (context) => PublicProfilePreviews.newPlayer(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'quick-actions',
      title: 'Competitive Quick Actions',
      description: 'Contextual player buttons',
      category: PreviewCategory.profile,
      builder: (context) => RematchPreviews.opponentCard(),
    ),
  );
  r.registerPreview(
    PreviewItem(
      id: 'challenge-center',
      title: 'Challenge Center',
      description: 'Manage invitations',
      category: PreviewCategory.profile,
      builder: (context) => ChallengePreviews.center(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'challenge-create',
      title: 'Create Challenge',
      description: 'Send new showdown',
      category: PreviewCategory.profile,
      builder: (context) => ChallengePreviews.create(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'challenge-history',
      title: 'Challenge History',
      description: 'Past competitive results',
      category: PreviewCategory.profile,
      builder: (context) => ChallengePreviews.history(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'recent-opponents',
      title: 'Recent Opponents Section',
      description: 'Horizontal quick-scroll opponents',
      category: PreviewCategory.profile,
      builder: (context) => RematchPreviews.recentSection(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'recent-opponents-list',
      title: 'Recent Opponents List',
      description: 'Vertical list of opponent cards',
      category: PreviewCategory.profile,
      builder: (context) => RematchPreviews.recentList(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'challenge-sheet',
      title: 'Challenge Sheet',
      description: 'Configure 1v1 match',
      category: PreviewCategory.profile,
      builder: (context) => ChallengePreviews.sheet(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'matchmaking-lobby',
      title: 'Versus Lobby',
      description: 'Configure 1v1',
      category: PreviewCategory.gameplay,
      builder: (context) => MatchmakingPreviews.lobby(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'matchmaking-searching',
      title: 'Searching...',
      description: 'Queue status',
      category: PreviewCategory.gameplay,
      builder: (context) => MatchmakingPreviews.searching(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'matchmaking-found',
      title: 'Match Found',
      description: 'Opponent revealed',
      category: PreviewCategory.gameplay,
      builder: (context) => MatchmakingPreviews.matchFound(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'matchmaking-confirmed',
      title: 'Match Ready',
      description: 'Both players ready',
      category: PreviewCategory.gameplay,
      builder: (context) => MatchmakingPreviews.matchFound(meReady: true, oppReady: true),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'versus-ready',
      title: 'Versus: Preparing',
      description: 'Side-by-side ready check',
      category: PreviewCategory.gameplay,
      builder: (context) => MatchLifecyclePreviews.ready(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'versus-countdown',
      title: 'Versus: Countdown',
      description: 'Start sequence',
      category: PreviewCategory.gameplay,
      builder: (context) => MatchLifecyclePreviews.countdown(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'versus-victory',
      title: 'Versus: Victory',
      description: 'Match result summary',
      category: PreviewCategory.gameplay,
      builder: (context) => MatchLifecyclePreviews.victory(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'versus-defeat',
      title: 'Versus: Defeat',
      description: 'Match result summary',
      category: PreviewCategory.gameplay,
      builder: (context) => MatchLifecyclePreviews.defeat(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'versus-draw',
      title: 'Versus: Draw',
      description: 'Match result summary',
      category: PreviewCategory.gameplay,
      builder: (context) => MatchLifecyclePreviews.draw(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'versus-rank-up',
      title: 'Versus: Rank Up',
      description: 'Victory with promotion',
      category: PreviewCategory.gameplay,
      builder: (context) => MatchLifecyclePreviews.rankUp(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'versus-insights',
      title: 'Competitive Insights',
      description: 'Performance trends',
      category: PreviewCategory.gameplay,
      builder: (context) => CompetitiveInsightsPreviews.standard(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'versus-replay',
      title: 'Versus Replay',
      description: 'Step-by-step review',
      category: PreviewCategory.gameplay,
      builder: (context) => MatchReplayPreviews.standard(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'season-active',
      title: 'Season - Active',
      description: 'Season dashboard',
      category: PreviewCategory.gameplay,
      builder: (context) => SeasonPreviews.active(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'season-upcoming',
      title: 'Season - Upcoming',
      description: 'Next season info',
      category: PreviewCategory.gameplay,
      builder: (context) => SeasonPreviews.upcoming(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'season-ending',
      title: 'Season - Ending',
      description: 'Urgency phase',
      category: PreviewCategory.gameplay,
      builder: (context) => SeasonPreviews.endingSoon(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'season-completed',
      title: 'Season - Completed',
      description: 'Review phase',
      category: PreviewCategory.gameplay,
      builder: (context) => SeasonPreviews.completed(),
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

  r.registerPreview(
    PreviewItem(
      id: 'pro-available',
      title: 'Pro Mode - Available',
      description: 'Standard access state',
      category: PreviewCategory.pro,
      builder: (context) => ProModePreviews.available(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'pro-locked',
      title: 'Pro Mode - Locked',
      description: 'Level requirement not met',
      category: PreviewCategory.pro,
      builder: (context) => ProModePreviews.locked(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'pro-insufficient-coins',
      title: 'Pro Mode - Insufficient Coins',
      description: 'Entry fee check fail',
      category: PreviewCategory.pro,
      builder: (context) => ProModePreviews.insufficientCoins(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'pro-insufficient-questions',
      title: 'Pro Mode - Insufficient Questions',
      description: 'Bank pool check fail',
      category: PreviewCategory.pro,
      builder: (context) => ProModePreviews.insufficientQuestions(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'pro-offline',
      title: 'Pro Mode - Offline',
      description: 'Connection required overlay',
      category: PreviewCategory.pro,
      builder: (context) => ProModePreviews.offline(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'pro-gameplay-start',
      title: 'Pro Gameplay - Start',
      description: 'First question of premium match',
      category: PreviewCategory.pro,
      builder: (context) => ProGameplayPreviews.active(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'pro-gameplay-mid',
      title: 'Pro Gameplay - Mid Session',
      description: 'Active match with progress',
      category: PreviewCategory.pro,
      builder: (context) => ProGameplayPreviews.midSession(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'pro-gameplay-final',
      title: 'Pro Gameplay - Final Question',
      description: 'High stakes last challenge',
      category: PreviewCategory.pro,
      builder: (context) => ProGameplayPreviews.finalQuestion(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'pro-gameplay-correct',
      title: 'Pro Gameplay - Correct Feedback',
      description: 'Reveal state after correct answer',
      category: PreviewCategory.pro,
      builder: (context) => ProGameplayPreviews.answeredCorrect(),
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
      id: 'player-presence',
      title: 'Player Presence',
      description: 'Live availability indicators',
      category: PreviewCategory.profile,
      builder: (context) => PresencePreviews.indicators(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'competitive-player-card',
      title: 'Competitive Player Card',
      description: 'Unified player profile row',
      category: PreviewCategory.profile,
      builder: (context) => PresencePreviews.playerCard(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'competitive-profile',
      title: 'Competitive Profile',
      description: 'Athletic career identity',
      category: PreviewCategory.profile,
      builder: (context) => CompetitiveProfilePreviews.ranked(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'competitive-statistics',
      title: 'Competitive Statistics',
      description: 'Performance analytics center',
      category: PreviewCategory.profile,
      builder: (context) => StatisticsPreviews.standard(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'stats-improving',
      title: 'Stats - Improving',
      description: 'Upward performance trend',
      category: PreviewCategory.profile,
      builder: (context) => StatisticsPreviews.improving(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'stats-declining',
      title: 'Stats - Declining',
      description: 'Downward performance trend',
      category: PreviewCategory.profile,
      builder: (context) => StatisticsPreviews.declining(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'stats-empty',
      title: 'Stats - Empty',
      description: 'New player initial metrics',
      category: PreviewCategory.profile,
      builder: (context) => StatisticsPreviews.empty(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'milestone-gallery',
      title: 'Achievement Gallery',
      description: 'Competitive career milestones',
      category: PreviewCategory.profile,
      builder: (context) => MilestonePreviews.gallery(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'milestone-empty',
      title: 'Milestones - Empty',
      description: 'No achievements state',
      category: PreviewCategory.profile,
      builder: (context) => MilestonePreviews.empty(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'personal-records',
      title: 'Personal Records',
      description: 'Career bests & Season records',
      category: PreviewCategory.profile,
      builder: (context) => PersonalRecordPreviews.gallery(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'profile-unranked',
      title: 'Profile - Unranked',
      description: 'New player initial state',
      category: PreviewCategory.profile,
      builder: (context) => CompetitiveProfilePreviews.unranked(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'profile-loading',
      title: 'Profile - Loading',
      description: 'Data aggregation state',
      category: PreviewCategory.profile,
      builder: (context) => CompetitiveProfilePreviews.loading(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'profile-error',
      title: 'Profile - Error',
      description: 'Sync failure recovery',
      category: PreviewCategory.profile,
      builder: (context) => CompetitiveProfilePreviews.error(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'profile-tablet',
      title: 'Profile - Tablet',
      description: 'Wide viewport adaptation',
      category: PreviewCategory.profile,
      builder: (context) =>
          CompetitiveProfilePreviews.responsive(const Size(1024, 768)),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'profile-large-text',
      title: 'Profile - Large Text',
      description: 'Accessibility scaling',
      category: PreviewCategory.profile,
      builder: (context) => CompetitiveProfilePreviews.largeText(),
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
      id: 'leaderboard-neighborhood',
      title: 'Leaderboard Neighborhood',
      description: 'Players above and below',
      category: PreviewCategory.profile,
      builder: (context) => LeaderboardInsightsPreviews.neighborhood(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'rank-progress',
      title: 'Rank Progress',
      description: 'Promotion threshold tracking',
      category: PreviewCategory.profile,
      builder: (context) => LeaderboardInsightsPreviews.rankProgress(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'leaderboard-insight',
      title: 'Leaderboard Insight',
      description: 'Deterministic performance analysis',
      category: PreviewCategory.profile,
      builder: (context) => LeaderboardInsightsPreviews.insightCard(),
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

  // --- Rewards ---
  r.registerPreview(
    PreviewItem(
      id: 'reward-gallery',
      title: 'Reward Gallery',
      description: 'Competitive prizes & history',
      category: PreviewCategory.profile,
      builder: (context) => const RewardPreviews(),
    ),
  );

  r.registerPreview(
    PreviewItem(
      id: 'rank-polish',
      title: 'Rank Progression Polish',
      description: 'Unified rank experience and cards',
      category: PreviewCategory.profile,
      builder: (context) => const RankPolishPreviews(),
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
