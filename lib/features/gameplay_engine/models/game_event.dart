import 'package:soteria/features/question_content/domain/entities/question.dart';

/// Sealed class for all events that can occur within the Gameplay Engine.
sealed class GameEvent {}

class QuestionLoaded extends GameEvent {
  final Question question;
  QuestionLoaded(this.question);
}

class AnswerSubmitted extends GameEvent {
  final String answerId;
  final Duration timeTaken;
  AnswerSubmitted(this.answerId, this.timeTaken);
}

class TimerExpired extends GameEvent {}

class LifelineUsed extends GameEvent {
  final String lifelineId;
  LifelineUsed(this.lifelineId);
}

class SessionPaused extends GameEvent {}

class SessionResumed extends GameEvent {}

class SessionEnded extends GameEvent {
  final String reason;
  SessionEnded(this.reason);
}
