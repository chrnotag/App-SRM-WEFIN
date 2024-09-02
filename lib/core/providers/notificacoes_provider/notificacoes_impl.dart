import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/implementations_config/header_help.dart';
import 'package:Srm_Asset/core/utils/mensagem_erro_requisicao.dart';
import 'package:Srm_Asset/models/notificacoes/notificacoes_model.dart';
import '../../implementations_config/export_impl.dart';
import 'package:http/http.dart' as http;

class NotificacoesImpl {
  static Future<ApiResponse<dynamic>> pegarNotificacoes() async {
    final ambiente = Modular.get<Environment>();
    final Uri url = Uri.parse(ambiente.endpoints.notificacoes);
    try {
      final response = await http.get(url, headers: header());
      print('response: ${response.body}');
      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        List<NotificacoesModel> data = [];
        data = List<NotificacoesModel>.from(responseBody
            .map((model) => NotificacoesModel.fromJson(model)));
        return SucessResponse(data);
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (_) {
      print("erro:$_");
      return MensagemErroPadrao.codigo500();
    }
  }

  static Future<ApiResponse<dynamic>> marcarLido(NotificacoesModel notificacao) async {
    final ambiente = Modular.get<Environment>();
    final Uri url = Uri.parse("${ambiente.endpoints.notificacoes}/${notificacao.idNotificacao}/marcar-lido");
    try {
      final response = await http.patch(url, headers: header());
      if (response.statusCode == 204) {
        return SucessResponse(null);
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (_) {
      return MensagemErroPadrao.codigo500();
    }
  }
}
