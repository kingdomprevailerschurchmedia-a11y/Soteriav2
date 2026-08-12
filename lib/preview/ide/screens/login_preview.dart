import 'package:flutter/material.dart';
import '../../../features/auth/screens/login_screen.dart';
import '../preview_scaffold.dart';

void main() {
  runApp(const LoginPreview());
}

class LoginPreview extends StatelessWidget {
  const LoginPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const PreviewScaffold(child: LoginScreen());
  }
}
