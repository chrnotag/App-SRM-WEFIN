import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/tema_configs.dart';

import '../../../../../generated/assets.dart';

class ThemeTRUST {
  ThemeTRUST._();

  static final ThemeTRUST _instance = ThemeTRUST._();

  factory ThemeTRUST() {
    return _instance;
  }

  static ThemeData get theme => ThemeData(
        primaryColor: AppColors.verdePrimarioTRUST,
        indicatorColor: AppColors.verde,
        focusColor: AppColors.verdePrimarioTRUST,
        searchBarTheme: SearchBarThemeData(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    side:
                        const BorderSide(color: AppColors.verdePrimarioTRUST))),
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
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: AppColors.verdePrimarioTRUST,
            onPrimary: Colors.white,
            secondary: AppColors.verdePrimarioTRUST,
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

  static String get logo => 'assets/images/logo_trust.png';

  static String get logoAppBar => 'assets/images/logo_appbar_trust.png';

  static Widget get imagemAjuda => Image.asset(Assets.imagesIcAjuda,
      width: 176.w, color: AppColors.verdePrimarioTRUST);
}
