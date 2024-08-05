import 'dart:typed_data';
import 'package:Srm_Asset/core/providers/relatorio_titulos_provider/download_relatorio.dart';
import 'package:Srm_Asset/core/providers/relatorio_titulos_provider/relatorio_titulos_impl.dart';
import 'package:Srm_Asset/models/relatorio_titulos/relatorio_titulos_model.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/enuns/relatorio_enum.dart';
import '../../implementations_config/api_response.dart';
import '../../utils/toast_erro_util.dart';

class RelatorioTitulosProvider extends ChangeNotifier {
  ListaTitulos _titulos = ListaTitulos(listaTitulos: []);

  ListaTitulos get titulos => _titulos;

  set titulos(ListaTitulos lista) => _titulos = lista;

  Future<ApiResponse<dynamic>> recuperarTitulos() async {
    final response = await RelatorioTitulosImpl.pegarTitulos();
    if (response.error == null) {
        titulos = response.data;
    } else {
      showToast('Erro: ', response);
    }
    return response;
  }

  Future<ApiResponse<dynamic>> baixarRelatorio(RelatorioEnum status) async {
    final response = await DownloadRelatorioImpl.baixar(status);
    if(response.error == null){
      dadosPdf = response.data;
    }else{
      showToast('Erro: ', response);
    }
    return response;
  }

  Uint8List? _dadosPdf;
  Uint8List? get dadosPdf => _dadosPdf;
  set dadosPdf(Uint8List? dados) => _dadosPdf = dados;

  double saldoAVencer() {
    double valor = 0;
    for (var item in titulos.listaTitulos) {
      if (item.status == RelatorioEnum.A_VENCER) {
        valor += item.valor;
      }
    }
    return valor;
  }

  double saldoVencido() {
    double valor = 0;
    for (var item in titulos.listaTitulos) {
      if (item.status == RelatorioEnum.VENCIDO) {
        valor += item.valor;
      }
    }
    return valor;
  }

  Future<ApiResponse<dynamic>>? _futureRelatorio;
  Future<ApiResponse<dynamic>>? get futureRelatorio => _futureRelatorio;
  set futureRelatorio(Future<ApiResponse<dynamic>>? relatorio) => _futureRelatorio = relatorio;
}
