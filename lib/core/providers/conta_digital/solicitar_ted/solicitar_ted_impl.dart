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
    print('solicitando ted');
    print('CURL:\nurl: $url\nbody: $body\n header: ${header()}');

    try {
      final response = await http.post(url, headers: header(), body: body);
      if (response.statusCode == 200) {
        return SucessResponse(null);
      } else {
        print('retorno ted: ${response.body}');
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e, s) {
      print('erro solicitar ted $e,$s');
      return MensagemErroPadrao.codigo500();
    }
  }

  static Future<ApiResponse<dynamic>> enviarToken() async {
    final ambiente = Modular.get<Environment>();
    final Uri url = Uri.parse(ambiente.endpoints.tokenSolicitacaoTed);
    print('CURL: \n url: $url\nheader: ${header()}');

    try {
      final response = await http.post(url, headers: header());
      print('resposta token: ${response.body}');
      if (response.statusCode == 200) {
        final data = RespostaTokenModel.fromJson(json.decode(response.body));
        return SucessResponse(data);
      } else {
        print('erro dando aqui: ${response.body}');
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e, s) {
      print('erro solicitar ted $e,$s');
      return MensagemErroPadrao.codigo500();
    }
  }
}
