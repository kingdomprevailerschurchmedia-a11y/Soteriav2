import 'package:freezed_annotation/freezed_annotation.dart';
import 'competitive_result.dart';
import 'rank_change.dart';
import '../../../quiz/domain/models/quiz_result.dart';

part 'competitive_match.freezed.dart';
part 'competitive_match.g.dart';

@freezed
abstract class CompetitiveMatch with _$CompetitiveMatch {
  const factory CompetitiveMatch({
    required CompetitiveResult result,
    RankChange? rankChange,
    QuizResult? quizResult,
  }) = _CompetitiveMatch;

  factory CompetitiveMatch.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveMatchFromJson(json);
}
