import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabMesesProvider with ChangeNotifier {
  DateTime _dataAtual = DateTime.now();

  static List<String> nomesDosMeses = [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez'
  ];

  List<String> get nomeDosMeses {
    return [
      nomesDosMeses[DateTime(_dataAtual.year, _dataAtual.month - 2).month - 1],
      nomesDosMeses[DateTime(_dataAtual.year, _dataAtual.month - 1).month - 1],
      nomesDosMeses[_dataAtual.month - 1]
    ];
  }

  List<DateTime> get meses {
    return [
      DateTime(DateTime(_dataAtual.year, _dataAtual.month - 2).month - 1),
      DateTime(DateTime(_dataAtual.year, _dataAtual.month - 1).month - 1),
      DateTime(_dataAtual.month - 1)
    ];
  }

  void atualizarData() {
    _dataAtual = DateTime.now();
    notifyListeners();
  }
}
