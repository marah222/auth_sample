import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static final TextStyle _baseTextStyle = GoogleFonts.inter(
    color: AppColors.primaryDarkText,
  );

  static final TextStyle title = _baseTextStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle subtitle = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
  );

  static final TextStyle body = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle caption = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
  );

  static final TextStyle button = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.backgroundWhite,
  );
}
