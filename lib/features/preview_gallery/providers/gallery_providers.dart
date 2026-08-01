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
      title: 'Startup',
      description: 'Splash, Bootstrap, Recovery',
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
      title: 'Diagnostics',
      description: 'Logs, Device Info, Simulators',
      category: GalleryCategory.status,
      route: '/preview-gallery/diagnostics',
      icon: Icons.analytics_rounded,
    ),
  ];
});

// --- Search Provider ---
class GallerySearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String value) => state = value;
}

final gallerySearchQueryProvider = NotifierProvider<GallerySearchQueryNotifier, String>(GallerySearchQueryNotifier.new);

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

final gallerySettingsProvider = NotifierProvider<GallerySettingsNotifier, GallerySettings>(GallerySettingsNotifier.new);

// --- Favorites Provider ---
class GalleryFavoritesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    _load();
    return {};
  }

  static const _key = 'gallery_favorites';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (ref.mounted) {
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

final galleryFavoritesProvider = NotifierProvider<GalleryFavoritesNotifier, Set<String>>(GalleryFavoritesNotifier.new);

// --- Recents Provider ---
class GalleryRecentNotifier extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  void add(String route) {
    state = [route, ...state.where((r) => r != route)].take(5).toList();
  }
}

final galleryRecentProvider = NotifierProvider<GalleryRecentNotifier, List<String>>(GalleryRecentNotifier.new);
