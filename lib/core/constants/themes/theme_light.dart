import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_configs.dart';

/*
  Configuração do tema principal do modo claro.
  As cores principais definidas são uma escala de mais claro para mais escuro
  da cor principal do aplicativo, estão sendo utilizadas dentro do colorScheme.

  Os estilos de textos estão definidos para os tamanhos detectados no front-end.
  O scaffold já está com seu background configurado.
 */
class ThemeLight {
  ThemeLight._();

  static final ThemeLight _instance = ThemeLight._();

  factory ThemeLight() {
    return _instance;
  }

  static ThemeData get theme_light => ThemeData(
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
        errorColor: AppColors.statusVermelho,
        backgroundColor: const Color(0xFF05204F),
        brightness: Brightness.light,
      ),
      // primaryColorDark: const Color(0xff336797),
      // primaryColorLight: const Color(0xffDDE9C7),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
      scaffoldBackgroundColor: AppColors.globalBackground,
      primaryTextTheme: TextTheme(
        bodySmall: GoogleFonts.montserrat(
          fontSize: AppSizes.fontSizeSmall,
        ),
        labelSmall: GoogleFonts.montserrat(
            fontSize: AppSizes.fontSizeVerySmall, fontWeight: FontWeight.w300),
        bodyLarge: GoogleFonts.montserrat(fontSize: AppSizes.fontSizeLarge),
        bodyMedium: GoogleFonts.montserrat(fontSize: AppSizes.fontSizeMedium),
        displayMedium: GoogleFonts.montserrat(fontSize: AppSizes.fontSizeLarge),
        displayLarge:
            GoogleFonts.montserrat(fontSize: AppSizes.fontSizeExtraLarge),
      ));

  //Tema para IOS
  static CupertinoThemeData get cupertinoThemeLight {
    const baseTheme = CupertinoThemeData();

    return CupertinoThemeData(
      primaryColor: const Color(0xFF05204F),
      scaffoldBackgroundColor: AppColors.globalBackground,
      barBackgroundColor: Colors.transparent,
      primaryContrastingColor: CupertinoColors.white,
      textTheme: CupertinoTextThemeData(
        textStyle: GoogleFonts.montserrat(
          fontSize: AppSizes.fontSizeMedium,
        ),
        actionTextStyle: GoogleFonts.montserrat(
          fontSize: AppSizes.fontSizeMedium,
          color: CupertinoColors.activeBlue,
        ),
        navTitleTextStyle: GoogleFonts.montserrat(
          fontSize: AppSizes.fontSizeMedium,
          fontWeight: FontWeight.bold,
        ),
        tabLabelTextStyle: GoogleFonts.montserrat(
          fontSize: AppSizes.fontSizeSmall,
          fontWeight: FontWeight.w500,
        ),
      ),
    ).copyWith(
      brightness: Brightness.light,
    );
  }
}
