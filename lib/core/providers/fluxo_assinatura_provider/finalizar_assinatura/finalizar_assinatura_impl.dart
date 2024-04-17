import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/models/fluxo_assinatura_model/finalizar_assinatura/finalizar_assinatura.dart';
import 'package:http/http.dart' as http;
import '../../../constants/classes_abstratas/envirioment.dart';
import '../../../implementations_config/export_impl.dart';
import '../../../utils/mensagem_erro_requisicao.dart';
import '../../auth_provider_config/deslogar/verificar_sessao.dart';

class FinalizarAssinaturaImpl {
  FinalizarAssinaturaModel assinaturaFinalizada;

  FinalizarAssinaturaImpl({required this.assinaturaFinalizada});

  Future<ApiResponse<dynamic>> finalizarAssinatura() async {
    Environment ambiente = Modular.get<Environment>();
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final url = Uri.parse(ambiente.endpoints.finalizarAssinatura);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma' : ambiente.plataforma.name,
    };
    final body = json.encode(assinaturaFinalizada);
    try {
      final response = await http.post(url, body: body, headers: headers);
      log("status code: ${response.body}");
      switch (response.statusCode) {
        case 204:
          return SucessResponse(null);
        case 401:
          VerificarSessao.sessaoExpirada();
          return MensagemErroPadrao.erroResponse(response.bodyBytes);
        default:
          return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e) {
      return MensagemErroPadrao.codigo500();
    }
  }
}
