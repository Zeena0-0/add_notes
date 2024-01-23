import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/theme/app_colors.dart';

class AppTextStyles {
  static TextStyle get headline1 => GoogleFonts.cairo(
    fontSize: 17,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get bodyText => GoogleFonts.cairo(
    fontSize: 15,
    fontWeight: FontWeight.w500,

  );
  static TextStyle get date => GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.purple

  );
  static TextStyle get done => GoogleFonts.cairo(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color:  AppColors.purple
  );
  static TextStyle get notdone => GoogleFonts.cairo(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color:  AppColors.orange
  );
}
