import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/practice_result.dart';

part 'practice_result_state.freezed.dart';

@freezed
abstract class PracticeResultState with _$PracticeResultState {
  const factory PracticeResultState.initial() = _Initial;
  const factory PracticeResultState.calculating() = _Calculating;
  const factory PracticeResultState.success(PracticeResult result) = _Success;
  const factory PracticeResultState.error(String message) = _Error;
}
