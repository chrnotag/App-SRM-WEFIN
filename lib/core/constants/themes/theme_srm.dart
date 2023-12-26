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
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(
            0xFF05204F, // Azul Primário (500)
            <int, Color>{
              50: Color(0xFFE1E8F4), // Azul (50)
              100: Color(0xFFB4C3E0), // Azul (100)
              200: Color(0xFF879ECB), // Azul (200)
              300: Color(0xFF5A79B7), // Azul (300)
              400: Color(0xFF2D549E), // Azul (400)
              500: Color(0xFF05204F), // Azul Primário (500)
              600: Color(0xFF041C46), // Azul (600)
              700: Color(0xFF03183D), // Azul (700)
              800: Color(0xFF021433), // Azul (800)
              900: Color(0xFF010B1A), // Azul (900)
            },
          ),
          errorColor: AppColors.vermelho,
          backgroundColor: const Color(0xFF05204F),
        ),
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
