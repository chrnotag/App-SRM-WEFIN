import 'dart:typed_data';

import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/recebiveis/recebiveis_impl.dart';
import 'package:Srm_Asset/models/carteira_consolidada/recebiveis/recebiveis_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    recebiveisFuture = RecebiveisImpl.pegarDados();
  }

  List<DadosGraficoModel> dadosGrafico() {
    // Definindo o mapa de cores para cada sigla
    Map<String, Color> siglaToColor = {
      'DUP': Color(0xFFFF0000),
      'GARKGCP': Color(0xFFFF9E01),
      'SACADO': Color(0xFFFCD202),
      'COBRANÇA': Color(0xFFF8FF01),
    };

    List<DadosGraficoModel> dados = [];

    // Iterando sobre a lista de recebíveis
    for (var nota in recebiveis!.recebiveis) {
      Color cor = siglaToColor[nota.sigla.toUpperCase()] ?? Colors.black;
      dados.add(
        DadosGraficoModel(
            titulo: nota.sigla,
            cor: cor,
            valor: nota.saldoDevedor,
            porcentagem: _calcular(nota.saldoDevedor)),
      );
    }

    return dados;
  }

  String _calcular(double valor) {
    double valorTotal = 0;
    for (var dado in recebiveis!.recebiveis) {
      valorTotal += dado.saldoDevedor;
    }
    if (valorTotal == 0) {
      return 0.toPercent;
    }

    return ((valor / valorTotal) * 100).toPercent;
  }
}
