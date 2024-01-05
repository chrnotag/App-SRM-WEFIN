import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modular_study/core/providers/auth_provider_config/deslogar/verificar_sessao.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_provider.dart';
import 'package:modular_study/models/fluxo_assinatura_model/assinatura_eletronica/assinatura_eletronica_model.dart';
import '../../../implementations_config/export_impl.dart';
import 'package:http/http.dart' as http;

class AssinaturaEletronicaImpl {
  AssinaturaEletronicaModel assinaturaEletronicaModel;

  AssinaturaEletronicaImpl({required this.assinaturaEletronicaModel});

  Future<ApiResponse<dynamic>> finalizarAssinatura() async {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': authProvider.dataUser!.token
    };
    final body = json.encode(assinaturaEletronicaModel);
    final url = Uri.parse(EndPoints.finalizarAssinaturaEletronica);
    try {
      final response = await http.post(url, headers: headers, body: body);
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
