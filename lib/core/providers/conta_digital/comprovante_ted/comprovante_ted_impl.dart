import 'dart:typed_data';
import 'package:Srm_Asset/core/providers/conta_digital/comprovante_ted/comprovante_ted_provider.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../constants/classes_abstratas/envirioment.dart';
import '../../../implementations_config/api_response.dart';
import '../../../implementations_config/export_impl.dart';
import '../../../utils/mensagem_erro_requisicao.dart';
import 'package:http/http.dart' as http;

import '../../auth_provider_config/logar/auth_providers.dart';

class ComprovanteTEDImpl {
  static Future<ApiResponse<dynamic>> baixar(String codigoTransacao) async {
    final Environment ambiente = Modular.get<Environment>();
    final authProvider = Modular.get<AuthProvider>();
    final tedProvider = Modular.get<ComprovanteTEDProvider>();
    Uri url =
        ambiente.endpoints.montarUrlDownloadComprovanteTED(codigoTransacao);
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': ambiente.plataforma.name
    };
    try {
      final response = await http.get(url, headers: headers);
      print('request code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Uint8List pdfBytes = response.bodyBytes;
        tedProvider.comprovanteTEDDownloadBites = pdfBytes;
        return SucessResponse(pdfBytes);
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
