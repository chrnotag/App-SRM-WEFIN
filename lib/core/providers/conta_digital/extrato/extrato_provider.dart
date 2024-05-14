import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../models/conta_digital/extrato/conta_extrato_model.dart';

class ExtratoProvider extends ChangeNotifier {
  Future<ApiResponse<dynamic>> pegarExtratos(
          String numeroConta, String dataInicial, String dataFinal) =>
      ExtratoImpl.pegarExtrato(numeroConta, dataInicial, dataFinal);

  List<ContaExtratoModel> _extrato = [];

  List<ContaExtratoModel> get extrato => _extrato;

  set extrato(List<ContaExtratoModel> listaExtrato) {
    _extrato = listaExtrato;
    notifyListeners();
  }

  static final DateFormat mascaraData = DateFormat('yyyy-MM-dd');

  String _dataInicial = mascaraData.format(DateTime.now());

  String get dataInicial => _dataInicial;

  set dataInicial(String data) {
    _dataInicial = data;
    notifyListeners();
  }

  String _retornaDataFinal() =>
      mascaraData.format(DateTime.now().subtract(Duration(days: intervaloDias)));

  String _dataFinal = '';

  String get dataFinal => _retornaDataFinal();

  set dataFinal(String data) {
    _dataFinal = data;
    notifyListeners();
  }

  int _intervaloDias = 7;

  int get intervaloDias => _intervaloDias;

  set intervaloDias(int dias){
    _intervaloDias = dias;
    notifyListeners();
  }
}
