import 'package:freezed_annotation/freezed_annotation.dart';

part 'friendship.freezed.dart';
part 'friendship.g.dart';

@freezed
abstract class Friendship with _$Friendship {
  const factory Friendship({
    required String id,
    required List<String> userIds,
    required DateTime createdAt,
    @Default({}) Map<String, dynamic> metadata,
  }) = _Friendship;

  factory Friendship.fromJson(Map<String, dynamic> json) =>
      _$FriendshipFromJson(json);
}
