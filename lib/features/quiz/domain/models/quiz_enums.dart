export '../../../question_content/domain/entities/difficulty.dart';

enum QuizStatus {
  idle,
  loading,
  ready,
  active,
  paused,
  completing,
  finalizing,
  completed,
  failed,
}

enum TimerStatus { idle, running, warning, critical, paused, expired }

enum GameMode {
  practice,
  pro,
  tournament,
  versus,
  aiChallenge,
  teamBattle,
  dailyChallenge,
  seasonalEvent,
}

enum PowerUpType {
  fiftyFifty,
  pauseTimer,
  askAudience,
  extraTime,
  doubleXP,
  shield,
  revealCategory,
}

enum PowerUpStatus {
  available,
  used,
  disabled,
  locked,
  activating,
  active,
  completed,
  failed,
}

enum SessionStatus {
  created,
  active,
  paused,
  interrupted,
  recoverable,
  completed,
  cancelled,
  expired,
  corrupted,
  deleted,
}
