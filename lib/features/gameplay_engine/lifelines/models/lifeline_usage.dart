import 'package:uuid/uuid.dart';
import 'lifeline_type.dart';

class LifelineUsage {
  final String usageId;
  final String sessionId;
  final LifelineType type;
  final DateTime timestamp;
  final String questionId;
  final int remainingUses;

  LifelineUsage({
    String? usageId,
    required this.sessionId,
    required this.type,
    required this.timestamp,
    required this.questionId,
    required this.remainingUses,
  }) : usageId = usageId ?? const Uuid().v4();
}
