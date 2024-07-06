import 'package:Srm_Asset/core/constants/classes_abstratas/abstract_endpoint.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/contatos_abstract.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/imagens_guia_certificado.dart';
import 'package:flutter/material.dart';
import '../enuns/plataforma_enum.dart';

abstract class Environment {
  const Environment();

  ThemeData get tema;

  Endpoint get endpoints;

  String get logo;

  String get logoAppBar;

  Plataforma get plataforma;

  Widget get imagemAjuda;

  ContatosAbstract get contatos;

  Color? get IconColor;

  Color? get corQuadradoLogin;

  Color? get corTextoSlogan;

  Color? get corImagemLogo;

  String? get fraseSloganLogin;

  ImagensGuiaImportarCertificado get imagensGuiaCertificado;

  String get alerta_icone;

  String get check_icone;

  String get ted_menu_icone;

  String get monitorOperacoesIcone;

  String get transferenciasIcone;

  String get extratoIcone;

  String get tedTerceirosIcone;

  String? get grupoEconomicoIcone;

  String get faleConoscoIcone;

  String get imagemEmpresa;
}
