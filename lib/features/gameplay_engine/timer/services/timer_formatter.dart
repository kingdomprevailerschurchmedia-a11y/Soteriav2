class TimerFormatter {
  static String format(Duration duration) {
    if (duration.inSeconds >= 10) {
      return duration.inSeconds.toString();
    } else {
      // Show one decimal place for critical timing < 10s
      final seconds = duration.inMilliseconds / 1000;
      return seconds.toStringAsFixed(1);
    }
  }
}
