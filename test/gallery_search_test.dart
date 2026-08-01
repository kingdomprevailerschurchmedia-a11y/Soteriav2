import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/preview_gallery/models/gallery_item.dart';
import 'package:flutter/material.dart';

void main() {
  group('GalleryItem Search Tests', () {
    const item = GalleryItem(
      title: 'Primary Button',
      description: 'Main action button',
      category: GalleryCategory.components,
      route: '/test',
      icon: Icons.add,
      tags: ['click', 'submit'],
    );

    test('matches title correctly', () {
      expect(item.matchesSearch('Primary'), isTrue);
      expect(item.matchesSearch('button'), isTrue);
    });

    test('matches description correctly', () {
      expect(item.matchesSearch('action'), isTrue);
    });

    test('matches tags correctly', () {
      expect(item.matchesSearch('submit'), isTrue);
    });

    test('is case insensitive', () {
      expect(item.matchesSearch('PRIMARY'), isTrue);
    });

    test('returns false for no match', () {
      expect(item.matchesSearch('dialog'), isFalse);
    });
  });
}
