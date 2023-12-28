import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_configs.dart';

class ThemeSRM {
  ThemeSRM._();

  static final ThemeSRM _instance = ThemeSRM._();

  factory ThemeSRM() {
    return _instance;
  }

  static ThemeData get theme => ThemeData(
        primaryColor: AppColors.azul,
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: AppColors.corPrimariaSRM,
            onPrimary: AppColors.branco,
            secondary: Colors.white,
            onSecondary: AppColors.labelText,
            error: AppColors.vermelho,
            onError: Colors.redAccent.shade200,
            background: AppColors.corPrimariaSRM,
            onBackground: AppColors.corPrimariaSRM,
            surface: AppColors.brancoGelo,
            onSurface: Colors.black),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        scaffoldBackgroundColor: AppColors.corPrimariaSRM,
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
