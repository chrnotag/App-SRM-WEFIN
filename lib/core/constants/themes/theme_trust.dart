import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';

class ThemeTRUST {
  ThemeTRUST._();

  static final ThemeTRUST _instance = ThemeTRUST._();

  factory ThemeTRUST() {
    return _instance;
  }

  static ThemeData get theme => ThemeData(
        primaryColor: AppColors.corPrimariaTRUST,
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.corPrimariaTRUST,
        onPrimary: AppColors.branco,
        secondary: Colors.white,
        onSecondary: AppColors.branco,
        error: AppColors.vermelho,
        onError: Colors.redAccent.shade200,
        background: Colors.white,
        onBackground: AppColors.corPrimariaTRUST,
        surface: AppColors.branco,
        onSurface: Colors.black),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          bodySmall: GoogleFonts.montserrat(
            fontSize: AppSizes.fontSizeSmall,
          ),
          labelSmall: GoogleFonts.montserrat(
              fontSize: AppSizes.fontSizeVerySmall,
              fontWeight: FontWeight.w300),
          bodyLarge: GoogleFonts.montserrat(fontSize: AppSizes.fontSizeLarge),
          bodyMedium: GoogleFonts.montserrat(fontSize: AppSizes.fontSizeMedium),
          displayMedium:
          GoogleFonts.montserrat(fontSize: AppSizes.fontSizeLarge),
          displayLarge:
          GoogleFonts.montserrat(fontSize: AppSizes.fontSizeExtraLarge),
        ),
        primaryTextTheme: TextTheme(
          bodySmall: GoogleFonts.montserrat(
            fontSize: AppSizes.fontSizeSmall,
          ),
          labelSmall: GoogleFonts.montserrat(
              fontSize: AppSizes.fontSizeVerySmall,
              fontWeight: FontWeight.w300),
          bodyLarge: GoogleFonts.montserrat(fontSize: AppSizes.fontSizeLarge),
          bodyMedium: GoogleFonts.montserrat(fontSize: AppSizes.fontSizeMedium),
          displayMedium:
              GoogleFonts.montserrat(fontSize: AppSizes.fontSizeLarge),
          displayLarge:
              GoogleFonts.montserrat(fontSize: AppSizes.fontSizeExtraLarge),
        ),
      );
}
