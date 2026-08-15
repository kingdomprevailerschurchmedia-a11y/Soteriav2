import 'package:intl/intl.dart';

class EngagementService {
  /// Returns the current date string (YYYY-MM-DD) for a given timezone.
  /// For now, we assume UTC if timezone parsing is complex, or we can use 
  /// simple offset-based calculation if we had the offset.
  /// TODO: Integrate with a robust timezone library if needed.
  String getEngagementDate(DateTime timestamp, String timezone) {
    // For now, using UTC as the baseline to ensure consistency across clients.
    // In a production app, we would resolve the timezone string to an offset.
    final utc = timestamp.toUtc();
    return DateFormat('yyyy-MM-dd').format(utc);
  }

  /// Determines if [current] is the day immediately following [last].
  bool isConsecutive(String last, String current) {
    final lastDate = DateTime.parse(last);
    final currentDate = DateTime.parse(current);
    
    final difference = currentDate.difference(lastDate).inDays;
    return difference == 1;
  }

  /// Determines if [current] is the same day as [last].
  bool isSameDay(String last, String current) {
    return last == current;
  }
}
