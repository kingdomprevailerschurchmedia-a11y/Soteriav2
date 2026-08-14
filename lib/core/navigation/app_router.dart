import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/navigation/transitions/soteria_page_transitions.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'package:soteria/features/onboarding/screens/onboarding_screen.dart';
import 'package:soteria/features/personalization/screens/personalization_screen.dart';
import 'package:soteria/features/auth/screens/auth_landing_screen.dart';
import 'package:soteria/features/auth/screens/registration_screen.dart';
import 'package:soteria/features/auth/screens/login_screen.dart';
import 'package:soteria/features/auth/screens/verification_orchestrator.dart';
import 'package:soteria/features/auth/models/verification_type.dart';
import 'package:soteria/features/preview_gallery/preview_gallery_screen.dart';
import 'package:soteria/features/preview_gallery/widgets/gallery_shell.dart';
import 'package:soteria/features/preview_gallery/pages/gradients_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/lighting_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/surfaces_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/cards_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/inputs_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/feedback_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/typography_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/overlays_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/navigation_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/animations_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/startup_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/navigation_foundation_page.dart';
import 'package:soteria/features/preview_gallery/pages/onboarding_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/personalization_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/avatar_platform_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/auth_landing_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/registration_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/login_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/verification_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/identity_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/diagnostics_preview_page.dart';
import 'package:soteria/features/quiz/preview/quiz_engine_preview.dart';
import 'package:soteria/features/quiz/preview/history_previews.dart';
import 'package:soteria/features/gameplay_engine/pages/game_preview_gallery.dart';
import 'package:soteria/features/preview_gallery/pages/question_pipeline_preview_page.dart';
import 'package:soteria/features/question_presentation/pages/presentation_preview_gallery.dart';
import 'package:soteria/features/gameplay_engine/timer/pages/timer_preview_gallery.dart';
import 'package:soteria/features/gameplay_engine/answer/pages/answer_preview_gallery.dart';
import 'package:soteria/features/gameplay_engine/lifelines/pages/lifeline_preview_gallery.dart';
import 'package:soteria/features/preview_gallery/pages/progression_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/integrity_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/tokens_preview.dart';
import 'package:soteria/features/preview_gallery/pages/buttons_preview.dart';
import 'package:soteria/features/preview_gallery/pages/dashboard_redesign_preview.dart';
import 'package:soteria/features/preview_gallery/pages/login_redesign_preview.dart';
import 'package:soteria/features/preview_gallery/pages/gameplay_redesign_preview.dart';
import 'package:soteria/features/preview_gallery/pages/lobby_redesign_preview.dart';
import 'package:soteria/features/preview_gallery/pages/results_redesign_preview.dart';
import 'package:soteria/features/quiz/presentation/screens/quiz_gameplay_screen.dart';
import 'package:soteria/features/quiz/presentation/screens/quiz_results_screen.dart';
import 'package:soteria/features/quiz/presentation/screens/quiz_history_screen.dart';
import 'package:soteria/features/quiz/presentation/screens/quiz_history_detail_screen.dart';
import 'package:soteria/features/quiz/domain/models/quiz_result.dart';
import 'package:soteria/features/error_routing/unknown_route_screen.dart';
import 'package:soteria/features/splash/presentation/screens/splash_screen.dart';
import 'package:soteria/features/notifications/screens/notification_center_screen.dart';

import 'package:soteria/core/identity/models/user_session.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:soteria/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:soteria/features/dashboard/presentation/screens/practice_lobby_screen.dart';
import 'package:soteria/features/dashboard/presentation/screens/home_shell.dart';
import 'package:soteria/shared/screens/coming_soon_screen.dart';
import 'package:soteria/features/settings/screens/settings_screen.dart';
import 'package:soteria/features/settings/screens/notification_settings_screen.dart';

import 'package:soteria/features/preview_gallery/pages/pro_lobby_preview_page.dart';
import 'package:soteria/features/dashboard/presentation/screens/pro_lobby_screen.dart';

import 'package:soteria/features/player/presentation/screens/player_profile_screen.dart';
import 'package:soteria/features/player/presentation/screens/personal_records_screen.dart';
import 'package:soteria/features/player/presentation/screens/leaderboard_screen.dart';
import 'package:soteria/features/tournaments/presentation/screens/tournament_discovery_screen.dart';
import 'package:soteria/features/tournaments/presentation/screens/tournament_details_screen.dart';
import 'package:soteria/features/tournaments/presentation/screens/tournament_lobby_screen.dart';
import 'package:soteria/features/tournaments/presentation/screens/tournament_gameplay_screen.dart';
import 'package:soteria/features/tournaments/presentation/pages/tournament_preview_gallery.dart';
import 'package:soteria/features/preview_gallery/pages/player_preview_page.dart';
import 'package:soteria/features/player/preview/live_event_previews.dart';
import 'package:soteria/features/player/preview/personal_record_previews.dart';
import 'package:soteria/features/player/preview/competitive_identity_previews.dart';
import 'package:soteria/features/player/screens/config_debug_screen.dart';
import 'package:soteria/features/player/screens/security_status_screen.dart';

import 'package:soteria/features/player/presentation/screens/competitive_history_screen.dart';
import 'package:soteria/features/player/presentation/screens/challenge_center_screen.dart';
import 'package:soteria/features/player/presentation/screens/competitive_season_screen.dart';
import 'package:soteria/features/player/presentation/screens/live_events_screen.dart';
import 'package:soteria/features/player/presentation/screens/live_event_details_screen.dart';
import 'package:soteria/features/matchmaking/presentation/screens/versus_lobby_screen.dart';
import 'package:soteria/features/matchmaking/presentation/screens/matchmaking_screen.dart';
import 'package:soteria/features/matchmaking/presentation/screens/match_found_screen.dart';
import 'package:soteria/features/matchmaking/presentation/screens/versus_match_orchestrator.dart';
import 'package:soteria/features/matchmaking/presentation/screens/competitive_match_result_screen.dart';
import 'package:soteria/features/matchmaking/presentation/screens/competitive_match_replay_screen.dart';
import 'package:soteria/features/matchmaking/presentation/screens/competitive_insights_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = _RiverpodRefreshListenable(ref);
  ref.onDispose(listenable.dispose);

  // Navigator Keys for stateful shells
  final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final dashboardNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'dashboard',
  );
  final playNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'play');
  final leaderboardNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'leaderboard',
  );
  final rewardsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rewards');
  final profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

  return GoRouter(
    initialLocation: SoteriaRoutes.splash,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: listenable,
    observers: [
      if (!Platform.environment.containsKey('FLUTTER_TEST') &&
          Firebase.apps.isNotEmpty)
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
    redirect: (context, state) {
      final lifecycle = ref.read(appLifecycleProvider);
      final session = ref.read(sessionProvider);
      final location = state.uri.toString();

      if (kDebugMode && location != SoteriaRoutes.splash) {
        LoggerService.t(
          'Router Redirect Check: loc=$location, life=$lifecycle, auth=${session.status}',
          feature: 'Navigation',
        );
      }

      // 1. Loading State
      if (lifecycle == AppStartupState.loading) {
        return location == SoteriaRoutes.splash ? null : SoteriaRoutes.splash;
      }

      // 2. Splash Screen bypass (once duration is complete, it will navigate anyway)
      if (location == SoteriaRoutes.splash) return null;

      // 3. Onboarding & Personalization Gates
      if (lifecycle == AppStartupState.onboarding) {
        return location == SoteriaRoutes.onboarding
            ? null
            : SoteriaRoutes.onboarding;
      }

      if (lifecycle == AppStartupState.personalization) {
        // Allow auth routes during personalization (e.g. if they sign in during it)
        if (location.startsWith(SoteriaRoutes.auth)) return null;
        return location == SoteriaRoutes.personalization
            ? null
            : SoteriaRoutes.personalization;
      }

      // 4. Post-Setup Redirects (Prevent staying on setup screens)
      if (location == SoteriaRoutes.onboarding ||
          location == SoteriaRoutes.personalization) {
        return session.isAuthenticated
            ? SoteriaRoutes.main
            : SoteriaRoutes.auth;
      }

      // 5. Authentication Logic
      final isAuthenticated = session.isAuthenticated;
      final isAuthRoute = location.startsWith(SoteriaRoutes.auth);
      final isMainRoute = location.startsWith(SoteriaRoutes.main);

      if (!isAuthenticated) {
        // Not authenticated
        if (isMainRoute) {
          // If trying to access main app while not auth, go to auth landing
          return SoteriaRoutes.auth;
        }
        // Guest user in auth flow but email unverified
        if (session.uid != null &&
            session.status == SessionStatus.guest &&
            !location.contains('verify')) {
          return '${SoteriaRoutes.auth}/verify/emailVerification';
        }
      } else {
        // Authenticated
        if (isAuthRoute) {
          // If already auth, don't stay on auth pages
          return SoteriaRoutes.main;
        }
      }

      return null;
    },
    errorBuilder: (context, state) =>
        UnknownRouteScreen(location: state.uri.toString()),
    routes: [
      GoRoute(
        path: SoteriaRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/auth',
        pageBuilder: (context, state) => SoteriaPageTransitions.fade(
          child: const AuthLandingScreen(),
          key: state.pageKey,
        ),
        routes: [
          GoRoute(
            path: 'login',
            pageBuilder: (context, state) => SoteriaPageTransitions.fade(
              child: const LoginScreen(),
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: 'register',
            pageBuilder: (context, state) => SoteriaPageTransitions.fade(
              child: const RegistrationScreen(),
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: 'verify/:type',
            pageBuilder: (context, state) {
              final typeStr = state.pathParameters['type']!;
              final type = VerificationType.values.firstWhere(
                (e) => e.name == typeStr,
                orElse: () => VerificationType.emailVerification,
              );
              return SoteriaPageTransitions.fade(
                child: VerificationOrchestrator(type: type),
                key: state.pageKey,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: SoteriaRoutes.onboarding,
        pageBuilder: (context, state) => SoteriaPageTransitions.fade(
          child: const OnboardingScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: SoteriaRoutes.personalization,
        pageBuilder: (context, state) => SoteriaPageTransitions.fade(
          child: const PersonalizationScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: SoteriaRoutes.quizGameplay,
        pageBuilder: (context, state) => SoteriaPageTransitions.slideUp(
          child: const QuizGameplayScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: SoteriaRoutes.quizResults,
        pageBuilder: (context, state) => SoteriaPageTransitions.fade(
          child: const QuizResultsScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: SoteriaRoutes.quizHistory,
        pageBuilder: (context, state) => SoteriaPageTransitions.fade(
          child: const QuizHistoryScreen(),
          key: state.pageKey,
        ),
        routes: [
          GoRoute(
            path: 'detail',
            pageBuilder: (context, state) {
              final result = state.extra as QuizResult;
              return SoteriaPageTransitions.fade(
                child: QuizHistoryDetailScreen(result: result),
                key: state.pageKey,
              );
            },
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: dashboardNavigatorKey,
            routes: [
              GoRoute(
                path: SoteriaRoutes.main,
                pageBuilder: (context, state) => SoteriaPageTransitions.fade(
                  child: const DashboardScreen(),
                  key: state.pageKey,
                ),
                routes: [
                  GoRoute(
                    path: 'practice',
                    pageBuilder: (context, state) =>
                        SoteriaPageTransitions.fade(
                          child: const PracticeLobbyScreen(),
                          key: state.pageKey,
                        ),
                  ),
                  GoRoute(
                    path: 'pro-mode',
                    pageBuilder: (context, state) =>
                        SoteriaPageTransitions.fade(
                          child: const ProLobbyScreen(),
                          key: state.pageKey,
                        ),
                  ),
                  GoRoute(
                    path: 'versus',
                    pageBuilder: (context, state) =>
                        SoteriaPageTransitions.fade(
                          child: const VersusLobbyScreen(),
                          key: state.pageKey,
                        ),
                  ),
                  GoRoute(
                    path: 'matchmaking',
                    pageBuilder: (context, state) =>
                        SoteriaPageTransitions.fade(
                          child: const MatchmakingScreen(),
                          key: state.pageKey,
                        ),
                  ),
                  GoRoute(
                    path: 'match-found',
                    pageBuilder: (context, state) =>
                        SoteriaPageTransitions.fade(
                          child: const MatchFoundScreen(),
                          key: state.pageKey,
                        ),
                  ),
                  GoRoute(
                    path: 'versus/:id',
                    pageBuilder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return SoteriaPageTransitions.fade(
                        child: VersusMatchOrchestrator(matchId: id),
                        key: state.pageKey,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'versus/result/:id',
                    pageBuilder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return SoteriaPageTransitions.fade(
                        child: CompetitiveMatchResultScreen(matchId: id),
                        key: state.pageKey,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'versus/replay/:id',
                    pageBuilder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return SoteriaPageTransitions.fade(
                        child: CompetitiveMatchReplayScreen(matchId: id),
                        key: state.pageKey,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'versus/insights',
                    pageBuilder: (context, state) => SoteriaPageTransitions.slideUp(
                      child: const CompetitiveInsightsScreen(),
                      key: state.pageKey,
                    ),
                  ),
                  GoRoute(
                    path: 'challenges',
                    pageBuilder: (context, state) =>
                        SoteriaPageTransitions.fade(
                          child: const ChallengeCenterScreen(),
                          key: state.pageKey,
                        ),
                  ),
                  GoRoute(
                    path: 'season',
                    pageBuilder: (context, state) =>
                        SoteriaPageTransitions.fade(
                          child: const CompetitiveSeasonScreen(),
                          key: state.pageKey,
                        ),
                  ),
                  GoRoute(
                    path: 'events',
                    pageBuilder: (context, state) =>
                        SoteriaPageTransitions.fade(
                          child: const LiveEventsScreen(),
                          key: state.pageKey,
                        ),
                    routes: [
                      GoRoute(
                        path: 'details/:id',
                        pageBuilder: (context, state) {
                          final id = state.pathParameters['id']!;
                          return SoteriaPageTransitions.slideUp(
                            child: LiveEventDetailsScreen(eventId: id),
                            key: state.pageKey,
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'tournaments',
                    pageBuilder: (context, state) =>
                        SoteriaPageTransitions.fade(
                          child: const TournamentDiscoveryScreen(),
                          key: state.pageKey,
                        ),
                    routes: [
                      GoRoute(
                        path: 'details/:id',
                        pageBuilder: (context, state) {
                          final id = state.pathParameters['id']!;
                          return SoteriaPageTransitions.slideUp(
                            child: TournamentDetailsScreen(tournamentId: id),
                            key: state.pageKey,
                          );
                        },
                      ),
                      GoRoute(
                        path: 'lobby/:id',
                        pageBuilder: (context, state) {
                          final id = state.pathParameters['id']!;
                          return SoteriaPageTransitions.fade(
                            child: TournamentLobbyScreen(tournamentId: id),
                            key: state.pageKey,
                          );
                        },
                      ),
                      GoRoute(
                        path: 'play/:id',
                        pageBuilder: (context, state) {
                          final id = state.pathParameters['id']!;
                          return SoteriaPageTransitions.fade(
                            child: TournamentGameplayScreen(tournamentId: id),
                            key: state.pageKey,
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'settings',
                    pageBuilder: (context, state) =>
                        SoteriaPageTransitions.slideUp(
                          child: const SettingsScreen(),
                          key: state.pageKey,
                        ),
                    routes: [
                      GoRoute(
                        path: 'notifications',
                        pageBuilder: (context, state) =>
                            SoteriaPageTransitions.slideUp(
                              child: const NotificationSettingsScreen(),
                              key: state.pageKey,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: playNavigatorKey,
            routes: [
              GoRoute(
                path: '/app/play',
                pageBuilder: (context, state) => SoteriaPageTransitions.fade(
                  child: const ComingSoonScreen(
                    featureName: 'Battle Hub',
                    category: 'Game',
                  ),
                  key: state.pageKey,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: leaderboardNavigatorKey,
            routes: [
              GoRoute(
                path: SoteriaRoutes.leaderboard,
                pageBuilder: (context, state) => SoteriaPageTransitions.fade(
                  child: const LeaderboardScreen(),
                  key: state.pageKey,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: rewardsNavigatorKey,
            routes: [
              GoRoute(
                path: SoteriaRoutes.wallet,
                pageBuilder: (context, state) => SoteriaPageTransitions.fade(
                  child: const ComingSoonScreen(
                    featureName: 'Soteria Rewards',
                    category: 'Finance',
                  ),
                  key: state.pageKey,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: profileNavigatorKey,
            routes: [
              GoRoute(
                path: SoteriaRoutes.profile,
                pageBuilder: (context, state) => SoteriaPageTransitions.fade(
                  child: const PlayerProfileScreen(),
                  key: state.pageKey,
                ),
                routes: [
                  GoRoute(
                    path: 'history',
                    pageBuilder: (context, state) =>
                        SoteriaPageTransitions.slideUp(
                          child: const CompetitiveHistoryScreen(),
                          key: state.pageKey,
                        ),
                  ),
                  GoRoute(
                    path: 'records',
                    pageBuilder: (context, state) =>
                        SoteriaPageTransitions.slideUp(
                          child: const PersonalRecordsScreen(),
                          key: state.pageKey,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: SoteriaRoutes.notifications,
        pageBuilder: (context, state) => SoteriaPageTransitions.fade(
          child: const NotificationCenterScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: SoteriaRoutes.previewGallery,
        builder: (context, state) => const PreviewGalleryScreen(),
        routes: [
          GoRoute(
            path: 'tokens',
            pageBuilder: (context, state) => SoteriaPageTransitions.fade(
              child: const TokensPreview(),
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: 'gradients',
            builder: (context, state) => const GalleryShell(
              title: 'Gradients',
              child: GradientsPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'lighting',
            builder: (context, state) => const GalleryShell(
              title: 'Lighting',
              child: LightingPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'surfaces',
            builder: (context, state) => const GalleryShell(
              title: 'Surfaces',
              child: SurfacesPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'buttons',
            builder: (context, state) => const ButtonsPreview(),
          ),
          GoRoute(
            path: 'cards',
            builder: (context, state) =>
                const GalleryShell(title: 'Cards', child: CardsPreviewPage()),
          ),
          GoRoute(
            path: 'inputs',
            builder: (context, state) =>
                const GalleryShell(title: 'Inputs', child: InputsPreviewPage()),
          ),
          GoRoute(
            path: 'feedback',
            builder: (context, state) => const GalleryShell(
              title: 'Feedback',
              child: FeedbackPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'typography',
            builder: (context, state) => const GalleryShell(
              title: 'Typography',
              child: TypographyPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'overlays',
            builder: (context, state) => const GalleryShell(
              title: 'Overlays',
              child: OverlaysPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'navigation',
            builder: (context, state) => const GalleryShell(
              title: 'Navigation',
              child: NavigationPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'animations',
            builder: (context, state) => const GalleryShell(
              title: 'Animations',
              child: AnimationsPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'startup',
            builder: (context, state) => const GalleryShell(
              title: 'Startup',
              child: StartupPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'nav-foundation',
            builder: (context, state) => const GalleryShell(
              title: 'Navigation',
              child: NavigationFoundationPage(),
            ),
          ),
          GoRoute(
            path: 'onboarding',
            builder: (context, state) => const GalleryShell(
              title: 'Onboarding',
              child: OnboardingPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'personalization',
            builder: (context, state) => const GalleryShell(
              title: 'Personalization',
              child: PersonalizationPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'auth-landing',
            builder: (context, state) => const GalleryShell(
              title: 'Auth Landing',
              child: AuthLandingPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'registration',
            builder: (context, state) => const GalleryShell(
              title: 'Registration',
              child: RegistrationPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'login',
            builder: (context, state) =>
                const GalleryShell(title: 'Login', child: LoginPreviewPage()),
          ),
          GoRoute(
            path: 'verification',
            builder: (context, state) => const GalleryShell(
              title: 'Verification',
              child: VerificationPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'identity',
            builder: (context, state) => const GalleryShell(
              title: 'Identity & Session',
              child: IdentityPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'diagnostics',
            builder: (context, state) => const GalleryShell(
              title: 'Diagnostics',
              child: DiagnosticsPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'player',
            builder: (context, state) => const GalleryShell(
              title: 'Player Profile',
              child: PlayerPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'personal-records',
            builder: (context, state) => PersonalRecordPreviews.gallery(),
          ),
          GoRoute(
            path: 'competitive-identity',
            builder: (context, state) => const GalleryShell(
              title: 'Competitive Identity',
              child: CompetitiveIdentityPreviews(),
            ),
          ),
          GoRoute(
            path: 'config-debug',
            builder: (context, state) => const GalleryShell(
              title: 'Config Debug',
              child: ConfigDebugScreen(),
            ),
          ),
          GoRoute(
            path: 'security-status',
            builder: (context, state) => const GalleryShell(
              title: 'Security Status',
              child: SecurityStatusScreen(),
            ),
          ),
          GoRoute(
            path: 'game-engine',
            builder: (context, state) => const GalleryShell(
              title: 'Gameplay Engine',
              child: GameEnginePreviewGallery(),
            ),
          ),
          GoRoute(
            path: 'question-pipeline',
            builder: (context, state) => const GalleryShell(
              title: 'Content Pipeline',
              child: QuestionPipelinePreviewPage(),
            ),
          ),
          GoRoute(
            path: 'question-presentation',
            builder: (context, state) => const GalleryShell(
              title: 'Question Presentation',
              child: PresentationPreviewGallery(),
            ),
          ),
          GoRoute(
            path: 'adaptive-timer',
            builder: (context, state) => const GalleryShell(
              title: 'Adaptive Timer',
              child: TimerPreviewGallery(),
            ),
          ),
          GoRoute(
            path: 'answer-engine',
            builder: (context, state) => const GalleryShell(
              title: 'Answer Engine',
              child: AnswerPreviewGallery(),
            ),
          ),
          GoRoute(
            path: 'progression',
            builder: (context, state) => const GalleryShell(
              title: 'Progression Engine',
              child: ProgressionPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'integrity',
            builder: (context, state) => const GalleryShell(
              title: 'Integrity & Anti-Cheat',
              child: IntegrityPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'lifelines',
            builder: (context, state) => const GalleryShell(
              title: 'Lifeline Framework',
              child: LifelinePreviewGallery(),
            ),
          ),
          GoRoute(
            path: 'quiz-engine',
            builder: (context, state) => const QuizEnginePreview(),
          ),
          GoRoute(
            path: 'quiz-history',
            builder: (context, state) => const QuizHistoryPreview(),
          ),
          GoRoute(
            path: 'lobby-redesign',
            builder: (context, state) => const LobbyRedesignPreview(),
          ),
          GoRoute(
            path: 'pro-lobby',
            builder: (context, state) => const ProLobbyPreviewPage(),
          ),
          GoRoute(
            path: 'results-redesign',
            builder: (context, state) => const ResultsRedesignPreview(),
          ),
          GoRoute(
            path: 'answer-review-preview',
            builder: (context, state) => const AnswerReviewPreview(),
          ),
          GoRoute(
            path: 'login-redesign',
            builder: (context, state) => const LoginRedesignPreview(),
          ),
          GoRoute(
            path: 'gameplay-redesign',
            builder: (context, state) => const GameplayRedesignPreview(),
          ),
          GoRoute(
            path: 'dashboard-redesign',
            builder: (context, state) => const DashboardRedesignPreview(),
          ),
          GoRoute(
            path: 'avatars',
            builder: (context, state) => const GalleryShell(
              title: 'Avatar Platform',
              child: AvatarPlatformPreviewPage(),
            ),
          ),
          GoRoute(
            path: 'tournaments',
            builder: (context, state) => const GalleryShell(
              title: 'Tournament Engine',
              child: TournamentPreviewGallery(),
            ),
          ),
          GoRoute(
            path: 'live-events',
            builder: (context, state) => GalleryShell(
              title: 'Live Events',
              child: LiveEventPreviews.discovery(),
            ),
          ),
        ],
      ),
    ],
  );
});

class _RiverpodRefreshListenable extends ChangeNotifier {
  late final ProviderSubscription _lifecycleSub;
  late final ProviderSubscription _sessionSub;

  _RiverpodRefreshListenable(Ref ref) {
    _lifecycleSub = ref.listen(
      appLifecycleProvider,
      (prev, next) => notifyListeners(),
    );
    _sessionSub = ref.listen(
      sessionProvider,
      (prev, next) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _lifecycleSub.close();
    _sessionSub.close();
    super.dispose();
  }
}
