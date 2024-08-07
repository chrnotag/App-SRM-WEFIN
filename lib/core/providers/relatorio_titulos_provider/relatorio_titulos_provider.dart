import 'dart:typed_data';
import 'package:Srm_Asset/core/providers/relatorio_titulos_provider/download_boleto.dart';
import 'package:Srm_Asset/core/providers/relatorio_titulos_provider/download_relatorio.dart';
import 'package:Srm_Asset/core/providers/relatorio_titulos_provider/relatorio_titulos_impl.dart';
import 'package:Srm_Asset/models/relatorio_titulos/download_boleto/download_boleto_model.dart';
import 'package:Srm_Asset/models/relatorio_titulos/query_status_model/query_parameters.dart';
import 'package:Srm_Asset/models/relatorio_titulos/relat%C3%B3rio_model/relatorio_titulos_model.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/enuns/relatorio_enum.dart';
import '../../implementations_config/api_response.dart';
import '../../utils/toast_erro_util.dart';

class RelatorioTitulosProvider extends ChangeNotifier {
  ListaTitulos _titulos = ListaTitulos(listaTitulos: []);

  ListaTitulos get titulos => _titulos;

  set titulos(ListaTitulos lista) {
    _titulos = lista;
    notifyListeners();
  }

  Future<ApiResponse<dynamic>> recuperarTitulos(RelatorioQueryParams? params) async {
    final response = await RelatorioTitulosImpl.pegarTitulos(params);
    if (response.error == null) {
      titulos = response.data;
    } else {
      showToast('Erro: ', response);
    }
    return response;
  }

  Future<ApiResponse<dynamic>> baixarRelatorio(RelatorioQueryParams status) async {
    final response = await DownloadRelatorioImpl.baixar(status);
    if (response.error == null) {
      dadosPdfRelatorio = response.data;
    } else {
      showToast('Erro: ', response);
    }
    return response;
  }

  Uint8List? _dadosPdfRelatorio;
  Uint8List? get dadosPdfRelatorio => _dadosPdfRelatorio;
  set dadosPdfRelatorio(Uint8List? dados) {
    _dadosPdfRelatorio = dados;
    notifyListeners();
  }


  Future<ApiResponse<dynamic>> baixarBoleto(DownloadBoletoModel dadosDownload) async {
    final response = await DownloadBoletoImpl.baixar(dadosDownload);
    if (response.error == null) {
      dadosPdfRelatorio = response.data;
    } else {
      showToast('Erro: ', response);
    }
    return response;
  }

  Uint8List? _dadosBoleto;
  Uint8List? get dadosBoleto => _dadosBoleto;
  set dadosBoleto(Uint8List? dados) {
    _dadosBoleto = dados;
    notifyListeners();
  }

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

  bool _VENCIDO = true;
  bool get VENCIDO => _VENCIDO;
  set VENCIDO(bool status) {
    _VENCIDO = status;
    notifyListeners();
  }

  bool _A_VENCER = true;
  bool get A_VENCER => _A_VENCER;
  set A_VENCER(bool status) {
    _A_VENCER = status;
    notifyListeners();
  }

  bool _LIQUIDADO = true;
  bool get LIQUIDADO => _LIQUIDADO;
  set LIQUIDADO(bool status) {
    _LIQUIDADO = status;
    notifyListeners();
  }

  List<RelatorioEnum> listaStatus() {

    List<RelatorioEnum> listaStatus = [];
    if (VENCIDO) {
      listaStatus.add(RelatorioEnum.VENCIDO);
    }
    if (A_VENCER) {
      listaStatus.add(RelatorioEnum.A_VENCER);
    }
    if (LIQUIDADO) {
      listaStatus.add(RelatorioEnum.LIQUIDADO);
    }
    return listaStatus;
  }

  RelatorioQueryParams paramsDownload(){
    return RelatorioQueryParams(statusRecebiveis: listaStatus());
  }

  Future<ApiResponse<dynamic>>? _futureRelatorio;

  Future<ApiResponse<dynamic>>? get futureRelatorio => _futureRelatorio;

  set futureRelatorio(Future<ApiResponse<dynamic>>? relatorio) => _futureRelatorio = relatorio;

  RelatorioEnum? _status;

  RelatorioEnum? get status => _status;

  set status(RelatorioEnum? status) => _status = status;
}

