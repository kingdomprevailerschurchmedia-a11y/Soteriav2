import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/social/domain/models/friend_request.dart';
import 'package:soteria/features/social/domain/models/friendship.dart';

void main() {
  group('Social Domain Models', () {
    test('FriendRequest json serialization', () {
      final now = DateTime.now();
      final request = FriendRequest(
        id: '1',
        senderId: 'userA',
        receiverId: 'userB',
        status: FriendRequestStatus.pending,
        createdAt: now,
      );

      final json = request.toJson();
      expect(json['id'], '1');
      expect(json['senderId'], 'userA');
      expect(json['status'], 'pending');

      final fromJson = FriendRequest.fromJson(json);
      expect(fromJson, request);
    });

    test('Friendship json serialization', () {
      final now = DateTime.now();
      final friendship = Friendship(
        id: 'A_B',
        userIds: ['userA', 'userB'],
        createdAt: now,
      );

      final json = friendship.toJson();
      expect(json['id'], 'A_B');
      expect(json['userIds'], containsAll(['userA', 'userB']));

      final fromJson = Friendship.fromJson(json);
      expect(fromJson, friendship);
    });
  });
}
