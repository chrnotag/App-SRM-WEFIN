import 'package:Srm_Asset/core/constants/classes_abstratas/abstract_endpoint.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/contatos_abstract.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/environment/producao/srm/contatos.dart';
import 'package:Srm_Asset/core/constants/environment/producao/srm/endpoints.dart';
import 'package:Srm_Asset/core/constants/environment/tema_srm.dart';
import 'package:Srm_Asset/core/constants/tema_configs.dart';
import 'package:flutter/material.dart';

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
  Color get azulOuPreto => ThemeSRM.azulOuPreto;

  @override
  Color get brancoOuVerde => ThemeSRM.brancoOuVerde;

  @override
  Color get verdeOuCinza => ThemeSRM.verdeOuCinza;

  @override
  Color get laranjaOuCinza => ThemeSRM.verdeOuCinza;

  @override
  // TODO: implement trustIconColor
  Color? get IconColor => null;

  @override
  // TODO: implement corQuadradoLogin
  Color? get corQuadradoLogin => Colors.transparent;

  @override
  // TODO: implement fraseSloganLogin
  String get fraseSloganLogin => 'Capital em Movimento';

  @override
  Color? get corTextoSlogan => AppColors.laranjaSRM;

  @override
  Color? get corImagemLogo => AppColors.azul;
}
