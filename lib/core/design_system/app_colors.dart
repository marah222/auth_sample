import 'package:flutter/material.dart';

// A utility class to hold all the colors for the app.
// This prevents hard-coding color values in the UI and ensures consistency.
class AppColors {
  // This class is not meant to be instantiated.
  AppColors._();

  // --- Primary Palette ---
  static const Color primaryBlue = Color(0xFF4E86F7);
  static const Color primaryDarkText = Color(0xFF0E0F12);
  static const Color secondaryText = Color(0xFF555555);

  // --- General ---
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color lightGreyBackground = Color(0xFFF4F4F4);

  // --- UI Feedback & Status ---
  static const Color disabled = Color(0xFFB5B5B5);
  static const Color successGreen = Color(0xFF5BD77E);
  static const Color warningYellow = Color(0xFFF5C044);
  static const Color errorRed = Color(0xFFFF3B30);
}