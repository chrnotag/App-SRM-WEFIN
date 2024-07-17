import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/prazo_liquidez/prazo_liquidez_impl.dart';
import 'package:Srm_Asset/models/carteira_consolidada/prazo_liquidez/prazo_liquidez_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../views/carteira_consolidada/utils/dados_grafico_model.dart';
import '../../../implementations_config/api_response.dart';

class PrazoLiquidezProvider extends ChangeNotifier {
  PrazoLiquidezModel? _dadosCarteira;

  PrazoLiquidezModel? get dadosLiquidez => _dadosCarteira;

  set dadosLiquidez(PrazoLiquidezModel? dados) => _dadosCarteira = dados;

  Future<ApiResponse<dynamic>>? _futureGrafico;

  Future<ApiResponse<dynamic>>? get futureGrafico => _futureGrafico;

  set futureGrafico(Future<ApiResponse<dynamic>>? dados) {
    _futureGrafico = dados;
  }

  Future<void> carregarDados() async {
    futureGrafico = PrazoLiquidezImpl.pegarDados();
  }

  List<DadosGraficoModel> get dadosGrafico => [
        DadosGraficoModel(
            titulo: 'Pagas antes do vencimento',
            cor: const Color(0xff00A3FF),
            valor: dadosLiquidez
                ?.valorTotalRecebiveisLiquidadosAntesDoVencimento
                .toDouble(),
            porcentagem: _calcular(
                dadosLiquidez?.valorTotalRecebiveisLiquidadosAntesDoVencimento
                    .toDouble(),
                dadosLiquidez),
            qtdTitulos: dadosLiquidez
                ?.quantidadeTotalRecebiveisLiquidadosAntesVencimento),
        DadosGraficoModel(
            titulo: 'Pagas no vencimento',
            cor: const Color(0xff3FE225),
            valor:
                dadosLiquidez?.valorTotalRecebiveisLiquidadosNoDia.toDouble(),
            porcentagem: _calcular(
                dadosLiquidez?.valorTotalRecebiveisLiquidadosNoDia.toDouble(),
                dadosLiquidez),
            qtdTitulos:
                dadosLiquidez?.quantidadeTotalRecebiveisLiquidadosNoDia),
        DadosGraficoModel(
            titulo: 'Pagas 7 dias depois do vencimento',
            cor: const Color(0xffFC850A),
            valor:
                dadosLiquidez?.valorTotalRecebiveisLiquidados7Dias.toDouble(),
            porcentagem: _calcular(
                dadosLiquidez?.valorTotalRecebiveisLiquidados7Dias.toDouble(),
                dadosLiquidez),
            qtdTitulos:
                dadosLiquidez?.quantidadeTotalRecebiveisLiquidados7Dias),
        DadosGraficoModel(
            titulo: 'Pagas 15 dias depois do vencimento',
            cor: const Color(0xffE62524),
            valor:
                dadosLiquidez?.valorTotalRecebiveisLiquidados15Dias.toDouble(),
            porcentagem: _calcular(
                dadosLiquidez?.valorTotalRecebiveisLiquidados15Dias.toDouble(),
                dadosLiquidez),
            qtdTitulos:
                dadosLiquidez?.quantidadeTotalRecebiveisLiquidados15Dias),
        DadosGraficoModel(
            titulo: 'Pagas com 30 dias ou mais depois do vencimento',
            cor: const Color(0xffA61110),
            valor:
                ((dadosLiquidez?.valorTotalRecebiveisLiquidados30Dias ??
                            0) +
                        (dadosLiquidez
                                ?.valorTotalRecebiveisLiquidados45Dias ??
                            0) +
                        (dadosLiquidez
                                ?.valorTotalRecebiveisLiquidados60Dias ??
                            0) +
                        (dadosLiquidez
                                ?.valorTotalRecebiveisLiquidados90Dias ??
                            0) +
                        (dadosLiquidez
                                ?.valorTotalRecebiveisLiquidadosMaisDe90Dias ??
                            0))
                    .toDouble(),
            porcentagem: _calcular(
                ((dadosLiquidez
                                ?.valorTotalRecebiveisLiquidados30Dias ??
                            0) +
                        (dadosLiquidez?.valorTotalRecebiveisLiquidados45Dias ??
                            0) +
                        (dadosLiquidez?.valorTotalRecebiveisLiquidados60Dias ??
                            0) +
                        (dadosLiquidez?.valorTotalRecebiveisLiquidados90Dias ??
                            0) +
                        (dadosLiquidez
                                ?.valorTotalRecebiveisLiquidadosMaisDe90Dias ??
                            0))
                    .toDouble(),
                dadosLiquidez),
            qtdTitulos: (dadosLiquidez
                        ?.quantidadeTotalRecebiveisLiquidados30Dias ??
                    0) +
                (dadosLiquidez?.quantidadeTotalRecebiveisLiquidados45Dias ??
                    0) +
                (dadosLiquidez?.quantidadeTotalRecebiveisLiquidados60Dias ??
                    0) +
                (dadosLiquidez?.quantidadeTotalRecebiveisLiquidados90Dias ??
                    0) +
                (dadosLiquidez
                        ?.quantidadeTotalRecebiveisLiquidadosMaisDe90Dias ??
                    0)),
      ];

  static String _calcular(double? valor, PrazoLiquidezModel? dadosLiquidez) {
    double valorTotal = 0;
    valorTotal = dadosLiquidez?.valorTotalRecebiveisLiquidados ?? 0;
    if (valorTotal == 0 || valor == null) {
      return 0.toPercent;
    }
    return ((valor / valorTotal) * 100).toPercent;
  }

  void limparDados() {
    dadosLiquidez = null;
  }
}
