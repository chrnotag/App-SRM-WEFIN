import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_provider.dart';
import 'package:modular_study/core/providers/theme_provider.dart';
import 'package:modular_study/models/fluxo_assinatura_model/iniciar_assinatura_eletronica/iniciar_assinatura_eletronica_model.dart';
import 'package:http/http.dart' as http;
import '../../../../models/fluxo_assinatura_model/iniciar_assinatura_eletronica/response/resposta_inic_ass_eletronica.dart';
import '../../../implementations_config/export_impl.dart';
import '../../auth_provider_config/deslogar/verificar_sessao.dart';

class IniciarAssinaturaEletronicaImpl {
  IniciarAssinaturaEletronicaModel codigoOperacaoModel;

  IniciarAssinaturaEletronicaImpl({required this.codigoOperacaoModel});

  Future<ApiResponse<dynamic>> iniciarAssinaturaEletronica() async {
    AssinaturaEletronicaProvider assinaturaEletronicaProvider =
        Modular.get<AssinaturaEletronicaProvider>();
    AuthProvider authProvider = Modular.get<AuthProvider>();
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': themeProvider.temaSelecionado.name
    };
    final body = json.encode(codigoOperacaoModel);
    final url = Uri.parse(EndPoints.iniciarAssinaturaEletronica);
    try {
      final response = await http.post(url, body: body, headers: headers);
      switch (response.statusCode) {
        case 200:
          final responseBody = ResponseInicAssinaturaEletronica.fromJson(
              json.decode(utf8.decode(response.bodyBytes)));
          assinaturaEletronicaProvider.respostaAssinaturaEletronica = responseBody;
          return SucessResponse(responseBody);
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
      log('fatal error $e');
      final data = ExceptionModel(
          codigo: '500',
          dataHora: DateTime.now(),
          httpStatus: 'INTERNAL_SERVER_ERROR',
          mensagem: 'Desculpe, algo deu errado em nosso servidor.');
      return ErrorResponse(data);
    }
  }
}
