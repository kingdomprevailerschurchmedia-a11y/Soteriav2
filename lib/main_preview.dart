import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'preview/app/preview_app.dart';
import 'preview/registry/all_previews.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerAllPreviews();

  runApp(const ProviderScope(child: SoteriaPreviewApp()));
}
