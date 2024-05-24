import 'package:Srm_Asset/core/constants/configs_tema/srm/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import '../../../../../generated/assets.dart';
import '../AppSizes.dart';
import '../configs_tema/export_config_theme_srm.dart';

class ThemeSRM {
  ThemeSRM._();

  static final ThemeSRM _instance = ThemeSRM._();

  factory ThemeSRM() {
    return _instance;
  }

  static ThemeData get theme => ThemeData(
    focusColor: SRMColors.focusColor,
    searchBarTheme: SearchBarThemeData(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide.none)),
        constraints:
        BoxConstraints.expand(width: double.infinity, height: 50.h),
        hintStyle: MaterialStateProperty.all<TextStyle>(
            GoogleFonts.montserrat(
                fontSize: AppSizes().bodyLarge,
                color: SRMColors.textLabelColor)),
        textStyle:
        MaterialStateProperty.all<TextStyle>(GoogleFonts.montserrat(
          fontSize: AppSizes().bodyLarge,
        ))),
    dialogBackgroundColor: Colors.white,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: SRMColors.primaryColor,
      onPrimary: SRMColors.onPrimaryColor,
      secondary: SRMColors.secondaryColor,
      onSecondary: SRMColors.onSecondaryColor,
      error: SRMColors.errorColor,
      onError: SRMColors.onErrorColor,
      background: const Color(0XFFF8F9FB),
      onBackground: SRMColors.onBackgorundColor,
      surface: SRMColors.surfaceColor,
      onSurface: SRMColors.onSurfaceColor,
      surfaceTint: SRMColors.backgorundColor,
      inverseSurface: SRMColors.inverseSurfaceColor,),
    appBarTheme: AppBarTheme(
        backgroundColor: SRMColors.secondaryColor,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white)),
    scaffoldBackgroundColor: SRMColors.backgorundColor,
    textTheme: TextTheme(
      bodySmall: GoogleFonts.montserrat(fontSize: AppSizes().bodySmall, color: SRMColors.textBodyColor),
      bodyMedium: GoogleFonts.montserrat(fontSize: AppSizes().bodyMedium, color: SRMColors.textBodyColor),
      bodyLarge: GoogleFonts.montserrat(fontSize: AppSizes().bodyLarge, color: SRMColors.textBodyColor),
      labelMedium: GoogleFonts.montserrat(fontSize: AppSizes().labelMedium, color: SRMColors.textLabelColor),
      displaySmall:
      GoogleFonts.montserrat(fontSize: AppSizes().displaySmall, color: SRMColors.textDisplayColor),
      displayMedium:
      GoogleFonts.montserrat(fontSize: AppSizes().displayMedium, color: SRMColors.textDisplayColor),
    ),
  );

  static String get logo => 'assets/images/logo_srm.png';

  static String get logoAppBar => Assets.icone_srm;

  static Widget get imagemAjuda =>
      Image.asset(Assets.iconsIcCellCheck, width: 176.w, color: null);
}