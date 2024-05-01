import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import '../../../../../generated/assets.dart';
import '../AppSizes.dart';
import '../tema_configs.dart';

class ThemeSRM {
  ThemeSRM._();

  static final ThemeSRM _instance = ThemeSRM._();

  factory ThemeSRM() {
    return _instance;
  }

  static ThemeData get theme => ThemeData(
    focusColor: AppColors.laranjaSRM,
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
                color: AppColors.labelText)),
        textStyle:
        MaterialStateProperty.all<TextStyle>(GoogleFonts.montserrat(
          fontSize: AppSizes().bodyLarge,
        ))),
    dialogBackgroundColor: Colors.white,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.laranjaSRM,
      onPrimary: Colors.white,
      secondary: AppColors.azul,
      onSecondary: Colors.white,
      error: AppColors.vermelho,
      onError: Colors.redAccent.shade200,
      background: const Color(0XFFF8F9FB),
      onBackground: AppColors.azul,
      surface: Colors.white,
      onSurface: AppColors.azul,
      inverseSurface: Colors.white,),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white)),
    scaffoldBackgroundColor: const Color(0XFFF8F9FB),
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

  static String get logo => 'assets/images/logo_srm.png';

  static String get logoAppBar => Assets.icone_srm;

  static Widget get imagemAjuda =>
      Image.asset(Assets.iconsIcCellCheck, width: 176.w, color: null);
  static Color get brancoOuVerde => Colors.white;
  static Color get azulOuPreto => AppColors.azul;
  static Color get verdeOuCinza => AppColors.verdePrimarioTRUST;
  static Color get laranjaOuCinza => AppColors.laranjaSRM;

}