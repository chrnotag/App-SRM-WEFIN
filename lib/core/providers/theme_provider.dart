import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modular_study/core/constants/enuns/theme_enum.dart';
import 'package:modular_study/core/constants/themes/theme_srm.dart';
import 'package:modular_study/core/constants/themes/theme_trust.dart';

import '../../generated/assets.dart';
import '../constants/themes/theme_configs.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider._();

  static final _instance = ThemeProvider._();

  factory ThemeProvider() => _instance;

  TemaSelecionado _temaSelecionado = TemaSelecionado.TRUST;

  ThemeData get temaAtual => _temaSelecionado == TemaSelecionado.SRM ? ThemeSRM.theme : ThemeTRUST.theme;

  TemaSelecionado get temaSelecionado => _temaSelecionado;

  set temaSelecionado(TemaSelecionado tema) {
    _temaSelecionado = tema;
    notifyListeners();
  }

  bool get isTemaSRM => temaSelecionado == TemaSelecionado.SRM;

  String get logoTema => isTemaSRM ? Assets.logoSRM : Assets.logoTRUST;
}