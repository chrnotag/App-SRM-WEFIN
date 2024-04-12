import 'package:Srm_Asset/core/constants/classes_abstratas/abstract_endpoint.dart';
import 'package:Srm_Asset/core/constants/enuns/plataforma_enum.dart';
import 'package:Srm_Asset/core/constants/environment/homologacao/srm/contatos.dart';
import 'package:Srm_Asset/core/constants/environment/homologacao/srm/endpoints.dart';
import 'package:Srm_Asset/core/constants/environment/homologacao/srm/tema.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:flutter/material.dart';

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
  Color get azulOuPreto => ThemeSRM.azulOuPreto;

  @override
  Color get brancoOuVerde => ThemeSRM.brancoOuVerde;

  @override
  Color get verdeOuCinza => ThemeSRM.verdeOuCinza;

  @override
  Color get laranjaOuCinza => ThemeSRM.verdeOuCinza;
}
