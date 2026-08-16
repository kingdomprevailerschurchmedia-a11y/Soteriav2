import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/preview_gallery/models/gallery_item.dart';
import 'package:soteria/features/preview_gallery/models/gallery_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- Items Provider ---
final galleryItemsProvider = Provider<List<GalleryItem>>((ref) {
  return [
    const GalleryItem(
      title: 'Tokens',
      description: 'Colors, Typography, Spacing, Radius',
      category: GalleryCategory.designSystem,
      route: '/preview-gallery/tokens',
      icon: Icons.token_rounded,
      tags: ['color', 'font', 'size'],
    ),
    const GalleryItem(
      title: 'Gradients',
      description: 'Linear backgrounds & blurs',
      category: GalleryCategory.designSystem,
      route: '/preview-gallery/gradients',
      icon: Icons.gradient_rounded,
    ),
    const GalleryItem(
      title: 'Buttons',
      description: 'Primary, Ghost, Icon, Loading',
      category: GalleryCategory.components,
      route: '/preview-gallery/buttons',
      icon: Icons.smart_button_rounded,
    ),
    const GalleryItem(
      title: 'Cards',
      description: 'Standard, Glass, List Tiles',
      category: GalleryCategory.components,
      route: '/preview-gallery/cards',
      icon: Icons.web_asset_rounded,
    ),
    const GalleryItem(
      title: 'Inputs',
      description: 'Text fields, OTP, Password',
      category: GalleryCategory.forms,
      route: '/preview-gallery/inputs',
      icon: Icons.input_rounded,
    ),
    const GalleryItem(
      title: 'Feedback',
      description: 'Badges, Loaders, Empty states',
      category: GalleryCategory.status,
      route: '/preview-gallery/feedback',
      icon: Icons.feedback_outlined,
    ),
    const GalleryItem(
      title: 'Typography',
      description: 'Display, Headline, Gradient Text',
      category: GalleryCategory.designSystem,
      route: '/preview-gallery/typography',
      icon: Icons.text_fields_rounded,
    ),
    const GalleryItem(
      title: 'Overlays',
      description: 'Dialogs & Bottom Sheets',
      category: GalleryCategory.overlays,
      route: '/preview-gallery/overlays',
      icon: Icons.copy_all_rounded,
    ),
    const GalleryItem(
      title: 'Navigation',
      description: 'AppBars, Avatars, Chips',
      category: GalleryCategory.navigation,
      route: '/preview-gallery/navigation',
      icon: Icons.menu_open_rounded,
    ),
    const GalleryItem(
      title: 'Animations',
      description: 'Fade, Slide, Transitions',
      category: GalleryCategory.animations,
      route: '/preview-gallery/animations',
      icon: Icons.animation_rounded,
    ),
    const GalleryItem(
      title: 'Tournaments',
      description: 'Discovery, Details, Lobby & Actions',
      category: GalleryCategory.screens,
      route: '/preview-gallery/tournaments',
      icon: Icons.emoji_events_rounded,
    ),
    const GalleryItem(
      title: 'Startup',
      description: 'Bootstrap, Recovery, Lifecycle',
      category: GalleryCategory.screens,
      route: '/preview-gallery/startup',
      icon: Icons.rocket_launch_rounded,
    ),
    const GalleryItem(
      title: 'Nav Foundation',
      description: 'Routes, Transitions, Guards',
      category: GalleryCategory.navigation,
      route: '/preview-gallery/nav-foundation',
      icon: Icons.alt_route_rounded,
    ),
    const GalleryItem(
      title: 'Onboarding',
      description: 'Premium flow, Animations, States',
      category: GalleryCategory.screens,
      route: '/preview-gallery/onboarding',
      icon: Icons.auto_awesome_motion_rounded,
    ),
    const GalleryItem(
      title: 'Personalization',
      description: 'Multi-step preferences & setup',
      category: GalleryCategory.screens,
      route: '/preview-gallery/personalization',
      icon: Icons.person_search_rounded,
    ),
    const GalleryItem(
      title: 'Auth Landing',
      description: 'Identity gateway, Hero, Carousel',
      category: GalleryCategory.screens,
      route: '/preview-gallery/auth-landing',
      icon: Icons.login_rounded,
    ),
    const GalleryItem(
      title: 'Registration',
      description: 'Multi-step identity creation',
      category: GalleryCategory.screens,
      route: '/preview-gallery/registration',
      icon: Icons.app_registration_rounded,
    ),
    const GalleryItem(
      title: 'Login',
      description: 'Identity verification & Login',
      category: GalleryCategory.screens,
      route: '/preview-gallery/login-redesign',
      icon: Icons.lock_open_rounded,
    ),
    const GalleryItem(
      title: 'Verification',
      description: 'OTP, Countdown, Reusable Engine',
      category: GalleryCategory.screens,
      route: '/preview-gallery/verification',
      icon: Icons.verified_user_rounded,
    ),
    const GalleryItem(
      title: 'Identity & Session',
      description: 'Lifecycle, Roles, Auth states',
      category: GalleryCategory.screens,
      route: '/preview-gallery/identity',
      icon: Icons.fingerprint_rounded,
    ),
    const GalleryItem(
      title: 'Diagnostics',
      description: 'Logs, Device Info, Simulators',
      category: GalleryCategory.status,
      route: '/preview-gallery/diagnostics',
      icon: Icons.analytics_rounded,
    ),
    const GalleryItem(
      title: 'Player Profile',
      description: 'Firestore progression, Stats, Bootstrap',
      category: GalleryCategory.screens,
      route: '/preview-gallery/player',
      icon: Icons.badge_rounded,
    ),
    const GalleryItem(
      title: 'Notification Center',
      description: 'In-app history, FCM integration, Badges',
      category: GalleryCategory.screens,
      route: '/notifications',
      icon: Icons.notifications_active_rounded,
    ),
    const GalleryItem(
      title: 'Config Debug',
      description: 'Remote Config, Feature Flags, Game Params',
      category: GalleryCategory.status,
      route: '/preview-gallery/config-debug',
      icon: Icons.settings_remote_rounded,
    ),
    const GalleryItem(
      title: 'Security Status',
      description: 'App Check, Environment, Token State',
      category: GalleryCategory.status,
      route: '/preview-gallery/security-status',
      icon: Icons.admin_panel_settings_rounded,
    ),
    const GalleryItem(
      title: 'Home Dashboard',
      description: 'Premium landing, Stats, Hero card',
      category: GalleryCategory.screens,
      route: '/preview-gallery/dashboard-redesign',
      icon: Icons.dashboard_rounded,
    ),
    const GalleryItem(
      title: 'Practice Lobby',
      description: 'Configure your practice session',
      category: GalleryCategory.screens,
      route: '/preview-gallery/lobby-redesign',
      icon: Icons.school_rounded,
    ),
    const GalleryItem(
      title: 'Pro Lobby',
      description: 'Competitive competitive session initialization',
      category: GalleryCategory.screens,
      route: '/preview-gallery/pro-lobby',
      icon: Icons.security_rounded,
    ),
    const GalleryItem(
      title: 'Pro Results',
      description: 'Premium competitive results, Ratings (S-D) & Rewards',
      category: GalleryCategory.screens,
      route: '/preview-gallery/pro-results',
      icon: Icons.auto_awesome_rounded,
      tags: ['pro', 'results', 'rating', 'reward'],
    ),
    const GalleryItem(
      title: 'Session Results',
      description: 'Post-game rewards, XP & Analytics',
      category: GalleryCategory.screens,
      route: '/preview-gallery/results-redesign',
      icon: Icons.emoji_events_rounded,
    ),
    const GalleryItem(
      title: 'Answer Review',
      description: 'Review questions and explanations',
      category: GalleryCategory.screens,
      route: '/preview-gallery/answer-review-preview',
      icon: Icons.fact_check_rounded,
    ),
    const GalleryItem(
      title: 'Content Pipeline',
      description: 'Question sourcing, Cache, Offline',
      category: GalleryCategory.status,
      route: '/preview-gallery/question-pipeline',
      icon: Icons.dynamic_feed_rounded,
    ),
    const GalleryItem(
      title: 'Question Presentation',
      description: 'Universal renderer, Cards, Transitions',
      category: GalleryCategory.screens,
      route: '/preview-gallery/question-presentation',
      icon: Icons.auto_awesome_mosaic_rounded,
    ),
    const GalleryItem(
      title: 'Adaptive Timer',
      description: 'Dynamic policies, Warnings, Pulse',
      category: GalleryCategory.status,
      route: '/preview-gallery/adaptive-timer',
      icon: Icons.timer_outlined,
    ),
    const GalleryItem(
      title: 'Answer Engine',
      description: 'Validation, Decision pipeline, Results',
      category: GalleryCategory.status,
      route: '/preview-gallery/answer-engine',
      icon: Icons.fact_check_rounded,
    ),
    const GalleryItem(
      title: 'Progression Engine',
      description: 'Score, XP, Levels, Streaks, Rewards',
      category: GalleryCategory.status,
      route: '/preview-gallery/progression',
      icon: Icons.trending_up_rounded,
    ),
    const GalleryItem(
      title: 'Integrity & Anti-Cheat',
      description: 'Risk assessment, Lifecycle monitoring, Signals',
      category: GalleryCategory.status,
      route: '/preview-gallery/integrity',
      icon: Icons.security_rounded,
    ),
    const GalleryItem(
      title: 'Lifeline Framework',
      description: '50/50, Pause Timer, Audience Simulation',
      category: GalleryCategory.status,
      route: '/preview-gallery/lifelines',
      icon: Icons.assistant_direction_rounded,
    ),
    const GalleryItem(
      title: 'Quiz Engine',
      description: 'Foundation, Models, Controllers, States',
      category: GalleryCategory.designSystem,
      route: '/preview-gallery/quiz-engine',
      icon: Icons.settings_input_component_rounded,
    ),
    const GalleryItem(
      title: 'Quiz History',
      description: 'Personal history, Performance, Trends',
      category: GalleryCategory.screens,
      route: '/preview-gallery/quiz-history',
      icon: Icons.history_rounded,
    ),
    const GalleryItem(
      title: 'Avatar Platform',
      description: 'Scholar avatars, metallic frames & ranks',
      category: GalleryCategory.designSystem,
      route: '/preview-gallery/avatars',
      icon: Icons.face_rounded,
      tags: ['avatar', 'scholar', 'profile'],
    ),
    const GalleryItem(
      title: 'Personal Records',
      description: 'Career bests, Season records, Match evidence',
      category: GalleryCategory.screens,
      route: '/preview-gallery/personal-records',
      icon: Icons.emoji_events_rounded,
      tags: ['record', 'best', 'personal'],
    ),
    const GalleryItem(
      title: 'Competitive Identity',
      description: 'Titles, badges, showcases & prestige',
      category: GalleryCategory.screens,
      route: '/preview-gallery/competitive-identity',
      icon: Icons.assignment_ind_rounded,
      tags: ['identity', 'title', 'badge', 'showcase'],
    ),
    const GalleryItem(
      title: 'Live Events',
      description: 'Discovery, Details & Countdown',
      category: GalleryCategory.screens,
      route: '/preview-gallery/live-events',
      icon: Icons.bolt_rounded,
      tags: ['live', 'event', 'countdown'],
    ),
    const GalleryItem(
      title: 'Social & Connections',
      description: 'Friends list, Requests, Relationship status',
      category: GalleryCategory.screens,
      route: '/preview-gallery/social',
      icon: Icons.people_rounded,
      tags: ['friend', 'social', 'request'],
    ),
    const GalleryItem(
      title: 'Profile Info',
      description: 'Account identity and personal details',
      category: GalleryCategory.screens,
      route: '/preview-gallery/profile-info',
      icon: Icons.person_outline_rounded,
      tags: ['profile', 'identity', 'account', 'edit'],
    ),
  ];
});

// --- Search Provider ---
class GallerySearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String value) => state = value;
}

final gallerySearchQueryProvider =
    NotifierProvider<GallerySearchQueryNotifier, String>(
      GallerySearchQueryNotifier.new,
    );

final filteredGalleryItemsProvider = Provider<List<GalleryItem>>((ref) {
  final query = ref.watch(gallerySearchQueryProvider);
  final items = ref.watch(galleryItemsProvider);
  if (query.isEmpty) return items;
  return items.where((item) => item.matchesSearch(query)).toList();
});

// --- Settings Provider ---
class GallerySettingsNotifier extends Notifier<GallerySettings> {
  @override
  GallerySettings build() => const GallerySettings();

  void update(GallerySettings Function(GallerySettings) updater) {
    state = updater(state);
  }

  void reset() => state = const GallerySettings();
}

final gallerySettingsProvider =
    NotifierProvider<GallerySettingsNotifier, GallerySettings>(
      GallerySettingsNotifier.new,
    );

// --- Favorites Provider ---
class GalleryFavoritesNotifier extends Notifier<Set<String>> {
  bool _mounted = true;

  @override
  Set<String> build() {
    _mounted = true;
    ref.onDispose(() => _mounted = false);
    _load();
    return {};
  }

  static const _key = 'gallery_favorites';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (_mounted) {
      state = prefs.getStringList(_key)?.toSet() ?? {};
    }
  }

  Future<void> toggle(String route) async {
    if (state.contains(route)) {
      state = {...state}..remove(route);
    } else {
      state = {...state, route};
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, state.toList());
  }
}

final galleryFavoritesProvider =
    NotifierProvider<GalleryFavoritesNotifier, Set<String>>(
      GalleryFavoritesNotifier.new,
    );

// --- Recents Provider ---
class GalleryRecentNotifier extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  void add(String route) {
    state = [route, ...state.where((r) => r != route)].take(5).toList();
  }
}

final galleryRecentProvider =
    NotifierProvider<GalleryRecentNotifier, List<String>>(
      GalleryRecentNotifier.new,
    );
