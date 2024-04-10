import 'package:Srm_Asset/core/constants/classes_abstratas/abstract_endpoint.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/contatos_abstract.dart';
import 'package:flutter/material.dart';
import '../enuns/plataforma_enum.dart';
import '../environment/homologacao/srm/contatos.dart';

abstract class Environment {
  const Environment();
  ThemeData get tema;
  Endpoint get endpoints;
  String get logo;
  String get logoAppBar;
  Plataforma get plataforma;
  Widget get imagemAjuda;
  ContatosAbstract get contatos;
}