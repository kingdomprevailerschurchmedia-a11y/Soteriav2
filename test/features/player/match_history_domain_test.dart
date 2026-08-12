import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:soteria/features/player/domain/models/competitive_match.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import 'package:soteria/features/player/domain/repositories/competitive_result_repository.dart';
import 'package:soteria/features/player/domain/repositories/rank_history_repository.dart';
import 'package:soteria/features/quiz/domain/repositories/quiz_history_repository.dart';
import 'package:soteria/features/player/data/repositories/firebase_match_history_repository.dart';

@GenerateMocks([
  CompetitiveResultRepository,
  RankHistoryRepository,
  QuizHistoryRepository,
])
import 'match_history_domain_test.mocks.dart';

void main() {
  late MockCompetitiveResultRepository mockResultRepo;
  late MockRankHistoryRepository mockRankRepo;
  late MockQuizHistoryRepository mockQuizRepo;
  late FirebaseMatchHistoryRepository repository;

  setUp(() {
    mockResultRepo = MockCompetitiveResultRepository();
    mockRankRepo = MockRankHistoryRepository();
    mockQuizRepo = MockQuizHistoryRepository();
    repository = FirebaseMatchHistoryRepository(
      resultRepository: mockResultRepo,
      rankRepository: mockRankRepo,
      quizRepository: mockQuizRepo,
    );
  });

  group('FirebaseMatchHistoryRepository', () {
    const userId = 'user_123';

    test(
      'getMatchHistory should orchestrate multiple repositories correctly',
      () async {
        // Arrange
        final result = CompetitiveResult(
          resultId: 'res_1',
          userId: userId,
          seasonId: 's1',
          outcome: CompetitiveOutcome.win,
          mode: 'tournament',
          score: 1000,
          completedAt: DateTime.now(),
        );

        when(
          mockResultRepo.getResults(any, limit: anyNamed('limit')),
        ).thenAnswer((_) async => [result]);
        when(
          mockRankRepo.getRankHistory(any, limit: anyNamed('limit')),
        ).thenAnswer((_) async => []);
        when(mockQuizRepo.getResult(any)).thenAnswer((_) async => null);

        // Act
        final matches = await repository.getMatchHistory(userId);

        // Assert
        expect(matches.length, 1);
        expect(matches.first.result.resultId, 'res_1');
        verify(mockResultRepo.getResults(userId, limit: 20)).called(1);
      },
    );

    test('getMatchHistory should handle empty results', () async {
      // Arrange
      when(
        mockResultRepo.getResults(any, limit: anyNamed('limit')),
      ).thenAnswer((_) async => []);

      // Act
      final matches = await repository.getMatchHistory(userId);

      // Assert
      expect(matches, isEmpty);
      verifyNever(mockRankRepo.getRankHistory(any, limit: anyNamed('limit')));
    });
  });
}
