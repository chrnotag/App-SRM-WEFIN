import 'package:fluttertoast/fluttertoast.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/iniciar_assinatura/iniciar_assinatura_provider.dart';
import 'package:http/http.dart' as http;
import 'package:modular_study/models/fluxo_assinatura_model/iniciar_assinatura/iniciar_assinatura.dart';
import 'package:modular_study/models/fluxo_assinatura_model/iniciar_assinatura/resposta_iniciar_assinatura.dart';
import '../../../implementations_config/export_impl.dart';
import '../../auth_provider_config/deslogar/verificar_sessao.dart';

class IniciarAssinaturaImpl {
  IniciarAssinaturaModel iniciarAssinaturaModel;

  IniciarAssinaturaImpl({required this.iniciarAssinaturaModel});

  Future<ApiResponse<dynamic>> obterHashParaAssinar() async {
    AuthProvider authProvider = Modular.get<AuthProvider>();
    final IniciarAssinaturaProvider iniciarAssinaturaProvider =
        Modular.get<IniciarAssinaturaProvider>();
    final url = Uri.parse(EndPoints.iniciarAssinatura);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': authProvider.dataUser!.token
    };
    final body = json.encode(iniciarAssinaturaModel.toJson());
    try {
      final response = await http.post(url, headers: headers, body: body);
      log('status code: ${response.statusCode}');
      switch (response.statusCode) {
        case 200:
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        List<RespostaIniciarAssinaturaModel> data = [];
        data = List<RespostaIniciarAssinaturaModel>.from(responseBody
            .map((model) => RespostaIniciarAssinaturaModel.fromJson(model)));
        iniciarAssinaturaProvider.hashsParaAssinar = data;
        return SucessResponse(data);
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
