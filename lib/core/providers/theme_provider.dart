import 'package:Srm_Asset/core/constants/enuns/ambiente.dart';
import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/constants/enuns/theme_enum.dart';
import 'package:Srm_Asset/core/constants/environment/homologacao/srm/tema.dart';
import 'package:Srm_Asset/core/constants/environment/homologacao/trust/tema.dart';
import '../../generated/assets.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider._();

  static final _instance = ThemeProvider._();

  factory ThemeProvider() => _instance;

  //Trocar entre homol e prod aqui.
  Ambiente _ambienteSelecionado = Ambiente.Homologacao;

  Ambiente get ambienteSelecionado => _ambienteSelecionado;

  TemaSelecionado _temaSelecionado = TemaSelecionado.TRUST;

  ThemeData get temaAtual => _temaSelecionado == TemaSelecionado.SRM ? ThemeSRM.theme : ThemeTRUST.theme;

  TemaSelecionado get temaSelecionado => _temaSelecionado;

  set temaSelecionado(TemaSelecionado tema) {
    _temaSelecionado = tema;
    notifyListeners();
  }

  bool get isTemaSRM => temaSelecionado == TemaSelecionado.SRM;

  String get logoTema => isTemaSRM ? Assets.logoSRM : Assets.logoTRUST;
  String get logoTemaAppBar => isTemaSRM ? Assets.logoSRM : Assets.logoTRUSTAppBar;
}