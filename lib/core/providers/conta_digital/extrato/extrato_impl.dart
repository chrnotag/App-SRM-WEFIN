import 'dart:typed_data';

import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_provider.dart';
import 'package:Srm_Asset/models/conta_digital/extrato/conta_extrato_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../implementations_config/export_impl.dart';
import '../../../constants/classes_abstratas/envirioment.dart';
import '../../../utils/mensagem_erro_requisicao.dart';
import '../../auth_provider_config/logar/auth_providers.dart';
import 'package:http/http.dart' as http;

class ExtratoImpl {
  final TipoConsultaExtrato tipoConsulta;
  const ExtratoImpl({required this.tipoConsulta});

  Future<ApiResponse<dynamic>> pegarExtrato(
      String numeroContaTitular, String dataInicial, String dataFinal) async {
    final authProvider = Modular.get<AuthProvider>();
    final ambiente = Modular.get<Environment>();
    final extratoProvider = Modular.get<ExtratoProvider>();
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': ambiente.plataforma.name
    };
    final Uri url = ambiente.endpoints.montarUrlPegarExtrato(
        numeroContaTitular, dataInicial, dataFinal, tipoConsulta);
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        if (tipoConsulta == TipoConsultaExtrato.BAIXAR) {
          final Uint8List pdfBytes = response.bodyBytes;
          extratoProvider.extratoDownloadBites = pdfBytes;
          return SucessResponse(pdfBytes);
        } else {
          final responseBody = json.decode(utf8.decode(response.bodyBytes));
          ContaExtratoModel data = ContaExtratoModel.fromJson(responseBody);
          if(tipoConsulta == TipoConsultaExtrato.PERSONALIZADO){
            extratoProvider.extratoPersonalizado = data;
          }else{
            extratoProvider.extrato = data;
          }
          return SucessResponse(data);
        }
      } else if (response.statusCode == 500) {
        return MensagemErroPadrao.codigo500();
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e, s) {
      return MensagemErroPadrao.codigo500();
    }
  }
}

enum TipoConsultaExtrato {
  VISUALIZAR,
  PERSONALIZADO,
  BAIXAR;

  const TipoConsultaExtrato();

  static String retornarEndpoint(
      TipoConsultaExtrato tipoConsulta, Environment ambiente) {
    switch (tipoConsulta) {
      case TipoConsultaExtrato.VISUALIZAR:
      case TipoConsultaExtrato.PERSONALIZADO:
        return ambiente.endpoints.extratoContaDigital;
      case TipoConsultaExtrato.BAIXAR:
        return ambiente.endpoints.downloadExtratoContaDigital;
    }
  }
}
