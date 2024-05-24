import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import '../configs_tema/export_config_theme_srm.dart';
import '../../../generated/assets.dart';
import '../AppSizes.dart';

class ThemeTRUST {
  ThemeTRUST._();

  static final ThemeTRUST _instance = ThemeTRUST._();

  factory ThemeTRUST() {
    return _instance;
  }

  static ThemeData get theme => ThemeData(
        primaryColor: TRUSTColors.primaryColor,
        indicatorColor: TRUSTColors.primaryColor,
        focusColor: TRUSTColors.primaryColor,
        searchBarTheme: SearchBarThemeData(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    side: BorderSide(color: TRUSTColors.primaryColor))),
            constraints:
                BoxConstraints.expand(width: double.infinity, height: 35.h),
            hintStyle: MaterialStateProperty.all<TextStyle>(
                GoogleFonts.montserrat(
                    fontSize: AppSizes().bodyMedium,
                    color: TRUSTColors.textLabelColor)),
            textStyle:
                MaterialStateProperty.all<TextStyle>(GoogleFonts.montserrat(
              fontSize: AppSizes().bodySmall,
            ))),
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: TRUSTColors.primaryColor,
            onPrimary: TRUSTColors.onPrimaryColor,
            secondary: TRUSTColors.secondaryColor,
            onSecondary: TRUSTColors.onSecondaryColor,
            error: TRUSTColors.errorColor,
            onError: TRUSTColors.onErrorColor,
            background: TRUSTColors.backgorundColor,
            onBackground: TRUSTColors.onBackgorundColor,
            surface: TRUSTColors.surfaceColor,
            onSurface: TRUSTColors.onSurfaceColor,
            inverseSurface: TRUSTColors.inverseSurfaceColor,
            surfaceTint: TRUSTColors.secondaryColor),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: IconThemeData(color: TRUSTColors.primaryColor)),
        scaffoldBackgroundColor: TRUSTColors.backgorundColor,
        textTheme: TextTheme(
          bodySmall: GoogleFonts.montserrat(fontSize: AppSizes().bodySmall),
          bodyMedium: GoogleFonts.montserrat(
              fontSize: AppSizes().bodyMedium, color: Colors.black),
          bodyLarge: GoogleFonts.montserrat(fontSize: AppSizes().bodyLarge),
          labelMedium: GoogleFonts.montserrat(
              fontSize: AppSizes().labelMedium, color: Colors.black),
          displaySmall:
              GoogleFonts.montserrat(fontSize: AppSizes().displaySmall),
          displayMedium:
              GoogleFonts.montserrat(fontSize: AppSizes().displayMedium),
        ),
      );

  static String get logo => Assets.trust_logo;

  static String get logoAppBar => Assets.icone_trust;

  static Widget get imagemAjuda => Image.asset(Assets.imagesIcAjuda,
      width: 176.w, color: TRUSTColors.primaryColor);
}
