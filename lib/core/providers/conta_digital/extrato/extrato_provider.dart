import 'dart:typed_data';
import 'package:Srm_Asset/core/constants/extensions/date_extensions.dart';
import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import '../../../../models/conta_digital/extrato/conta_extrato_model.dart';
import '../../../utils/data_format.dart';

class ExtratoProvider extends ChangeNotifier {
  ContaExtratoModel? _extrato;

  ContaExtratoModel? get extrato => _extrato;

  set extrato(ContaExtratoModel? listaExtrato) {
    _extrato = listaExtrato;
    notifyListeners();
  }

  Uint8List? _extratoDownloadBites;

  Uint8List? get extratoDownloadBites => _extratoDownloadBites;

  set extratoDownloadBites(Uint8List? bites) {
    _extratoDownloadBites = bites;
    notifyListeners();
  }

  List<Item> get itensExtrato => extrato!.itens.reversed.toList();

  DateTime _dataInicial = DateTime.now();

  DateTime get dataInicial => _dataInicial;

  set dataInicial(DateTime data) {
    _dataInicial = data;
    notifyListeners();
  }

  DateTime? _dataFinal;

  DateTime? get dataFinal => _dataFinal;

  set dataFinal(DateTime? data) => _dataFinal = data;

  // String _retornaDataFinal() =>
  //     mascaraData.format(DateTime.now().subtract(Duration(days: intervaloDias)));

  DateTime dataFinalFiltro() =>
      dataInicial.subtract(Duration(days: intervaloDias));

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
  }

  Future<ApiResponse<dynamic>>? _downloadExtratoFuture;

  Future<ApiResponse<dynamic>>? get downloadExtratoFuture =>
      _downloadExtratoFuture;

  set downloadExtratoFuture(Future<ApiResponse<dynamic>>? extrato) {
    _downloadExtratoFuture = extrato;
  }

  Future<void> carregarDados() async {
    final contaDigitalProvider = Modular.get<ContaDigitalProvider>();
    extratoFuture = ExtratoImpl(tipoConsulta: TipoConsultaExtrato.VISUALIZAR)
        .pegarExtrato(
            contaDigitalProvider.dadosContaDigital!.conta,
            (dataFinal ?? dataFinalFiltro()).formatarIso8601,
            dataInicial.formatarIso8601);
  }

  Future<void> baixarDados() async {
    final contaDigitalProvider = Modular.get<ContaDigitalProvider>();
    downloadExtratoFuture =
        ExtratoImpl(tipoConsulta: TipoConsultaExtrato.BAIXAR).pegarExtrato(
            contaDigitalProvider.dadosContaDigital!.conta,
            dataFinalFiltro().formatarIso8601,
            dataInicial.formatarIso8601);
  }

  Future<void> baixarDadosPeriodo() async {
    final contaDigitalProvider = Modular.get<ContaDigitalProvider>();
    await const ExtratoImpl(tipoConsulta: TipoConsultaExtrato.BAIXAR)
        .pegarExtrato(contaDigitalProvider.dadosContaDigital!.conta,
            dataFinal!.formatarIso8601, dataInicial.formatarIso8601);
  }

  void limparDados() {
    dataInicial = DateTime.now();
    intervaloDias = 7;
    extratoFuture = null;
  }
}
