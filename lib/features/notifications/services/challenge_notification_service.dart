import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/player/domain/models/competitive_challenge.dart';
import 'package:soteria/features/player/presentation/providers/challenge_providers.dart';
import 'package:soteria/features/notifications/domain/models/app_notification.dart';
import 'package:soteria/features/notifications/domain/repositories/notification_repository.dart';
import 'package:uuid/uuid.dart';

class ChallengeNotificationService {
  final Ref _ref;
  final NotificationRepository _repository;

  ChallengeNotificationService(this._ref, this._repository);

  void start() {
    _ref.listen(incomingChallengesProvider, (prev, next) {
      final current = next.value ?? [];
      final previous = prev?.value ?? [];

      if (current.length > previous.length) {
        final newChallenge = current.first;
        _notifyNewChallenge(newChallenge);
      }
    });

    _ref.listen(outgoingChallengesProvider, (prev, next) {
      final current = next.value ?? [];
      final previous = prev?.value ?? [];

      for (final challenge in current) {
        final old = previous.firstWhere((c) => c.challengeId == challenge.challengeId, orElse: () => challenge);
        if (challenge.status != old.status) {
          if (challenge.status == ChallengeStatus.accepted) {
            _notifyChallengeAccepted(challenge);
          } else if (challenge.status == ChallengeStatus.declined) {
            _notifyChallengeDeclined(challenge);
          }
        }
      }
    });
  }

  Future<void> _notifyNewChallenge(CompetitiveChallenge challenge) async {
    await _repository.saveNotification(
      AppNotification(
        id: const Uuid().v4(),
        userId: challenge.challengedPlayerId,
        title: 'New Challenge!',
        body: 'Someone has challenged you to a versus match.',
        type: NotificationType.challengeReceived,
        createdAt: DateTime.now(),
        payload: {'challengeId': challenge.challengeId},
      ),
    );
  }

  Future<void> _notifyChallengeAccepted(CompetitiveChallenge challenge) async {
    await _repository.saveNotification(
      AppNotification(
        id: const Uuid().v4(),
        userId: challenge.challengerId,
        title: 'Challenge Accepted!',
        body: 'Your challenge has been accepted. Get ready!',
        type: NotificationType.challengeAccepted,
        createdAt: DateTime.now(),
        payload: {'challengeId': challenge.challengeId},
      ),
    );
  }

  Future<void> _notifyChallengeDeclined(CompetitiveChallenge challenge) async {
    await _repository.saveNotification(
      AppNotification(
        id: const Uuid().v4(),
        userId: challenge.challengerId,
        title: 'Challenge Declined',
        body: 'Your challenge was declined.',
        type: NotificationType.challengeDeclined,
        createdAt: DateTime.now(),
        payload: {'challengeId': challenge.challengeId},
      ),
    );
  }
}
