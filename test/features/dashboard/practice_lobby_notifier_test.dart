import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/dashboard/presentation/providers/practice_lobby_providers.dart';
import 'package:soteria/features/question_content/domain/repositories/category_repository.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/practice_repository.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/player/presentation/providers/progression_providers.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/question_content/domain/entities/category.dart';
import 'package:soteria/features/question_content/presentation/providers/category_providers.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}
class MockPracticeRepository extends Mock implements PracticeRepository {}

void main() {
  late MockCategoryRepository mockCategoryRepo;
  late MockPracticeRepository mockPracticeRepo;
  late ProviderContainer container;

  final mockPlayer = PlayerProfile(
    uid: 'uid123',
    displayName: 'Test Player',
    email: 'test@soteria.app',
    level: 5, // Below level 10 for Expert
    createdAt: DateTime.now(),
    lastLogin: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final mockCategory = Category(
    id: 'cat1',
    name: 'Security',
    description: 'Security basics',
    slug: 'security',
    icon: 'security',
  );

  setUp(() {
    mockCategoryRepo = MockCategoryRepository();
    mockPracticeRepo = MockPracticeRepository();

    when(() => mockCategoryRepo.getCategories()).thenAnswer((_) async => [mockCategory]);
  });

  ProviderContainer createContainer({int level = 5}) {
    return ProviderContainer(
      overrides: [
        categoryRepositoryProvider.overrideWithValue(mockCategoryRepo),
        practiceRepositoryProvider.overrideWithValue(mockPracticeRepo),
        currentPlayerProvider.overrideWithValue(mockPlayer),
        currentCompetitiveLevelProvider.overrideWithValue(level),
      ],
    );
  }

  test('validation error is cleared when switching difficulty', () async {
    container = createContainer(level: 5);
    
    // Trigger build
    container.read(practiceLobbyProvider);
    
    // Wait for init microtask
    await Future.delayed(Duration.zero);
    
    final notifier = container.read(practiceLobbyProvider.notifier);

    // 1. Set difficulty to Expert (level 10 required, player is level 5)
    notifier.updateDifficulty(Difficulty.expert);
    var state = container.read(practiceLobbyProvider);
    expect(state.validationError, contains('Level 10 required for Expert'));

    // 2. Set difficulty back to Easy
    notifier.updateDifficulty(Difficulty.easy);
    state = container.read(practiceLobbyProvider);
    expect(state.validationError, isNull);
  });

  test('validation error is cleared when toggling useInterests', () async {
    container = createContainer();
    
    // Trigger build
    container.read(practiceLobbyProvider);
    
    // Wait for init
    await Future.delayed(Duration.zero);
    
    final notifier = container.read(practiceLobbyProvider.notifier);

    // 1. Disable interests and clear categories
    notifier.setUseInterests(false);
    
    // Initial state has 'cat1' selected from _init
    notifier.toggleCategory('cat1'); // Deselect 'cat1'
    
    var state = container.read(practiceLobbyProvider);
    expect(state.config.categoryIds, isEmpty);
    expect(state.validationError, contains('Please select at least one category'));

    // 2. Enable interests again
    notifier.setUseInterests(true);
    state = container.read(practiceLobbyProvider);
    expect(state.validationError, isNull);
  });
}
