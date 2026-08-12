import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/core/avatar/data/avatar_catalog.dart';
import 'package:soteria/core/avatar/domain/avatar.dart';

void main() {
  group('AvatarCatalog', () {
    late AvatarCatalog catalog;

    setUp(() {
      catalog = AvatarCatalog();
    });

    test('should contain all expected avatars', () {
      final all = catalog.all;
      expect(all.length, 9);
      expect(all.any((a) => a.id == 'socrates'), true);
      expect(all.any((a) => a.id == 'athena'), true);
    });

    test('getById should return correct avatar', () {
      final avatar = catalog.getById('athena');
      expect(avatar, isNotNull);
      expect(avatar?.displayName, 'Athena');
      expect(avatar?.category, AvatarCategory.scholar);
    });

    test('getById should return null for invalid id', () {
      final avatar = catalog.getById('non_existent');
      expect(avatar, isNull);
    });

    test('defaultAvatar should return socrates', () {
      final avatar = catalog.defaultAvatar;
      expect(avatar.id, 'socrates');
      expect(avatar.isDefault, true);
    });
  });
}
