import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/models/fluxo_assinatura_model/finalizar_assinatura/finalizar_assinatura.dart';
import 'package:http/http.dart' as http;
import '../../../constants/classes_abstratas/envirioment.dart';
import '../../../implementations_config/export_impl.dart';
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
          final responseBody = json.decode(utf8.decode(response.bodyBytes));
          final data = ExceptionModel.fromJson(responseBody);
          return ErrorResponse(data);
        default:
          final responseBody = json.decode(utf8.decode(response.bodyBytes));
          final data = ExceptionModel.fromJson(responseBody);
          return ErrorResponse(data);
      }
    } catch (e) {

      final data = ExceptionModel(
          codigo: '500',
          dataHora: DateTime.now(),
          httpStatus: 'INTERNAL_SERVER_ERROR',
          mensagem: 'Desculpe, algo deu errado em nosso servidor.');
      return ErrorResponse(data);
    }
  }
}
