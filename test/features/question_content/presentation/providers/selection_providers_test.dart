import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:soteria/features/question_content/domain/selection/question_selection_service.dart';
import 'package:soteria/features/question_content/domain/selection/selection_models.dart';
import 'package:soteria/features/question_content/presentation/providers/selection_providers.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';

@GenerateMocks([QuestionSelectionService])
import 'selection_providers_test.mocks.dart';

void main() {
  late MockQuestionSelectionService mockService;
  late StreamController<PlayerProfile?> profileController;

  setUp(() {
    mockService = MockQuestionSelectionService();
    profileController = StreamController<PlayerProfile?>.broadcast();
  });

  tearDown(() {
    profileController.close();
  });

  final mockProfile = PlayerProfile(
    uid: 'test-uid',
    displayName: 'Test',
    email: 'test@soteria.app',
    favoriteCategories: ['science', 'math'],
    createdAt: DateTime.now(),
    lastLogin: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  test('personalizedQuestionSelectionProvider should NOT inject interests by default if usePersonalization is false', () async {
    final container = ProviderContainer(
      overrides: [
        questionSelectionServiceProvider.overrideWithValue(mockService),
        currentPlayerStreamProvider.overrideWithValue(AsyncValue.data(mockProfile)),
      ],
    );

    final request = const QuestionSelectionRequest(
      categoryIds: [],
      usePersonalization: false,
    );

    when(mockService.selectQuestions(any)).thenAnswer((_) async => const QuestionSelectionResult(
      questions: [],
      status: SelectionStatus.success,
    ));

    await container.read(personalizedQuestionSelectionProvider(request).future);

    final capturedRequest = verify(mockService.selectQuestions(captureAny)).captured.first as QuestionSelectionRequest;
    expect(capturedRequest.categoryIds, isEmpty);
  });

  test('personalizedQuestionSelectionProvider should inject interests if usePersonalization is true', () async {
    final container = ProviderContainer(
      overrides: [
        questionSelectionServiceProvider.overrideWithValue(mockService),
        currentPlayerStreamProvider.overrideWithValue(AsyncValue.data(mockProfile)),
      ],
    );

    final request = const QuestionSelectionRequest(
      categoryIds: [],
      usePersonalization: true,
    );

    when(mockService.selectQuestions(any)).thenAnswer((_) async => const QuestionSelectionResult(
      questions: [],
      status: SelectionStatus.success,
    ));

    await container.read(personalizedQuestionSelectionProvider(request).future);

    final capturedRequest = verify(mockService.selectQuestions(captureAny)).captured.first as QuestionSelectionRequest;
    expect(capturedRequest.categoryIds, containsAll(['science', 'math']));
  });
}
