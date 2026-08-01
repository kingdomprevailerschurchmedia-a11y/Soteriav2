import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void setupTestEnvironment() {
  GoogleFonts.config.allowRuntimeFetching = false;
  
  // Suppress the font loading error in tests as we don't have them in assets yet
  FlutterError.onError = (details) {
    if (details.exception.toString().contains('google_fonts')) {
      return;
    }
    FlutterError.presentError(details);
  };
}
