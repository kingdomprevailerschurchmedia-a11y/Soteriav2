import 'package:flutter/foundation.dart';

enum AvatarCategory { scholar, competitor, premium, seasonal, special }

enum AvatarRarity { common, rare, epic, legendary }

@immutable
class Avatar {
  final String id;
  final String name;
  final String displayName;
  final String assetPath;
  final AvatarCategory category;
  final AvatarRarity rarity;
  final bool isDefault;
  final bool isUnlocked;

  const Avatar({
    required this.id,
    required this.name,
    required this.displayName,
    required this.assetPath,
    required this.category,
    required this.rarity,
    this.isDefault = false,
    this.isUnlocked = false,
  });

  Avatar copyWith({
    String? id,
    String? name,
    String? displayName,
    String? assetPath,
    AvatarCategory? category,
    AvatarRarity? rarity,
    bool? isDefault,
    bool? isUnlocked,
  }) {
    return Avatar(
      id: id ?? this.id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      assetPath: assetPath ?? this.assetPath,
      category: category ?? this.category,
      rarity: rarity ?? this.rarity,
      isDefault: isDefault ?? this.isDefault,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}
