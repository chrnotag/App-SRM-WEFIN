import 'package:Srm_Asset/core/constants/classes_abstratas/abstract_endpoint.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/contatos_abstract.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/environment/producao/trust/contatos.dart';
import 'package:Srm_Asset/core/constants/environment/producao/trust/endpoints.dart';
import 'package:Srm_Asset/core/constants/environment/tema_trust.dart';
import 'package:flutter/material.dart';
import '../../../assets_config/assets_config.dart';
import '../../../core/constants/classes_abstratas/imagens_guia_certificado.dart';
import '../../../core/constants/enuns/plataforma_enum.dart';

class TrustProducaoEnvironment extends Environment {
  const TrustProducaoEnvironment();
  @override
  Endpoint get endpoints => EndPointsTRUST();

  @override
  ThemeData get tema => ThemeTRUST.theme;

  @override
  // TODO: implement logo
  String get logo => ThemeTRUST.logo;

  @override
  // TODO: implement logoAppBar
  String get logoAppBar => ThemeTRUST.logoAppBar;

  @override
  // TODO: implement plataforma
  Plataforma get plataforma => Plataforma.TRUST;

  @override
  // TODO: implement imagemAjuda
  Widget get imagemAjuda => ThemeTRUST.imagemAjuda;

  @override
  // TODO: implement contatos
  ContatosAbstract get contatos => ContatosTRUST();

  @override
  // TODO: implement iconColor
  Color? get IconColor => TRUSTColors.primaryColor;

  @override
  // TODO: implement corQuadradoLogin
  Color? get corQuadradoLogin => TRUSTColors.primaryColor;

  @override
  // TODO: implement fraseSloganLogin
  String? get fraseSloganLogin => '';

  @override
  Color? get corTextoSlogan => Colors.white;

  @override
  Color? get corImagemLogo => Colors.white;

  @override
  // TODO: implement imagensGuiaCertificado
  ImagensGuiaImportarCertificado get imagensGuiaCertificado => ThemeTRUST();

  @override
  // TODO: implement alerta_icone
  String get alerta_icone => AssetsConfig.imagesAlertIconTrust;

  @override
  // TODO: implement check_icone
  String get check_icone => AssetsConfig.imagesCheckTrustIcon;

  @override
  // TODO: implement ted_menu_icone
  String get ted_menu_icone => AssetsConfig.imagesTedTerceiros;
}
