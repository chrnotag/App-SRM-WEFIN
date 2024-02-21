import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/constants/enuns/theme_enum.dart';
import 'package:Srm_Asset/core/constants/themes/theme_srm.dart';
import 'package:Srm_Asset/core/constants/themes/theme_trust.dart';
import '../../generated/assets.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider._();

  static final _instance = ThemeProvider._();

  factory ThemeProvider() => _instance;

  TemaSelecionado _temaSelecionado = TemaSelecionado.SRM;

  ThemeData get temaAtual => _temaSelecionado == TemaSelecionado.SRM ? ThemeSRM.theme : ThemeTRUST.theme;

  TemaSelecionado get temaSelecionado => _temaSelecionado;

  set temaSelecionado(TemaSelecionado tema) {
    _temaSelecionado = tema;
    notifyListeners();
  }

  bool get isTemaSRM => temaSelecionado == TemaSelecionado.SRM;

  String get logoTema => isTemaSRM ? Assets.logoSRM : Assets.logoTRUST;
}