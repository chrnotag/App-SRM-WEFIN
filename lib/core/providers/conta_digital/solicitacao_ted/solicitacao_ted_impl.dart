import 'package:Srm_Asset/core/implementations_config/header_help.dart';
import 'package:http/http.dart' as http;
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import '../../../../models/conta_digital/solicitacoes_ted/solicitacoes_ted.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import '../../../utils/mensagem_erro_requisicao.dart';

class SolicitacaoTedImpl {
  static Future<ApiResponse<dynamic>> pegarSolicitacoes(String numeroContaTitular) async {
    final ambiente = Modular.get<Environment>();
    final Uri url = Uri.parse('${ambiente.endpoints.solicitacoesTed}?numeroContaTitular=$numeroContaTitular');
    try {
      final response = await http.get(url, headers: HeaderPadrao.header());
      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = SolicitacaoTed.fromJson(responseBody);
        return SucessResponse(data);
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e, s) {
      print('erro solicitacao ted $e,$s');
      return MensagemErroPadrao.codigo500();
    }
  }
}
