import 'lifeline_type.dart';
import 'lifeline_usage.dart';

sealed class LifelineEvent {}

class LifelineActivated extends LifelineEvent {
  final LifelineType type;
  final String questionId;
  LifelineActivated(this.type, this.questionId);
}

class LifelineCompleted extends LifelineEvent {
  final LifelineType type;
  final dynamic result;
  LifelineCompleted(this.type, this.result);
}

class LifelineRejected extends LifelineEvent {
  final LifelineType type;
  final String reason;
  LifelineRejected(this.type, this.reason);
}

class LifelineUsageConsumed extends LifelineEvent {
  final LifelineUsage usage;
  LifelineUsageConsumed(this.usage);
}
