import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';


class AppTypography {
  AppTypography._();

  static TextTheme textTheme = TextTheme(
    headlineSmall: _title,
    titleMedium: _subtitle,
    bodyLarge: _body,
    bodyMedium: _body,
    bodySmall: _caption,
    labelLarge: _button,
  );

  static TextStyle get _title => GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDarkText,
  );

  static TextStyle get _subtitle => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
  );

  static TextStyle get _body => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
  );

  static TextStyle get _caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
  );

  static TextStyle get _button => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}