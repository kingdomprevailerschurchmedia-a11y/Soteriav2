import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/personalization/utils/personalization_bridge.dart';

void main() {
  group('PersonalizationBridge', () {
    test('labelToCategoryId maps correctly', () {
      expect(PersonalizationBridge.labelToCategoryId('Science'), 'science');
      expect(PersonalizationBridge.labelToCategoryId('Current Affairs'), 'current_affairs');
      expect(PersonalizationBridge.labelToCategoryId('Unknown'), 'unknown');
    });

    test('categoryIdToLabel maps correctly', () {
      expect(PersonalizationBridge.categoryIdToLabel('science'), 'Science');
      expect(PersonalizationBridge.categoryIdToLabel('current_affairs'), 'Current Affairs');
      expect(PersonalizationBridge.categoryIdToLabel('unknown'), 'Unknown');
    });

    test('legacy categoryIdToLabel maps correctly', () {
      expect(PersonalizationBridge.categoryIdToLabel('current-affairs'), 'Current Affairs');
    });
  });
}
