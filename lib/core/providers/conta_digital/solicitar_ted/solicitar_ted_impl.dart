import 'dart:typed_data';

import 'package:Srm_Asset/core/implementations_config/header_help.dart';
import 'package:http/http.dart' as http;
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import '../../../../models/conta_digital/solicitar_ted/parametro/solicitar_ted_parametro_model.dart';
import '../../../../models/conta_digital/solicitar_ted/resposta/solicitar_ted_resposta.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import '../../../../models/conta_digital/solicitar_ted/resposta_token/resposta_token_model.dart';
import '../../../utils/mensagem_erro_requisicao.dart';


class SolicitarTedRespostaImpl {
  static Future<ApiResponse<dynamic>> solicitarTed(SolicitarTedParametroModel parametro) async {
    final ambiente = Modular.get<Environment>();
    final Uri url = Uri.parse(ambiente.endpoints.solicitarTedContaDigital);
    final body = json.encode(parametro.toJson());
    try {
      final response = await http.post(url, headers: header(), body: body);
      print(response.body);
      if (response.statusCode == 200) {
        return SucessResponse(null);
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (_) {
      return MensagemErroPadrao.codigo500();
    }
  }

  static Future<ApiResponse<dynamic>> enviarToken() async {
    final ambiente = Modular.get<Environment>();
    final Uri url = Uri.parse(ambiente.endpoints.tokenSolicitacaoTed);
    try {
      final response = await http.post(url, headers: header());
      if (response.statusCode == 200) {
        final data = RespostaTokenModel.fromJson(json.decode(response.body));
        return SucessResponse(data);
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (_) {
      return MensagemErroPadrao.codigo500();
    }
  }
}
