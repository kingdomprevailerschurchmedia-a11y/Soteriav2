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
  static const String proMode = '/app/pro-mode';
  static const String versus = '/app/versus';
  static const String tournaments = '/app/tournaments';
  static const String tournamentLobby = '/app/tournaments/lobby/:id';
  static const String tournamentDetails = '/app/tournaments/details/:id';
  static const String tournamentGameplay = '/app/tournaments/play/:id';
  static const String leaderboard = '/app/leaderboard';
  static const String wallet = '/app/wallet';
  static const String profile = '/app/profile';
  static const String settings = '/app/settings';

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
  static const String notifications = '/notifications';
  static const String configDebug = '/preview-gallery/config-debug';
  static const String securityStatus = '/preview-gallery/security-status';
  static const String proLobby = '/preview-gallery/pro-lobby';
}
