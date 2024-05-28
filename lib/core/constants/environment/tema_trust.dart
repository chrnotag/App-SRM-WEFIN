import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/imagens_guia_certificado.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import '../configs_tema/export_config_theme_srm.dart';
import '../../../generated/assets.dart';
import '../AppSizes.dart';

class ThemeTRUST implements ImagensGuiaImportarCertificado{
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
            surface: Colors.white,
            onSurface: TRUSTColors.onSurfaceColor,
            inverseSurface: TRUSTColors.inverseSurfaceColor,
            surfaceTint: Colors.white),
        appBarTheme: AppBarTheme(
            backgroundColor: TRUSTColors.secondaryColor,
            shadowColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white)),
        scaffoldBackgroundColor: TRUSTColors.backgorundColor,
        textTheme: TextTheme(
          bodySmall: GoogleFonts.montserrat(fontSize: AppSizes().bodySmall),
          bodyMedium: GoogleFonts.montserrat(
              fontSize: AppSizes().bodyMedium, color: Colors.black),
          bodyLarge: GoogleFonts.montserrat(fontSize: AppSizes().bodyLarge, color: TRUSTColors.textLabelColor),
          labelMedium: GoogleFonts.montserrat(
              fontSize: AppSizes().labelMedium, color: TRUSTColors.textLabelColor),
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

  @override
  // TODO: implement primeiroSlideDispositivo
  String get primeiroSlideDispositivo => AssetsConfig.imagesDocumentCertTrust;

  @override
  // TODO: implement primeiroSlideQrCode
  String get primeiroSlideQrCode => AssetsConfig.imagesDocumentCertTrust;

  @override
  // TODO: implement quartoSlideDispositivo
  String get quartoSlideDispositivo  => AssetsConfig.imagesSenhaSlideCertTrust;

  @override
  // TODO: implement quartoSlideQrCode
  String get quartoSlideQrCode => AssetsConfig.imagesSenhaSlideCertTrust;

  @override
  // TODO: implement quintoSlideDispositivo
  String get quintoSlideDispositivo => AssetsConfig.imagesCheckCertTrust;

  @override
  // TODO: implement quintoSlideQrCode
  String get quintoSlideQrCode => AssetsConfig.imagesCheckCertTrust;

  @override
  // TODO: implement segundoSlideDispositivo
  String get segundoSlideDispositivo => AssetsConfig.imagesSelecionarCertTrust;

  @override
  // TODO: implement segundoSlideQrCode
  String get segundoSlideQrCode => AssetsConfig.imagesUploadCertTrust;

  @override
  // TODO: implement terceiroSlideDispositivo
  String get terceiroSlideDispositivo => AssetsConfig.imagesProcurarCertTrust;

  @override
  // TODO: implement terceiroSlideQrCode
  String get terceiroSlideQrCode => AssetsConfig.imagesQrcodeCertTrust;

  @override
  // TODO: implement senhaCertificado
  String get senhaCertificado => AssetsConfig.imagesSenhaCertTrust;
}
