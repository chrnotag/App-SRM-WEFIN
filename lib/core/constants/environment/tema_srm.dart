import 'package:Srm_Asset/core/constants/classes_abstratas/imagens_guia_certificado.dart';
import 'package:Srm_Asset/core/constants/configs_tema/srm/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import '../../../../../generated/assets.dart';
import '../AppSizes.dart';
import '../configs_tema/export_config_theme_srm.dart';

class ThemeSRM implements ImagensGuiaImportarCertificado{
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
            GoogleFonts.inter(
                fontSize: AppSizes().bodyLarge,
                color: SRMColors.textLabelColor)),
        textStyle:
        MaterialStateProperty.all<TextStyle>(GoogleFonts.inter(
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
      bodySmall: GoogleFonts.inter(fontSize: AppSizes().bodySmall, color: SRMColors.textBodyColor),
      bodyMedium: GoogleFonts.inter(fontSize: AppSizes().bodyMedium, color: SRMColors.textBodyColor),
      bodyLarge: GoogleFonts.inter(fontSize: AppSizes().bodyLarge, color: SRMColors.textBodyColor),
      labelMedium: GoogleFonts.inter(fontSize: AppSizes().labelMedium, color: SRMColors.textLabelColor),
      displaySmall:
      GoogleFonts.inter(fontSize: AppSizes().displaySmall, color: SRMColors.textDisplayColor),
      displayMedium:
      GoogleFonts.inter(fontSize: AppSizes().displayMedium, color: SRMColors.textDisplayColor),
    ),
  );

  static String get logo => 'assets/images/logo_srm.png';

  static String get logoAppBar => Assets.icone_srm;

  static Widget get imagemAjuda =>
      Image.asset(Assets.iconsIcCellCheck, width: 176.w, color: null);

  @override
  // TODO: implement primeiroSlideDispositivo
  String get primeiroSlideDispositivo => Assets.importe_certificado_svg;

  @override
  // TODO: implement primeiroSlideQrCode
  String get primeiroSlideQrCode => Assets.importe_certificado_svg;

  @override
  // TODO: implement quartoSlideDispositivo
  String get quartoSlideDispositivo => Assets.informe_senha_certificado_svg;

  @override
  // TODO: implement quartoSlideQrCode
  String get quartoSlideQrCode => Assets.informe_senha_certificado_svg;

  @override
  // TODO: implement quintoSlideDispositivo
  String get quintoSlideDispositivo => Assets.importacao_concluida_svg;

  @override
  // TODO: implement quintoSlideQrCode
  String get quintoSlideQrCode => Assets.importacao_concluida_svg;

  @override
  // TODO: implement segundoSlideDispositivo
  String get segundoSlideDispositivo => Assets.selecionar_certificado_svg;

  @override
  // TODO: implement segundoSlideQrCode
  String get segundoSlideQrCode => Assets.upload_certificado_svg;

  @override
  // TODO: implement terceiroSlideDispositivo
  String get terceiroSlideDispositivo => Assets.localizar_cetificado_svg;

  @override
  // TODO: implement terceiroSlideQrCode
  String get terceiroSlideQrCode => Assets.scanear_qrcode_svg;

  @override
  // TODO: implement senhaCertificado
  String get senhaCertificado => Assets.senha_certificado_dialog;
}