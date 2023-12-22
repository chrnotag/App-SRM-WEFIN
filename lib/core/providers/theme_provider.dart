import 'package:flutter/cupertino.dart';
import 'package:modular_study/core/constants/enuns/theme_enum.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider._();

  static final _instance = ThemeProvider._();

  factory ThemeProvider() => _instance;

  TemaSelecionado _temaSelecionado = TemaSelecionado.TRUST;

  TemaSelecionado get temaSelecionado => _temaSelecionado;

  set temaSelecionado(TemaSelecionado tema) {
    _temaSelecionado = tema;
    notifyListeners();
  }
}