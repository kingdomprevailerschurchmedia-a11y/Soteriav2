import '../domain/avatar.dart';

class AvatarCatalog {
  static const String _basePath = 'assets/avatars';

  static final List<Avatar> _avatars = [
    const Avatar(
      id: 'socrates',
      name: 'socrates',
      displayName: 'Socrates',
      assetPath: '$_basePath/socrates.png',
      category: AvatarCategory.scholar,
      rarity: AvatarRarity.common,
      isDefault: true,
      isUnlocked: true,
    ),
    const Avatar(
      id: 'lyra',
      name: 'lyra',
      displayName: 'Lyra',
      assetPath: '$_basePath/lyra.png',
      category: AvatarCategory.scholar,
      rarity: AvatarRarity.common,
      isUnlocked: true,
    ),
    const Avatar(
      id: 'elias',
      name: 'elias',
      displayName: 'Elias',
      assetPath: '$_basePath/elias.png',
      category: AvatarCategory.scholar,
      rarity: AvatarRarity.common,
      isUnlocked: true,
    ),
    const Avatar(
      id: 'isaac',
      name: 'isaac',
      displayName: 'Isaac',
      assetPath: '$_basePath/isaac.png',
      category: AvatarCategory.scholar,
      rarity: AvatarRarity.common,
      isUnlocked: true,
    ),
    const Avatar(
      id: 'athena',
      name: 'athena',
      displayName: 'Athena',
      assetPath: '$_basePath/athena.png',
      category: AvatarCategory.scholar,
      rarity: AvatarRarity.rare,
      isUnlocked: true,
    ),
    const Avatar(
      id: 'aurelia',
      name: 'aurelia',
      displayName: 'Aurelia',
      assetPath: '$_basePath/aurelia.png',
      category: AvatarCategory.scholar,
      rarity: AvatarRarity.rare,
      isUnlocked: true,
    ),
    const Avatar(
      id: 'augustus',
      name: 'augustus',
      displayName: 'Augustus',
      assetPath: '$_basePath/augustus.png',
      category: AvatarCategory.scholar,
      rarity: AvatarRarity.epic,
      isUnlocked: true,
    ),
    const Avatar(
      id: 'leonidas',
      name: 'leonidas',
      displayName: 'Leonidas',
      assetPath: '$_basePath/leonidas.png',
      category: AvatarCategory.competitor,
      rarity: AvatarRarity.epic,
      isUnlocked: true,
    ),
    const Avatar(
      id: 'seraphine',
      name: 'seraphine',
      displayName: 'Seraphine',
      assetPath: '$_basePath/seraphine.png',
      category: AvatarCategory.premium,
      rarity: AvatarRarity.legendary,
      isUnlocked: false,
    ),
  ];

  List<Avatar> get all => _avatars;

  Avatar? getById(String id) {
    try {
      return _avatars.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  Avatar get defaultAvatar => _avatars.firstWhere((a) => a.isDefault);
}
