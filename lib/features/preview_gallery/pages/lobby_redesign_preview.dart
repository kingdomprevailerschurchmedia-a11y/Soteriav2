import 'package:flutter/material.dart';
import 'package:soteria/features/preview_gallery/widgets/preview_wrapper.dart';
import 'package:soteria/features/dashboard/presentation/screens/practice_lobby_screen.dart';

class LobbyRedesignPreview extends StatelessWidget {
  const LobbyRedesignPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewWrapper(
      title: 'Practice Lobby Redesign',
      builder: (context, state) {
        return const PracticeLobbyScreen();
      },
    );
  }
}
