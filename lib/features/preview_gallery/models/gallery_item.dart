import 'package:flutter/material.dart';

enum GalleryCategory {
  designSystem('Design System', Icons.token_rounded),
  components('Components', Icons.widgets_rounded),
  screens('Screens', Icons.phone_iphone_rounded),
  overlays('Overlays', Icons.layers_rounded),
  animations('Animations', Icons.animation_rounded),
  tournaments('Tournaments', Icons.emoji_events_rounded),
  status('Status & Feedback', Icons.feedback_outlined),
  navigation('Navigation', Icons.menu_open_rounded),
  forms('Forms & Inputs', Icons.input_rounded),
  devTools('Developer Tools', Icons.build_circle_outlined);

  final String label;
  final IconData icon;
  const GalleryCategory(this.label, this.icon);
}

class GalleryItem {
  final String title;
  final String description;
  final GalleryCategory category;
  final String route;
  final List<String> tags;
  final IconData icon;

  const GalleryItem({
    required this.title,
    required this.description,
    required this.category,
    required this.route,
    this.tags = const [],
    required this.icon,
  });

  bool matchesSearch(String query) {
    final lowercaseQuery = query.toLowerCase();
    return title.toLowerCase().contains(lowercaseQuery) ||
        description.toLowerCase().contains(lowercaseQuery) ||
        category.label.toLowerCase().contains(lowercaseQuery) ||
        tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
  }
}
