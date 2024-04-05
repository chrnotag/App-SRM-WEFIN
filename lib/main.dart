import 'dart:async';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:Srm_Asset/flavors.dart';

FutureOr<void> main() async {
  FlavorConfig flavorConfig = FlavorConfig();
  Ambiente ambienteSelecionado = Ambiente.values.firstWhere((ambiente) => ambiente.name == flavorConfig.name, orElse: () => Ambiente.SRM_HOMOLOGACAO);
  Environment environment = ambienteSelecionado.getEnvironment;
  runApp(const App());
}