import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/navigation/transitions/soteria_page_transitions.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'package:soteria/features/splash/splash_screen.dart';
import 'package:soteria/features/onboarding/screens/onboarding_screen.dart';
import 'package:soteria/features/personalization/screens/personalization_screen.dart';
import 'package:soteria/features/auth/screens/auth_landing_screen.dart';
import 'package:soteria/features/auth/screens/registration_screen.dart';
import 'package:soteria/features/auth/screens/login_screen.dart';
import 'package:soteria/features/auth/screens/verification_orchestrator.dart';
import 'package:soteria/features/auth/models/verification_type.dart';
import 'package:soteria/features/preview_gallery/preview_gallery_screen.dart';
import 'package:soteria/features/preview_gallery/widgets/gallery_shell.dart';
import 'package:soteria/features/preview_gallery/pages/tokens_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/gradients_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/lighting_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/surfaces_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/buttons_preview_page.dart';
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
import 'package:soteria/features/preview_gallery/pages/auth_landing_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/registration_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/login_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/verification_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/identity_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/diagnostics_preview_page.dart';
import 'package:soteria/features/gameplay_engine/pages/game_preview_gallery.dart';
import 'package:soteria/features/preview_gallery/pages/question_pipeline_preview_page.dart';
import 'package:soteria/features/question_presentation/pages/presentation_preview_gallery.dart';
import 'package:soteria/features/gameplay_engine/timer/pages/timer_preview_gallery.dart';
import 'package:soteria/features/gameplay_engine/answer/pages/answer_preview_gallery.dart';
import 'package:soteria/features/gameplay_engine/lifelines/pages/lifeline_preview_gallery.dart';
import 'package:soteria/features/preview_gallery/pages/progression_preview_page.dart';
import 'package:soteria/features/preview_gallery/pages/integrity_preview_page.dart';
import 'package:soteria/features/error_routing/unknown_route_screen.dart';

import 'package:soteria/core/identity/models/user_session.dart';
import 'package:soteria/core/firebase/config/providers/configuration_providers.dart';
import 'package:soteria/features/auth/services/auth_coordinator.dart';
import 'package:soteria/features/preview_gallery/pages/player_preview_page.dart';
import 'package:soteria/features/player/screens/security_status_screen.dart';
import 'package:soteria/features/player/screens/config_debug_screen.dart';
import 'package:soteria/features/notifications/screens/notification_center_screen.dart';
import 'package:soteria/features/notifications/providers/notification_providers.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:soteria/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:soteria/features/dashboard/presentation/screens/home_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = _RiverpodRefreshListenable(ref);
  ref.onDispose(listenable.dispose);

  // Start Coordinators
  ref.watch(authCoordinatorProvider);
  ref.read(notificationCoordinatorProvider).initialize();
  ref.read(configurationCoordinatorProvider).initialize();

  return GoRouter(
    initialLocation: SoteriaRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: listenable,
    observers: [
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
    redirect: (context, state) {
      final lifecycle = ref.read(appLifecycleProvider);
      final session = ref.read(sessionProvider);
      final location = state.uri.toString();

      LoggerService.t(
        'Router Redirect Check: loc=$location, life=$lifecycle, auth=${session.status}',
        feature: 'Navigation',
      );

      if (lifecycle == AppStartupState.loading) {
        return location == SoteriaRoutes.splash ? null : SoteriaRoutes.splash;
      }

      if (lifecycle == AppStartupState.onboarding &&
          location != SoteriaRoutes.onboarding) {
        return SoteriaRoutes.onboarding;
      }

      if (lifecycle == AppStartupState.personalization &&
          location != SoteriaRoutes.personalization &&
          !location.startsWith(SoteriaRoutes.auth)) {
        return SoteriaRoutes.personalization;
      }

      if (lifecycle == AppStartupState.auth &&
          !location.startsWith(SoteriaRoutes.auth)) {
        // Allow unverified users to reach the verification screen
        if (session.uid != null && session.status == SessionStatus.guest) {
          return '${SoteriaRoutes.auth}/verify/emailVerification';
        }
        return SoteriaRoutes.auth;
      }

      // Auth Guards for Protected Routes
      if (location.startsWith(SoteriaRoutes.main) ||
          location == SoteriaRoutes.auth ||
          location == '${SoteriaRoutes.auth}/login') {
        if (!session.isAuthenticated) {
          // Check if it's just a verification pending state
          if (session.uid != null && session.status == SessionStatus.guest) {
            return '${SoteriaRoutes.auth}/verify/emailVerification';
          }
          if (location.startsWith(SoteriaRoutes.main)) return SoteriaRoutes.auth;
        } else {
          // Already authenticated, shouldn't be on auth pages
          if (location.startsWith(SoteriaRoutes.auth)) return SoteriaRoutes.main;
        }
      }

      // Default Ready state
      if (lifecycle == AppStartupState.ready) {
        if (location == SoteriaRoutes.splash ||
            location.startsWith(SoteriaRoutes.auth)) {
          if (session.isAuthenticated) {
            return SoteriaRoutes.main;
          }
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
      ShellRoute(
        builder: (context, state, child) => HomeShell(child: child),
        routes: [
          GoRoute(
            path: SoteriaRoutes.main,
            pageBuilder: (context, state) => SoteriaPageTransitions.fade(
              child: const DashboardScreen(),
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: SoteriaRoutes.leaderboard,
            builder: (context, state) =>
                const Center(child: Text('Leaderboard')),
          ),
          GoRoute(
            path: SoteriaRoutes.wallet,
            builder: (context, state) => const Center(child: Text('Rewards')),
          ),
          GoRoute(
            path: SoteriaRoutes.profile,
            builder: (context, state) => const Center(child: Text('Profile')),
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
        path: SoteriaRoutes.auth,
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
        path: SoteriaRoutes.previewGallery,
        builder: (context, state) => const PreviewGalleryScreen(),
        routes: [
          GoRoute(
            path: 'tokens',
            pageBuilder: (context, state) => SoteriaPageTransitions.fade(
              child: const GalleryShell(
                title: 'Tokens',
                child: TokensPreviewPage(),
              ),
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
            builder: (context, state) => const GalleryShell(
              title: 'Buttons',
              child: ButtonsPreviewPage(),
            ),
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
