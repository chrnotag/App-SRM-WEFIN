import 'package:Srm_Asset/core/constants/classes_abstratas/abstract_endpoint.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/imagens_guia_certificado.dart';
import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/enuns/plataforma_enum.dart';
import 'package:Srm_Asset/core/constants/environment/homologacao/srm/contatos.dart';
import 'package:Srm_Asset/core/constants/environment/homologacao/srm/endpoints.dart';
import 'package:Srm_Asset/core/constants/environment/tema_srm.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:flutter/material.dart';

import '../../../assets_config/assets_config.dart';

class SrmHomologacaoEnvironment extends Environment {
  const SrmHomologacaoEnvironment();

  @override
  Endpoint get endpoints => EndPointsSRM();

  @override
  ThemeData get tema => ThemeSRM.theme;

  @override
  // TODO: implement logo
  String get logo => ThemeSRM.logo;

  @override
  // TODO: implement logoAppBar
  String get logoAppBar => ThemeSRM.logoAppBar;

  @override
  // TODO: implement plataforma
  Plataforma get plataforma => Plataforma.SRM;

  @override
  // TODO: implement imagemAjuda
  Widget get imagemAjuda => ThemeSRM.imagemAjuda;

  @override
  // TODO: implement contatos
  ContatosSRM get contatos => ContatosSRM();

  @override
  // TODO: implement iconColor
  Color? get IconColor => null;

  @override
  // TODO: implement corQuadradoLogin
  Color? get corQuadradoLogin => Colors.transparent;

  @override
  Color? get corImagemLogo => SRMColors.secondaryColor;

  @override
  Color? get corTextoSlogan => TRUSTColors.primaryColor;

  @override
  // TODO: implement fraseSloganLogin
  String get fraseSloganLogin => 'Capital em Movimento';

  @override
  // TODO: implement imagensGuiaCertificado
  ImagensGuiaImportarCertificado get imagensGuiaCertificado => ThemeSRM();

  @override
  // TODO: implement alerta_icone
  String get alerta_icone => AssetsConfig.imagesAlertIconSrm;

  @override
  // TODO: implement check_icone
  String get check_icone => AssetsConfig.imagesCheckSrmIcon;

  @override
  // TODO: implement ted_menu_icone
  String get ted_menu_icone => AssetsConfig.imagesTedTerceirosSrm;

}
