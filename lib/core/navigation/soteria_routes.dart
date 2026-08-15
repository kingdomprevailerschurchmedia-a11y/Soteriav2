class SoteriaRoutes {
  // Foundation
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String personalization = '/personalization';

  // Authentication
  static const String auth = '/auth';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';

  // Main App (Shell)
  static const String main = '/app';
  static const String practice = '/app/practice';
  static const String practiceSession = '/app/practice/session';
  static const String practiceResults = '/app/practice/results';
  static const String practiceHistory = '/app/practice/history';
  static const String practiceHistoryDetail = '/app/practice/history/:id';
  static const String proMode = '/app/pro-mode';
  static const String proGameplay = '/app/pro-mode/play';
  static const String proResults = '/app/pro-mode/results';
  static const String proReview = '/app/pro-mode/review/:id';
  static const String versus = '/app/versus';
  static const String versusLobby = '/app/versus/lobby';
  static const String matchmaking = '/app/matchmaking';
  static const String matchFound = '/app/match-found';
  static const String challenges = '/app/challenges';
  static const String createChallenge = '/app/challenges/create';
  static const String season = '/app/season';
  static const String tournaments = '/app/tournaments';
  static const String tournamentLobby = '/app/tournaments/lobby/:id';
  static const String tournamentDetails = '/app/tournaments/details/:id';
  static const String tournamentGameplay = '/app/tournaments/play/:id';
  static const String competitiveEvents = '/app/events';
  static const String competitiveEventDetails = '/app/events/details/:id';
  static const String eventGameplay = '/app/events/play/:id';
  static const String eventResult = '/app/events/result/:id';
  static const String eventLeaderboard = '/app/events/leaderboard/:id';
  static const String eventHistory = '/app/events/history';
  static const String leaderboard = '/app/leaderboard';
  static const String competitiveHistory = '/app/profile/history';
  static const String achievements = '/app/profile/achievements';
  static const String personalRecords = '/app/profile/records';
  static const String versusMatchResult = '/app/versus/result/:id';
  static const String versusMatchReplay = '/app/versus/replay/:id';
  static const String competitiveInsights = '/app/versus/insights';
  static const String wallet = '/app/wallet';
  static const String profile = '/app/profile';
  static const String publicProfile = '/app/profile/external/:id';
  static const String playerSearch = '/app/profile/search';
  static const String friends = '/app/profile/friends';
  static const String friendRequests = '/app/profile/friends/requests';
  static const String settings = '/app/settings';
  static const String notificationSettings = '/app/settings/notifications';

  // Quiz Gameplay
  static const String quizGameplay = '/quiz-gameplay';
  static const String quizResults = '/quiz-results';
  static const String quizHistory = '/quiz-history';
  static const String quizHistoryDetail = '/quiz-history/detail';

  // Developer Gallery
  static const String previewGallery = '/preview-gallery';
  static const String tokens = '/preview-gallery/tokens';
  static const String gradients = '/preview-gallery/gradients';
  static const String lighting = '/preview-gallery/lighting';
  static const String surfaces = '/preview-gallery/surfaces';
  static const String buttons = '/preview-gallery/buttons';
  static const String cards = '/preview-gallery/cards';
  static const String inputs = '/preview-gallery/inputs';
  static const String feedback = '/preview-gallery/feedback';
  static const String typography = '/preview-gallery/typography';
  static const String overlays = '/preview-gallery/overlays';
  static const String navigation = '/preview-gallery/navigation';
  static const String animations = '/preview-gallery/animations';
  static const String startup = '/preview-gallery/startup';
  static const String navigationFoundation = '/preview-gallery/nav-foundation';
  static const String diagnostics = '/preview-gallery/diagnostics';
  static const String player = '/preview-gallery/player';
  static const String personalRecordsPreview = '/preview-gallery/personal-records';
  static const String notifications = '/notifications';
  static const String configDebug = '/preview-gallery/config-debug';
  static const String securityStatus = '/preview-gallery/security-status';
  static const String proLobby = '/preview-gallery/pro-lobby';
  static const String proResultsPreview = '/preview-gallery/pro-results';
  static const String quizHistoryPreview = '/preview-gallery/quiz-history';
  static const String avatarPlatform = '/preview-gallery/avatars';
  static const String socialPreview = '/preview-gallery/social';
}
