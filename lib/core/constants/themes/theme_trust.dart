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
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(
            0xFF0EAC58, // Hex code for the primary green color
            {
              50: Color(0xFFE8F5EC), // Verde (50)
              100: Color(0xFFC4E6CF), // Verde (100)
              200: Color(0xFF9FD7B1), // Verde (200)
              300: Color(0xFF7BC893), // Verde (300)
              400: Color(0xFF56B975), // Verde (400)
              500: Color(0xFF0EAC58), // Verde Primário (500)
              600: Color(0xFF0C994F), // Verde (600)
              700: Color(0xFF0A8645), // Verde (700)
              800: Color(0xFF08733C), // Verde (800)
              900: Color(0xFF065F32), // Verde (900)
            },
          ),
          errorColor: AppColors.vermelho,
          backgroundColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        scaffoldBackgroundColor: Colors.white,
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
