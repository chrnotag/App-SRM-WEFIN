import 'package:Srm_Asset/core/utils/mensagem_erro_requisicao.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/deslogar/verificar_sessao.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/models/fluxo_assinatura_model/finalizar_assinatura_eletronica/finalizar_assinatura_eletronica_model.dart';
import '../../../constants/classes_abstratas/envirioment.dart';
import '../../../implementations_config/export_impl.dart';
import 'package:http/http.dart' as http;

class AssinaturaEletronicaImpl {
  FinalizarAssinaturaEletronicaModel assinaturaEletronicaModel;

  AssinaturaEletronicaImpl({required this.assinaturaEletronicaModel});

  Future<ApiResponse<dynamic>> finalizarAssinatura() async {
    Environment ambiente = Modular.get<Environment>();
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': ambiente.plataforma.name
    };
    final body = json.encode(assinaturaEletronicaModel);
    final url = Uri.parse(ambiente.endpoints.finalizarAssinaturaEletronica);
    try {
      final response = await http.post(url, headers: headers, body: body);
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
      return MensagemErroPadrao.codigo_500();
    }
  }
}
