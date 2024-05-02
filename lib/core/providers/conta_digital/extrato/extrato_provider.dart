import 'package:flutter/cupertino.dart';

import '../../../../models/conta_digital/extrato/conta_extrato_model.dart';

class ExtratoProvider extends ChangeNotifier{

  List<ContaExtratoModel> _extrato = [];

  List<ContaExtratoModel> get extrato => _extrato;

  set extrato(List<ContaExtratoModel> listaExtrato){
    _extrato = listaExtrato;
    notifyListeners();
  }

}