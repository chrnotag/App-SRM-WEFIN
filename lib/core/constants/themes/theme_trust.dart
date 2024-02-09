import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modular_study/core/constants/extensions/screen_util_extension.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';

class ThemeTRUST {
  ThemeTRUST._();

  static final ThemeTRUST _instance = ThemeTRUST._();

  factory ThemeTRUST() {
    return _instance;
  }

  static ThemeData get theme => ThemeData(
        primaryColor: AppColors.verdePrimarioTRUST,
        indicatorColor: AppColors.verde,
        searchBarTheme: SearchBarThemeData(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    side: const BorderSide(color: AppColors.verdePrimarioTRUST))),
            constraints:
                BoxConstraints.expand(width: double.infinity, height: 35.h),
            hintStyle: MaterialStateProperty.all<TextStyle>(
                GoogleFonts.montserrat(
                    fontSize: AppSizes().fontSizeMedium,
                    color: AppColors.labelText)),
            textStyle:
                MaterialStateProperty.all<TextStyle>(GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeSmall,
            ))),
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: AppColors.verdePrimarioTRUST,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: AppColors.verdePrimarioTRUST,
            error: AppColors.vermelho,
            onError: Colors.redAccent.shade200,
            background: Colors.white,
            onBackground: AppColors.verdePrimarioTRUST,
            surface: Colors.white,
            onSurface: Colors.black,
        inverseSurface: Colors.black),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: IconThemeData(color: AppColors.verdePrimarioTRUST)),
        scaffoldBackgroundColor: Color(0xfff1f1f1),
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          bodySmall: GoogleFonts.montserrat(
            fontSize: AppSizes().fontSizeSmall,
          ),
          labelSmall: GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeVerySmall,
              fontWeight: FontWeight.bold,
              color: TrustShades.primaryColor[900]),
          labelMedium: GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeMedium,
              fontWeight: FontWeight.bold,
              color: TrustShades.primaryColor[900]),
          labelLarge: GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeLarge,
              fontWeight: FontWeight.bold,
              color: TrustShades.primaryColor[900]),
          bodyLarge: GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeLarge,
              color: TrustShades.primaryColor[900]),
          bodyMedium: GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeMedium,
              color: TrustShades.primaryColor[900]),
          displayMedium: GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeLarge,
              color: TrustShades.primaryColor[900]),
          displayLarge: GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeExtraLarge,
              color: TrustShades.primaryColor[900]),
        ),
        primaryTextTheme: TextTheme(
          bodySmall: GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeSmall,
              color: TrustShades.primaryColor[900]),
          labelSmall: GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeVerySmall,
              fontWeight: FontWeight.w300,
              color: TrustShades.primaryColor[900]),
          bodyLarge: GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeLarge,
              color: TrustShades.primaryColor[900]),
          bodyMedium: GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeMedium,
              color: TrustShades.primaryColor[900]),
          displayMedium: GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeLarge,
              color: TrustShades.primaryColor[900]),
          displayLarge: GoogleFonts.montserrat(
              fontSize: AppSizes().fontSizeExtraLarge,
              color: TrustShades.primaryColor[900]),
        ),
      );
}
