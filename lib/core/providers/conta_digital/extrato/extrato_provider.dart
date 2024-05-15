import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../models/conta_digital/extrato/conta_extrato_model.dart';
import '../../../utils/data_format.dart';

class ExtratoProvider extends ChangeNotifier {
  ContaExtratoModel? _extrato;

  ContaExtratoModel? get extrato => _extrato;

  set extrato(ContaExtratoModel? listaExtrato) {
    _extrato = listaExtrato;
    notifyListeners();
  }

  List<Item> get itensExtrato => extrato!.itens.reversed.toList();

  DateTime _dataInicial = DateTime.now();

  DateTime get dataInicial => _dataInicial;

  set dataInicial(DateTime data) {
    _dataInicial = data;
    notifyListeners();
  }

  // String _retornaDataFinal() =>
  //     mascaraData.format(DateTime.now().subtract(Duration(days: intervaloDias)));

  DateTime dataFinal() => dataInicial.subtract(Duration(days: intervaloDias));

  int _intervaloDias = 7;

  int get intervaloDias => _intervaloDias;

  set intervaloDias(int dias) {
    _intervaloDias = dias;
    notifyListeners();
  }

  Future<ApiResponse<dynamic>>? _extratoFuture;

  Future<ApiResponse<dynamic>>? get extratoFuture => _extratoFuture;

  set extratoFuture(Future<ApiResponse<dynamic>>? extrato) {
    _extratoFuture = extrato;
    notifyListeners();
  }

  Future<void> carregarDados() async {
    final contaDigitalProvider = Modular.get<ContaDigitalProvider>();
    extratoFuture = ExtratoImpl.pegarExtrato(
        contaDigitalProvider.dadosContaDigital!.conta,
        FormatarData.formatar(dataFinal().toIso8601String()),
        FormatarData.formatar(dataInicial.toIso8601String()));
  }
}
