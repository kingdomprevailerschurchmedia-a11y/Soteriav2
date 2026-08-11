import 'package:freezed_annotation/freezed_annotation.dart';

part 'competitive_result.freezed.dart';
part 'competitive_result.g.dart';

enum CompetitiveOutcome { win, loss, draw, placement }

@freezed
abstract class CompetitiveResult with _$CompetitiveResult {
  const factory CompetitiveResult({
    required String resultId,
    required String userId,
    required String seasonId,
    required CompetitiveOutcome outcome,
    required String mode,
    required int score,
    required DateTime completedAt,
    String? opponentId,
    Map<String, dynamic>? performanceModifiers,
    @Default(1) int version,
  }) = _CompetitiveResult;

  factory CompetitiveResult.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveResultFromJson(json);
}
