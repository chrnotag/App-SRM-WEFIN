import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/imagens_guia_certificado.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import '../configs_tema/export_config_theme_srm.dart';
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
                GoogleFonts.inter(
                    fontSize: AppSizes().bodyMedium,
                    color: TRUSTColors.textLabelColor)),
            textStyle:
                MaterialStateProperty.all<TextStyle>(GoogleFonts.inter(
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
          bodySmall: GoogleFonts.inter(fontSize: AppSizes().bodySmall),
          bodyMedium: GoogleFonts.inter(
              fontSize: AppSizes().bodyMedium, color: Colors.black),
          bodyLarge: GoogleFonts.inter(fontSize: AppSizes().bodyLarge, color: TRUSTColors.textLabelColor),
          labelMedium: GoogleFonts.inter(
              fontSize: AppSizes().labelMedium, color: TRUSTColors.textLabelColor),
          displaySmall:
              GoogleFonts.inter(fontSize: AppSizes().displaySmall),
          displayMedium:
              GoogleFonts.inter(fontSize: AppSizes().displayMedium),
        ),
      );

  static String get logo => AssetsConfig.imagesLogoTrust;

  static String get logoAppBar => AssetsConfig.imagesIconeTrust;

  static Widget get imagemAjuda => Image.asset(AssetsConfig.trustWhatsapp,
      width: 176.w, color: TRUSTColors.primaryColor);

  @override
  // TODO: implement primeiroSlideDispositivo
  String get primeiroSlideDispositivo => AssetsConfig.trustDocumentCertTrust;

  @override
  // TODO: implement primeiroSlideQrCode
  String get primeiroSlideQrCode => AssetsConfig.trustDocumentCertTrust;

  @override
  // TODO: implement quartoSlideDispositivo
  String get quartoSlideDispositivo  => AssetsConfig.trustSenhaSlideCertTrust;

  @override
  // TODO: implement quartoSlideQrCode
  String get quartoSlideQrCode => AssetsConfig.trustSenhaSlideCertTrust;

  @override
  // TODO: implement quintoSlideDispositivo
  String get quintoSlideDispositivo => AssetsConfig.trustCheckCertTrust;

  @override
  // TODO: implement quintoSlideQrCode
  String get quintoSlideQrCode => AssetsConfig.trustCheckCertTrust;

  @override
  // TODO: implement segundoSlideDispositivo
  String get segundoSlideDispositivo => AssetsConfig.trustSelecionarCertTrust;

  @override
  // TODO: implement segundoSlideQrCode
  String get segundoSlideQrCode => AssetsConfig.trustUploadCertTrust;

  @override
  // TODO: implement terceiroSlideDispositivo
  String get terceiroSlideDispositivo => AssetsConfig.trustProcurarCertTrust;

  @override
  // TODO: implement terceiroSlideQrCode
  String get terceiroSlideQrCode => AssetsConfig.trustQrcodeCertTrust;

  @override
  // TODO: implement senhaCertificado
  String get senhaCertificado => AssetsConfig.trustSenhaCertTrust;

  @override
  // TODO: implement alerta_icone
  String get alerta_icone => AssetsConfig.trustAlertIconTrust;

  @override
  // TODO: implement check_icone
  String get check_icone => AssetsConfig.trustCheckTrustIcon;

  @override
  // TODO: implement ted_menu_icone
  String get ted_menu_icone => AssetsConfig.trustTed;

}