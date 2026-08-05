import 'package:flutter/material.dart';
import 'preview_category.dart';

typedef PreviewBuilder = Widget Function(BuildContext context);

class PreviewItem {
  final String id;
  final String title;
  final String description;
  final PreviewCategory category;
  final PreviewBuilder builder;
  final List<String> tags;
  final bool isExperimental;

  const PreviewItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.builder,
    this.tags = const [],
    this.isExperimental = false,
  });
}
