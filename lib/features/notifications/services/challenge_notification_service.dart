import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../player/domain/models/competitive_challenge.dart';
import '../../player/presentation/providers/challenge_providers.dart';
import '../domain/models/app_notification.dart';
import '../domain/repositories/notification_repository.dart';
import '../../../auth/providers/auth_providers.dart';
import 'package:uuid/uuid.dart';

class ChallengeNotificationService {
  final Ref _ref;
  final NotificationRepository _repository;

  ChallengeNotificationService(this._ref, this._repository);

  void start() {
    _observeIncomingChallenges();
  }

  void _observeIncomingChallenges() {
    _ref.listen<AsyncValue<List<CompetitiveChallenge>>>(incomingChallengesProvider, (previous, next) {
      final oldChallenges = previous?.value ?? [];
      final newChallenges = next.value ?? [];

      if (newChallenges.length > oldChallenges.length) {
        final added = newChallenges.where((n) => !oldChallenges.any((o) => o.challengeId == n.challengeId));
        for (final challenge in added) {
          _repository.saveNotification(
            AppNotification(
              id: const Uuid().v4(),
              title: 'New Challenge!',
              body: 'A competitor has challenged you to a Versus match.',
              type: NotificationType.challengeReceived,
              createdAt: DateTime.now(),
              action: 'challenges',
              payload: {'challengeId': challenge.challengeId},
            ),
          );
        }
      }
    });
  }
}
