import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_request.freezed.dart';
part 'friend_request.g.dart';

enum FriendRequestStatus {
  pending,
  accepted,
  declined,
  cancelled,
}

@freezed
abstract class FriendRequest with _$FriendRequest {
  const factory FriendRequest({
    required String id,
    required String senderId,
    required String receiverId,
    required FriendRequestStatus status,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _FriendRequest;

  factory FriendRequest.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestFromJson(json);
}
