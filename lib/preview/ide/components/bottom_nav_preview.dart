import 'package:flutter/material.dart';
import '../../../core/widgets/navigation/soteria_bottom_nav_bar.dart';
import '../preview_scaffold.dart';

void main() {
  runApp(const BottomNavPreview());
}

class BottomNavPreview extends StatelessWidget {
  const BottomNavPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewScaffold(
      child: Stack(
        children: [
          const Center(child: Text('Main Content Area')),
          Align(
            alignment: Alignment.bottomCenter,
            child: SoteriaBottomNavBar(currentIndex: 0, onTap: (index) {}),
          ),
        ],
      ),
    );
  }
}
