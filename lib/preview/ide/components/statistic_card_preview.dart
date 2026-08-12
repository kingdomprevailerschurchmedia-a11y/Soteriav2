import 'package:flutter/material.dart';
import '../../../features/player/presentation/widgets/profile/statistic_card.dart';
import '../preview_scaffold.dart';

void main() {
  runApp(const StatisticCardPreview());
}

class StatisticCardPreview extends StatelessWidget {
  const StatisticCardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const PreviewScaffold(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatisticCard(
                label: 'Games Played',
                value: '50',
                icon: Icons.sports_esports_rounded,
              ),
              SizedBox(height: 16),
              StatisticCard(
                label: 'Accuracy',
                value: '85%',
                icon: Icons.track_changes_rounded,
                color: Colors.greenAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
