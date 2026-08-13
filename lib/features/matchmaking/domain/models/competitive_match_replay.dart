import 'package:freezed_annotation/freezed_annotation.dart';
import 'competitive_match_result.dart';
import '../../../question_content/domain/entities/question.dart';

part 'competitive_match_replay.freezed.dart';

@freezed
class CompetitiveMatchReplay with _$CompetitiveMatchReplay {
  const factory CompetitiveMatchReplay({
    required CompetitiveMatchResult result,
    required List<Question> questions,
  }) = _CompetitiveMatchReplay;
}
