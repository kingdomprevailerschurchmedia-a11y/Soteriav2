import 'package:freezed_annotation/freezed_annotation.dart';

part 'competitive_title.freezed.dart';
part 'competitive_title.g.dart';

@freezed
abstract class CompetitiveTitle with _$CompetitiveTitle {
  const factory CompetitiveTitle({
    required String id,
    required String name,
    required String description,
    @Default(false) bool isSecret,
    @Default(0) int priority,
  }) = _CompetitiveTitle;

  factory CompetitiveTitle.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveTitleFromJson(json);
}
