import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/carteira_aberto/carteira_aberto_provider.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/geral_carteira/geral_carteira_impl.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/prazo_liquidez/prazo_liquidez_provider.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/recebiveis/recebiveis_provider.dart';
import 'package:Srm_Asset/models/carteira_consolidada/geral_carteira/geral_carteira_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../views/carteira_consolidada/utils/dados_grafico_model.dart';

class GeralCarteiraProvider extends ChangeNotifier {
  GeralCarteiraModel? _dadosGeralCarteira;

  GeralCarteiraModel? get dadosGeralCarteira => _dadosGeralCarteira;

  set dadosGeralCarteira(GeralCarteiraModel? dados) {
    _dadosGeralCarteira = dados;
  }

  Future<ApiResponse<dynamic>>? _futureGrafico;

  Future<ApiResponse<dynamic>>? get futureGrafico => _futureGrafico;

  set futureGrafico(Future<ApiResponse<dynamic>>? dados) {
    _futureGrafico = dados;
  }

  Future<void> carregarDados() async {
    futureGrafico = GeralCarteiraImpl.pegarGeralCarteira();
  }

  List<DadosGraficoModel> get dadosGraficoModel => [
        DadosGraficoModel(
            titulo: 'Vencidos',
            cor: const Color(0xffE62524),
            valor: dadosGeralCarteira!.valorTotalRecebiveisVencidos.toDouble(),
            porcentagem: _calcular(
                dadosGeralCarteira!.valorTotalRecebiveisVencidos.toDouble(),
                dadosGeralCarteira!),
            qtdTitulos: dadosGeralCarteira!.quantidadeTotalRecebiveisVencidos),
        DadosGraficoModel(
            titulo: 'A Vencer',
            cor: const Color(0xff00A3FF),
            valor: dadosGeralCarteira!.valorTotalRecebiveisAVencer.toDouble(),
            porcentagem: _calcular(
                dadosGeralCarteira!.valorTotalRecebiveisAVencer.toDouble(),
                dadosGeralCarteira!),
            qtdTitulos: dadosGeralCarteira!.quantidadeTotalRecebiveisAVencer),
        DadosGraficoModel(
            titulo: 'Em Aberto',
            cor: Colors.yellow,
            valor: dadosGeralCarteira!.valorTotalRecebiveisEmAberto.toDouble(),
            porcentagem: _calcular(
                dadosGeralCarteira!.valorTotalRecebiveisEmAberto.toDouble(),
                dadosGeralCarteira!),
            qtdTitulos: dadosGeralCarteira!.quantidadeTotalRecebiveis),
        DadosGraficoModel(
            titulo: 'Liquidados',
            cor: const Color(0xff3FE225),
            valor:
                dadosGeralCarteira!.valorTotalRecebiveisLiquidados.toDouble(),
            porcentagem: _calcular(
                dadosGeralCarteira!.valorTotalRecebiveisLiquidados.toDouble(),
                dadosGeralCarteira!),
            qtdTitulos:
                dadosGeralCarteira!.quantidadeTotalRecebiveisLiquidados),
      ].where((item) => item.valor > 0).toList();

  void limparDados() {
    dadosGeralCarteira = null;
    futureGrafico = null;
  }

  static String _calcular(double valor, GeralCarteiraModel dadosCarteira) {
    double valorTotal = 0;
    valorTotal = dadosCarteira.valorTotalRecebiveisVencidos +
        dadosCarteira.valorTotalRecebiveisLiquidados +
        dadosCarteira.valorTotalRecebiveisEmAberto +
        dadosCarteira.valorTotalRecebiveisAVencer;

    if (valorTotal == 0) {
      return 0.toPercent;
    }

    return ((valor / valorTotal) * 100).toPercent;
  }
}
