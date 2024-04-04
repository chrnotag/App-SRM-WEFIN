import 'package:Srm_Asset/core/constants/classes_abstratas/abstract_endpoint.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/environment/homologacao/trust/contatos.dart';
import 'package:Srm_Asset/core/constants/environment/homologacao/trust/endpoints.dart';
import 'package:Srm_Asset/core/constants/environment/homologacao/trust/tema.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/enuns/plataforma_enum.dart';

class TrustHomologacaoEnvironment extends Environment {
  const TrustHomologacaoEnvironment();
  @override
  Endpoint get endpoints => EndPoints();

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
  Contatos get contatos => Contatos();
}
