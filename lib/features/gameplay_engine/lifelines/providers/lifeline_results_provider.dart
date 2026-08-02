import 'package:flutter_riverpod/legacy.dart';

class LifelineResults {
  final List<String> hiddenOptionIds;
  final Map<String, double>? audienceVotes;

  const LifelineResults({this.hiddenOptionIds = const [], this.audienceVotes});

  LifelineResults copyWith({
    List<String>? hiddenOptionIds,
    Map<String, double>? audienceVotes,
  }) {
    return LifelineResults(
      hiddenOptionIds: hiddenOptionIds ?? this.hiddenOptionIds,
      audienceVotes: audienceVotes ?? this.audienceVotes,
    );
  }
}

class LifelineResultsNotifier extends StateNotifier<LifelineResults> {
  LifelineResultsNotifier() : super(const LifelineResults());

  void setHiddenOptions(List<String> ids) {
    state = state.copyWith(hiddenOptionIds: ids);
  }

  void setAudienceVotes(Map<String, double> votes) {
    state = state.copyWith(audienceVotes: votes);
  }

  void reset() {
    state = const LifelineResults();
  }
}

final lifelineResultsProvider =
    StateNotifierProvider.autoDispose<LifelineResultsNotifier, LifelineResults>(
      (ref) {
        return LifelineResultsNotifier();
      },
    );
