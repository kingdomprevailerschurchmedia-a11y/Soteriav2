import 'package:flutter/foundation.dart';

@immutable
class Category {
  final String id;
  final String name;
  final String description;
  final String icon;
  final int minLevel;
  final bool isPremium;
  final List<String> tags;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.minLevel = 1,
    this.isPremium = false,
    this.tags = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'icon': icon,
    'minLevel': minLevel,
    'isPremium': isPremium,
    'tags': tags,
  };

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    icon: json['icon'],
    minLevel: json['minLevel'] ?? 1,
    isPremium: json['isPremium'] ?? false,
    tags: (json['tags'] as List?)?.cast<String>() ?? [],
  );
}
