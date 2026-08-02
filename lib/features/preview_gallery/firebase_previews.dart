import 'package:flutter/material.dart';
import '../splash/initialization_failure_screen.dart';
import '../splash/splash_screen.dart';

class FirebasePreviews extends StatelessWidget {
  const FirebasePreviews({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Firebase Loading (Splash)'),
          onTap: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const SplashScreen())),
        ),
        ListTile(
          title: const Text('Firebase Initialization Failure'),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => InitializationFailureScreen(
                error: Exception(
                  'Network timeout during Firebase Core initialization',
                ),
                onRetry: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
