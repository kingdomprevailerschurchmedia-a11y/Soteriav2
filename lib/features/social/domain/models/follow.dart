import 'package:freezed_annotation/freezed_annotation.dart';

part 'follow.freezed.dart';
part 'follow.g.dart';

@freezed
abstract class Follow with _$Follow {
  const factory Follow({
    required String id,
    required String followerId,
    required String followingId,
    required DateTime createdAt,
  }) = _Follow;

  factory Follow.fromJson(Map<String, dynamic> json) =>
      _$FollowFromJson(json);
}
