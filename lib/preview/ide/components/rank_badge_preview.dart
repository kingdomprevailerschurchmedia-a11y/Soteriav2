import 'package:flutter/material.dart';
import '../../../features/player/presentation/widgets/rank_badge.dart';
import '../preview_scaffold.dart';

void main() {
  runApp(const RankBadgePreview());
}

class RankBadgePreview extends StatelessWidget {
  const RankBadgePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const PreviewScaffold(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RankBadge(rankName: 'Bronze I', tierId: 'bronze', isLarge: true),
            SizedBox(height: 16),
            RankBadge(rankName: 'Diamond II', tierId: 'diamond', isLarge: true),
            SizedBox(height: 16),
            RankBadge(rankName: 'Master III', tierId: 'master', isLarge: true),
          ],
        ),
      ),
    );
  }
}
