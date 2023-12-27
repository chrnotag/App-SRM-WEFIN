import 'package:fluttertoast/fluttertoast.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/models/fluxo_assinatura_model/finalizar_assinatura/finalizar_assinatura.dart';
import 'package:http/http.dart' as http;
import '../../../implementations_config/export_impl.dart';

class FinalizarAssinaturaImpl {
  FinalizarAssinaturaModel assinaturaFinalizada;

  FinalizarAssinaturaImpl({required this.assinaturaFinalizada});

  Future<ApiResponse<dynamic>> finalizarAssinatura() async {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final url = Uri.parse(EndPoints.finalizarAssinatura);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': authProvider.dataUser!.token
    };
    final body = json.encode(assinaturaFinalizada);
    try {
      final response = await http.post(url, body: body, headers: headers);
      log('statusCode finalizarAssinatura: ${response.statusCode}');
      if (response.statusCode == 200) {
        log('teste ${response.body}');
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        return SucessResponse(null);
      } else {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        log('teste ${response.body}');
        final data = ExceptionModel.fromJson(responseBody);
        Fluttertoast.showToast(
            msg: 'Falha ao obter as hashs: ${data.mensagem}');
        return ErrorResponse(data);
      }
    } catch (e) {
      log("Error: $e");
      final data = ExceptionModel(
          codigo: '500',
          dataHora: DateTime.now(),
          httpStatus: 'INTERNAL_SERVER_ERROR',
          mensagem: 'Desculpe, algo deu errado em nosso servidor.');
      return ErrorResponse(data);
    }
  }
}
