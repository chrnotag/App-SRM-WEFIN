import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/carteira_aberto/carteira_aberto_impl.dart';
import 'package:Srm_Asset/models/carteira_consolidada/carteira_aberto/carteira_aberto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../views/carteira_consolidada/utils/dados_grafico_model.dart';
import '../../../implementations_config/api_response.dart';

class CarteiraAbertoProvider extends ChangeNotifier {
  CarteiraAbertoModel? _dadosCarteira;

  CarteiraAbertoModel? get dadosCarteira => _dadosCarteira;

  set dadosCarteira(CarteiraAbertoModel? dados) => _dadosCarteira = dados;

  Future<ApiResponse<dynamic>>? _futureGrafico;

  Future<ApiResponse<dynamic>>? get futureGrafico => _futureGrafico;

  set futureGrafico(Future<ApiResponse<dynamic>>? dados) {
    _futureGrafico = dados;
  }

  Future<void> carregarDados() async {
    futureGrafico = CarteiraAbertoImpl.pegarCarteiraAberto();
  }

  List<DadosGraficoModel> get dadosGrafico => [
        DadosGraficoModel(
            titulo: 'Vencidos',
            cor: const Color(0xffE62524),
            valor: dadosCarteira!.valorTotalRecebiveisVencidos.toDouble(),
            porcentagem: _calcular(
                dadosCarteira!.valorTotalRecebiveisVencidos.toDouble(),
                dadosCarteira!),
            qtdTitulos: dadosCarteira!.quantidadeTotalRecebiveisVencidos),
        DadosGraficoModel(
            titulo: 'A Vencer',
            cor: const Color(0xff00A3FF),
            valor: dadosCarteira!.valorTotalRecebiveisAVencer.toDouble(),
            porcentagem: _calcular(
                dadosCarteira!.valorTotalRecebiveisAVencer.toDouble(),
                dadosCarteira!),
            qtdTitulos: dadosCarteira!.quantidadeTotalRecebiveisAVencer),
      ];

  static String _calcular(double valor, CarteiraAbertoModel dadosCarteira) {
    double valorTotal = 0;
    valorTotal = dadosCarteira.valorTotalRecebiveisEmAberto;

    if (valorTotal == 0) {
      return 0.toPercent;
    }

    return ((valor / valorTotal) * 100).toPercent;
  }

  void limparDados() {
    dadosCarteira = null;
  }
}
