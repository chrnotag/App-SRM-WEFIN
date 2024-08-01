import 'dart:typed_data';

import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/carteira_aberto/carteira_aberto_provider.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/geral_carteira/geral_carteira_provider.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/prazo_liquidez/prazo_liquidez_provider.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/recebiveis/recebiveis_impl.dart';
import 'package:Srm_Asset/models/carteira_consolidada/recebiveis/recebiveis_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../views/carteira_consolidada/utils/dados_grafico_model.dart';
import '../../../implementations_config/api_response.dart';

class RecebiveisProvider extends ChangeNotifier {
  RecebiveisModel? _recebiveis;

  RecebiveisModel? get recebiveis => _recebiveis;

  set recebiveis(RecebiveisModel? dados) => _recebiveis = dados;

  Uint8List? _recebiveisDownload;

  Uint8List? get recebiveisDownload => _recebiveisDownload;

  set recebiveisDownload(Uint8List? dados) => _recebiveisDownload = dados;

  Future<ApiResponse<dynamic>>? _recebiveisFuture;

  Future<ApiResponse<dynamic>>? get recebiveisFuture => _recebiveisFuture;

  set recebiveisFuture(Future<ApiResponse<dynamic>>? dados) =>
      _recebiveisFuture = dados;

  Future<void> carregarDados() async {
    Modular.get<GeralCarteiraProvider>().carregarDados();
    Modular.get<PrazoLiquidezProvider>().carregarDados();
    Modular.get<CarteiraAbertoProvider>().carregarDados();
    recebiveisFuture = RecebiveisImpl.pegarDados();
  }

  void limparDados() {
    recebiveisFuture = null;
    recebiveis = null;
    recebiveisDownload = null;
  }

  Uint8List? _pdfRecebiveis;

  Uint8List? get pdfRecebiveis => _pdfRecebiveis;

  set pdfRecebiveis(Uint8List? dados) => _pdfRecebiveis = dados;

  List<DadosGraficoModel> dadosGrafico() {
    List<DadosGraficoModel> dados = [];
    if (recebiveis != null) {
      for (var nota in recebiveis!.recebiveis) {
        dados.add(
          DadosGraficoModel(
              titulo: nota.sigla,
              cor: Color(int.parse(nota.corProduto)),
              valor: nota.saldoDevedor,
              porcentagem: _calcular(nota.saldoDevedor)),
        );
      }
    }
    return dados;
  }

  String _calcular(double? valor) {
    double valorTotal = 0;
    if (recebiveis != null) {
      for (var dado in recebiveis!.recebiveis) {
        valorTotal += dado.saldoDevedor;
      }
    }
    if (valorTotal == 0 || valor == null) {
      return 0.toPercent;
    }

    return ((valor / valorTotal) * 100).toPercent;
  }
}
