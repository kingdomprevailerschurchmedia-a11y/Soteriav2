import 'package:flutter/foundation.dart';

@immutable
abstract class SoteriaAnalyticsEvent {
  final String name;
  final Map<String, Object?> parameters;

  const SoteriaAnalyticsEvent(this.name, [this.parameters = const {}]);
}

class AppOpenEvent extends SoteriaAnalyticsEvent {
  const AppOpenEvent() : super('app_open');
}

class ScreenViewEvent extends SoteriaAnalyticsEvent {
  ScreenViewEvent({required String screenName, String? screenClass})
    : super('screen_view', {
        'screen_name': screenName,
        if (screenClass != null) 'screen_class': screenClass,
      });
}

class LoginEvent extends SoteriaAnalyticsEvent {
  LoginEvent({required String method}) : super('login', {'method': method});
}

class SignUpEvent extends SoteriaAnalyticsEvent {
  SignUpEvent({required String method}) : super('sign_up', {'method': method});
}

class LogoutEvent extends SoteriaAnalyticsEvent {
  const LogoutEvent() : super('logout');
}

class PracticeStartedEvent extends SoteriaAnalyticsEvent {
  PracticeStartedEvent({required String categoryId, required String difficulty})
    : super('practice_started', {
        'category_id': categoryId,
        'difficulty': difficulty,
      });
}

class QuestionAnsweredEvent extends SoteriaAnalyticsEvent {
  QuestionAnsweredEvent({
    required String questionId,
    required bool isCorrect,
    required int responseTimeMs,
  }) : super('question_answered', {
         'question_id': questionId,
         'is_correct': isCorrect,
         'response_time_ms': responseTimeMs,
       });
}

class AchievementEarnedEvent extends SoteriaAnalyticsEvent {
  AchievementEarnedEvent({required String achievementId})
    : super('achievement_earned', {'achievement_id': achievementId});
}

class LevelUpEvent extends SoteriaAnalyticsEvent {
  LevelUpEvent({required int newLevel})
    : super('level_up', {'new_level': newLevel});
}

class NotificationOpenedEvent extends SoteriaAnalyticsEvent {
  NotificationOpenedEvent({required String type, String? action})
    : super('notification_opened', {
        'notification_type': type,
        if (action != null) 'action': action,
      });
}
