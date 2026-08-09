enum Difficulty { easy, medium, hard, expert }

enum QuestionType {
  multipleChoice,
  trueFalse,
  image,
  audio,
  video,
  fillBlank,
  ordering,
  dragAndDrop,
}

enum QuizStatus { idle, loading, ready, active, paused, completed, failed }

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

enum PowerUpType { fiftyFifty, pauseTimer, askAudience }
