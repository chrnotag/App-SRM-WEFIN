import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/iniciar_assinatura/iniciar_assinatura_provider.dart';
import 'package:http/http.dart' as http;
import 'package:Srm_Asset/models/fluxo_assinatura_model/iniciar_assinatura/iniciar_assinatura.dart';
import 'package:Srm_Asset/models/fluxo_assinatura_model/iniciar_assinatura/resposta_iniciar_assinatura.dart';
import '../../../constants/classes_abstratas/envirioment.dart';
import '../../../implementations_config/export_impl.dart';
import '../../../utils/mensagem_erro_requisicao.dart';
import '../../auth_provider_config/deslogar/verificar_sessao.dart';

class IniciarAssinaturaImpl {
  IniciarAssinaturaModel iniciarAssinaturaModel;

  IniciarAssinaturaImpl({required this.iniciarAssinaturaModel});

  Future<ApiResponse<dynamic>> obterHashParaAssinar() async {
    Environment ambiente = Modular.get<Environment>();
    AuthProvider authProvider = Modular.get<AuthProvider>();
    final IniciarAssinaturaProvider iniciarAssinaturaProvider =
        Modular.get<IniciarAssinaturaProvider>();
    final url = Uri.parse(ambiente.endpoints.iniciarAssinatura);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': ambiente.plataforma.name
    };
    final body = json.encode(iniciarAssinaturaModel.toJson());
    log('body: $body');
    try {
      final response = await http.post(url, headers: headers, body: body);
      log("status code: ${response.body}");
      switch (response.statusCode) {
        case 200:
          final responseBody = json.decode(utf8.decode(response.bodyBytes));
          List<RespostaIniciarAssinaturaModel> data = [];
          data = List<RespostaIniciarAssinaturaModel>.from(responseBody
              .map((model) => RespostaIniciarAssinaturaModel.fromJson(model)));
          iniciarAssinaturaProvider.hashsParaAssinar = data;
          return SucessResponse(data);
        case 401:
          return MensagemErroPadrao.erroResponse(response.bodyBytes);
        default:
          return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e) {
      return MensagemErroPadrao.codigo_500();
    }
  }
}
