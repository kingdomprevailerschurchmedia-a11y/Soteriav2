/// Represents the various stages of a gameplay session.
enum GameLifecycle {
  /// Engine is setting up initial configurations and resources.
  initializing,

  /// Fetching questions or preparing assets.
  loading,

  /// Pre-game countdown or waiting for players (multiplayer).
  waiting,

  /// Active gameplay.
  playing,

  /// Session is temporarily suspended.
  paused,

  /// Current question has been answered, showing feedback/transition.
  answered,

  /// Session completed successfully.
  completed,

  /// Session ended due to loss of lives or failure criteria.
  failed,

  /// Session was manually terminated by the user.
  cancelled,

  /// Session ended due to inactivity or timer expiration.
  timeout;

  bool get isEndState =>
      this == GameLifecycle.completed ||
      this == GameLifecycle.failed ||
      this == GameLifecycle.cancelled ||
      this == GameLifecycle.timeout;
}
