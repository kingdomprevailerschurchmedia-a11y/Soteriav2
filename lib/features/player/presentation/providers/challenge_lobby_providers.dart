import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../question_content/domain/entities/category.dart';
import '../../../quiz/domain/models/quiz_enums.dart';
import 'challenge_providers.dart';
import '../../../../features/dashboard/presentation/providers/practice_lobby_providers.dart';

class ChallengeLobbyState {
  final Category? category;
  final Difficulty difficulty;
  final int questionCount;
  final bool isLoading;
  final String? error;
  final List<Category> categories;

  const ChallengeLobbyState({
    this.category,
    this.difficulty = Difficulty.medium,
    this.questionCount = 10,
    this.isLoading = false,
    this.error,
    this.categories = const [],
  });

  ChallengeLobbyState copyWith({
    Category? category,
    Difficulty? difficulty,
    int? questionCount,
    bool? isLoading,
    String? error,
    List<Category>? categories,
  }) {
    return ChallengeLobbyState(
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      questionCount: questionCount ?? this.questionCount,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      categories: categories ?? this.categories,
    );
  }
}

class ChallengeLobbyNotifier extends FamilyNotifier<ChallengeLobbyState, String> {
  @override
  ChallengeLobbyState build(String arg) {
    _init();
    return const ChallengeLobbyState();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    try {
      final categories = await ref.read(categoryRepositoryProvider).getCategories();
      state = state.copyWith(
        isLoading: false,
        categories: categories,
        category: categories.isNotEmpty ? categories.first : null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updateCategory(Category category) {
    state = state.copyWith(category: category);
  }

  void updateDifficulty(Difficulty difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void updateQuestionCount(int count) {
    state = state.copyWith(questionCount: count);
  }

  Future<void> sendChallenge() async {
    if (state.category == null) return;

    final configuration = {
      'categoryId': state.category!.id,
      'categoryName': state.category!.name,
      'difficulty': state.difficulty.name,
      'questionCount': state.questionCount,
      'timeLimit': 30, // Default 30s per question
    };

    await ref.read(challengeControllerProvider.notifier).sendChallenge(
      challengedPlayerId: arg,
      configuration: configuration,
    );
  }
}

final challengeLobbyProvider =
    NotifierProvider.family<ChallengeLobbyNotifier, ChallengeLobbyState, String>(
      ChallengeLobbyNotifier.new,
    );
