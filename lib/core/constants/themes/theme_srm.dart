import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';

import 'theme_configs.dart';

class ThemeSRM {
  ThemeSRM._();

  static final ThemeSRM _instance = ThemeSRM._();

  factory ThemeSRM() {
    return _instance;
  }

  static ThemeData get theme => ThemeData(
        primaryColor: AppColors.azulPrimarioSRM,
        indicatorColor: AppColors.azul,
        searchBarTheme: SearchBarThemeData(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide.none)),
            constraints:
                BoxConstraints.expand(width: double.infinity, height: 35.h),
            hintStyle: MaterialStateProperty.all<TextStyle>(
                GoogleFonts.montserrat(
                    fontSize: AppSizes().bodyMedium,
                    color: AppColors.labelText)),
            textStyle:
                MaterialStateProperty.all<TextStyle>(GoogleFonts.montserrat(
              fontSize: AppSizes().bodySmall,
            ))),
        dialogBackgroundColor: Colors.white,
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: AppColors.azulPrimarioSRM,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.white,
            error: AppColors.vermelho,
            onError: Colors.redAccent.shade200,
            background: AppColors.azulPrimarioSRM,
            onBackground: AppColors.azulPrimarioSRM,
            surface: Colors.white,
            onSurface: Colors.black,
            inverseSurface: Colors.white),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white)),
        scaffoldBackgroundColor: AppColors.azul,
        textTheme: TextTheme(
          bodySmall: GoogleFonts.montserrat(fontSize: AppSizes().bodySmall),
          bodyMedium: GoogleFonts.montserrat(fontSize: AppSizes().bodyMedium),
          bodyLarge: GoogleFonts.montserrat(fontSize: AppSizes().bodyLarge),
          labelMedium: GoogleFonts.montserrat(fontSize: AppSizes().labelMedium),
          displaySmall:
              GoogleFonts.montserrat(fontSize: AppSizes().displaySmall),
          displayMedium:
              GoogleFonts.montserrat(fontSize: AppSizes().displayMedium),
        ),
      );
}
