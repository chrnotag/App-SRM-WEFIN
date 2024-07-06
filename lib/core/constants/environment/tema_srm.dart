import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/imagens_guia_certificado.dart';
import 'package:Srm_Asset/core/constants/configs_tema/srm/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
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

  static String get logoAppBar => AssetsConfig.imagesIconeSrm;

  static Widget get imagemAjuda =>
      SvgPicture.asset(AssetsConfig.srmCellphone, width: 176.w, color: null);

  @override
  // TODO: implement primeiroSlideDispositivo
  String get primeiroSlideDispositivo => AssetsConfig.srmImporteCertificado;

  @override
  // TODO: implement primeiroSlideQrCode
  String get primeiroSlideQrCode => AssetsConfig.srmImporteCertificado;

  @override
  // TODO: implement quartoSlideDispositivo
  String get quartoSlideDispositivo => AssetsConfig.srmInformeSenhaCertificado;

  @override
  // TODO: implement quartoSlideQrCode
  String get quartoSlideQrCode => AssetsConfig.srmInformeSenhaCertificado;

  @override
  // TODO: implement quintoSlideDispositivo
  String get quintoSlideDispositivo => AssetsConfig.srmImportacaoConcluida;

  @override
  // TODO: implement quintoSlideQrCode
  String get quintoSlideQrCode => AssetsConfig.srmImportacaoConcluida;

  @override
  // TODO: implement segundoSlideDispositivo
  String get segundoSlideDispositivo => AssetsConfig.srmSelecionarCertificado;

  @override
  // TODO: implement segundoSlideQrCode
  String get segundoSlideQrCode => AssetsConfig.srmUploadCertificado;

  @override
  // TODO: implement terceiroSlideDispositivo
  String get terceiroSlideDispositivo => AssetsConfig.srmLocalizarCertificado;

  @override
  // TODO: implement terceiroSlideQrCode
  String get terceiroSlideQrCode => AssetsConfig.srmScanearQrcode;

  @override
  // TODO: implement senhaCertificado
  String get senhaCertificado => AssetsConfig.srmSenhaCertificadoDialog;
}