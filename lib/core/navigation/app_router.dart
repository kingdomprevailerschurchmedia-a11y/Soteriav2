import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/navigation/transitions/soteria_page_transitions.dart';
import 'package:soteria/features/splash/splash_screen.dart';
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
import 'package:soteria/features/preview_gallery/pages/diagnostics_preview_page.dart';
import 'package:soteria/features/error_routing/unknown_route_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: SoteriaRoutes.splash,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => UnknownRouteScreen(location: state.uri.toString()),
    routes: [
      // Foundation
      GoRoute(
        path: SoteriaRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // Developer Gallery
      GoRoute(
        path: SoteriaRoutes.previewGallery,
        builder: (context, state) => const PreviewGalleryScreen(),
        routes: [
          GoRoute(
            path: 'tokens',
            pageBuilder: (context, state) => SoteriaPageTransitions.fade(
              child: const GalleryShell(title: 'Tokens', child: TokensPreviewPage()),
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: 'gradients',
            builder: (context, state) => const GalleryShell(title: 'Gradients', child: GradientsPreviewPage()),
          ),
          GoRoute(
            path: 'lighting',
            builder: (context, state) => const GalleryShell(title: 'Lighting', child: LightingPreviewPage()),
          ),
          GoRoute(
            path: 'surfaces',
            builder: (context, state) => const GalleryShell(title: 'Surfaces', child: SurfacesPreviewPage()),
          ),
          GoRoute(
            path: 'buttons',
            builder: (context, state) => const GalleryShell(title: 'Buttons', child: ButtonsPreviewPage()),
          ),
          GoRoute(
            path: 'cards',
            builder: (context, state) => const GalleryShell(title: 'Cards', child: CardsPreviewPage()),
          ),
          GoRoute(
            path: 'inputs',
            builder: (context, state) => const GalleryShell(title: 'Inputs', child: InputsPreviewPage()),
          ),
          GoRoute(
            path: 'feedback',
            builder: (context, state) => const GalleryShell(title: 'Feedback', child: FeedbackPreviewPage()),
          ),
          GoRoute(
            path: 'typography',
            builder: (context, state) => const GalleryShell(title: 'Typography', child: TypographyPreviewPage()),
          ),
          GoRoute(
            path: 'overlays',
            builder: (context, state) => const GalleryShell(title: 'Overlays', child: OverlaysPreviewPage()),
          ),
          GoRoute(
            path: 'navigation',
            builder: (context, state) => const GalleryShell(title: 'Navigation', child: NavigationPreviewPage()),
          ),
          GoRoute(
            path: 'animations',
            builder: (context, state) => const GalleryShell(title: 'Animations', child: AnimationsPreviewPage()),
          ),
          GoRoute(
            path: 'startup',
            builder: (context, state) => const GalleryShell(title: 'Startup', child: StartupPreviewPage()),
          ),
          GoRoute(
            path: 'nav-foundation',
            builder: (context, state) => const GalleryShell(title: 'Navigation', child: NavigationFoundationPage()),
          ),
          GoRoute(
            path: 'diagnostics',
            builder: (context, state) => const GalleryShell(title: 'Diagnostics', child: DiagnosticsPreviewPage()),
          ),
        ],
      ),
    ],
  );
}
