import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/models/practice_session_config.dart';
import 'package:soteria/features/gameplay_engine/services/session_validator.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/question_content/domain/entities/category.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

void main() {
  late SessionValidator validator;

  setUp(() {
    validator = SessionValidator();
  });

  final mockCategory = Category(
    id: 'cat_1',
    name: 'Security',
    description: 'Desc',
    slug: 'security',
    icon: 'security',
    minLevel: 5,
  );

  final mockPlayer = PlayerProfile(
    uid: 'u1',
    displayName: 'Player',
    email: 'e',
    level: 1,
    createdAt: DateTime.now(),
    lastLogin: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  test('should fail if no category selected and not using interests', () {
    final config = PracticeSessionConfig(category: null, useInterests: false);
    final error = validator.validate(config, mockPlayer);
    expect(error, 'Please select at least one category');
  });

  test('should fail if player level too low for category', () {
    final config = PracticeSessionConfig(category: mockCategory, useInterests: false);
    final error = validator.validate(config, mockPlayer);
    expect(error, contains('Level 5 required'));
  });

  test('should fail if expert difficulty selected by low level player', () {
    final player = mockPlayer.copyWith(
      level: 5,
    ); // Enough for category but not for expert
    final config = PracticeSessionConfig(
      category: mockCategory,
      difficulty: Difficulty.expert,
      useInterests: false,
    );
    final error = validator.validate(config, player);
    expect(error, contains('Level 10 required for Expert'));
  });

  test('should pass for valid configuration', () {
    final player = mockPlayer.copyWith(level: 10);
    final config = PracticeSessionConfig(
      category: mockCategory,
      difficulty: Difficulty.medium,
      useInterests: false,
    );
    final error = validator.validate(config, player);
    expect(error, isNull);
  });
}
