import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/geral_carteira/geral_carteira_impl.dart';
import 'package:Srm_Asset/core/utils/calcular_porcentagem_graficos.dart';
import 'package:Srm_Asset/models/carteira_consolidada/geral_carteira/geral_carteira_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    notifyListeners();
  }

  Future<void> carregarDados() async {
    futureGrafico = GeralCarteiraImpl.pegarGeralCarteira();
  }

  List<DadosGraficoModel> get dadosGraficoModel => [
    DadosGraficoModel(
        titulo: 'Vencidos',
        cor: Colors.red,
        valor: dadosGeralCarteira!.valorTotalRecebiveisVencidos.toDouble(),
        porcentagem: CalcularPorcentagemGraficos.calcular(
            dadosGeralCarteira!.valorTotalRecebiveisVencidos.toDouble(),
            dadosGeralCarteira!),
        qtdTitulos: dadosGeralCarteira!.quantidadeTotalRecebiveisVencidos),
    DadosGraficoModel(
        titulo: 'A Vencer',
        cor: Colors.yellow,
        valor: dadosGeralCarteira!.valorTotalRecebiveisAVencer.toDouble(),
        porcentagem: CalcularPorcentagemGraficos.calcular(
            dadosGeralCarteira!.valorTotalRecebiveisAVencer.toDouble(),
            dadosGeralCarteira!),
        qtdTitulos: dadosGeralCarteira!.quantidadeTotalRecebiveisAVencer),
    DadosGraficoModel(
        titulo: 'Em Aberto',
        cor: Colors.green,
        valor: dadosGeralCarteira!.valorTotalRecebiveisEmAberto.toDouble(),
        porcentagem: CalcularPorcentagemGraficos.calcular(
            dadosGeralCarteira!.valorTotalRecebiveisEmAberto.toDouble(),
            dadosGeralCarteira!),
        qtdTitulos: dadosGeralCarteira!.quantidadeTotalRecebiveis),
    DadosGraficoModel(
        titulo: 'Liquidados',
        cor: Colors.blue,
        valor: dadosGeralCarteira!.valorTotalRecebiveisLiquidados.toDouble(),
        porcentagem: CalcularPorcentagemGraficos.calcular(
            dadosGeralCarteira!.valorTotalRecebiveisLiquidados.toDouble(),
            dadosGeralCarteira!),
        qtdTitulos: dadosGeralCarteira!.quantidadeTotalRecebiveisLiquidados),
  ].where((item) => item.valor > 0).toList();

  void limparDados(){
    dadosGeralCarteira = null;
  }
}
