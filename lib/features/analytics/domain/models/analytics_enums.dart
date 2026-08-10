enum TimePeriod {
  last7Days,
  last30Days,
  last90Days,
  allTime;

  String get label {
    switch (this) {
      case TimePeriod.last7Days:
        return '7 Days';
      case TimePeriod.last30Days:
        return '30 Days';
      case TimePeriod.last90Days:
        return '90 Days';
      case TimePeriod.allTime:
        return 'All Time';
    }
  }
}

enum TrendDirection {
  improving,
  stable,
  declining,
  insufficientData;
}

enum InsightType {
  improvement,
  strength,
  opportunity,
  speed,
  accuracy,
  consistency,
  category,
  difficulty,
  streak,
  personalBest,
  insufficientData;
}

enum InsightConfidence {
  high,
  medium,
  low,
  insufficientData;
}
