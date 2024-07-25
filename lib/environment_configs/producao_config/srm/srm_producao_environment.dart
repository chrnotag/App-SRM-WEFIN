import 'package:Srm_Asset/core/constants/classes_abstratas/abstract_endpoint.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/contatos_abstract.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/environment/producao/srm/contatos.dart';
import 'package:Srm_Asset/core/constants/environment/producao/srm/endpoints.dart';
import 'package:Srm_Asset/core/constants/environment/tema_srm.dart';
import 'package:flutter/material.dart';

import '../../../assets_config/assets_config.dart';
import '../../../core/constants/classes_abstratas/imagens_guia_certificado.dart';
import '../../../core/constants/enuns/plataforma_enum.dart';

class SrmProducaoEnvironment extends Environment {
  const SrmProducaoEnvironment();
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
  ContatosAbstract get contatos => ContatosSRM();

  @override
  // TODO: implement iconColor
  Color? get IconColor => null;

  @override
  // TODO: implement corQuadradoLogin
  Color? get corQuadradoLogin => Colors.transparent;

  @override
  // TODO: implement fraseSloganLogin
  String get fraseSloganLogin => 'Capital em Movimento';

  @override
  Color? get corTextoSlogan => SRMColors.primaryColor;

  @override
  Color? get corImagemLogo => SRMColors.secondaryColor;

  @override
  // TODO: implement imagensGuiaCertificado
  ImagensGuiaImportarCertificado get imagensGuiaCertificado => ThemeSRM();

  @override
  // TODO: implement alerta_icone
  String get alerta_icone => AssetsConfig.srmAlertIconSrm;

  @override
  // TODO: implement check_icone
  String get check_icone => AssetsConfig.srmCheckSrmIcon;

  @override
  // TODO: implement ted_menu_icone
  String get ted_menu_icone => AssetsConfig.srmTed;


  @override
  // TODO: implement extratoIcone
  String get extratoIcone => AssetsConfig.srmExtrato;

  @override
  // TODO: implement faleConoscoIcone
  String get faleConoscoIcone => AssetsConfig.srmWhatsapp;

  @override
  // TODO: implement grupoEconomicoIcone
  String get grupoEconomicoIcone => AssetsConfig.srmGrupo;

  @override
  // TODO: implement monitorOperacoesIcone
  String get monitorOperacoesIcone => AssetsConfig.srmGrafico;

  @override
  // TODO: implement tedTerceirosIcone
  String get tedTerceirosIcone => AssetsConfig.srmTed;

  @override
  // TODO: implement transferenciasIcone
  String get transferenciasIcone => AssetsConfig.srmTransferencia;

  String get imagemEmpresa => AssetsConfig.srmMaletaPerfil;

}
