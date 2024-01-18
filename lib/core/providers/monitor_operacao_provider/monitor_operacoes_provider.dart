import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/providers/monitor_operacao_provider/monitor_operacao_impl.dart';

import '../../../models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import '../../../models/monitor_operacoes_model/monitor_operacoes_model.dart';
import '../../utils/money_format.dart';

class MonitorOperacoesProvider extends ChangeNotifier{

  List<MonitorOperacoesModel> _operacoes = [];

  List<MonitorOperacoesModel> get operacoes => _operacoes;

  set operacoes(List<MonitorOperacoesModel> data) {
    _operacoes = data;
    notifyListeners();
  }

  Future<void> carregarOperacoes() => MonitorOperacaoImpl().carregarOperacoes();

  void aconragemAssinatura(List<MonitorAssinaturasModel> lista, int codigoBuscado) {
    int index = lista.indexWhere((element) => element.codigoOperacao == codigoBuscado);

    if (index != -1) {
      MonitorAssinaturasModel elementoEncontrado = lista.removeAt(index);
      lista.insert(0, elementoEncontrado);
      final AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();
      assinaturaProvider.todasAssinaturas = lista;
    }
  }

}