import 'package:http/http.dart' as http;
import 'package:modular_study/core/providers/assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';

import '../../implementations_config/export_impl.dart';

class AssinaturaImpl {
  final String identificador;

  const AssinaturaImpl({required this.identificador});

  Future<ApiResponse<dynamic>> assinaturas() async {
    final AssinaturaProvider assinaturaProvider =
        Modular.get<AssinaturaProvider>();
    final url = Uri.parse(EndPoints.assinatura).replace(queryParameters: {
      'identificador': identificador,
    });
    try {
      final response =
          await http.post(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        log('teste ${response.body}');
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = List<AssinaturasModel>.from(
            responseBody.map((model) => AssinaturasModel.fromJson(model)));
        assinaturaProvider.assinaturas = data;
        return SucessResponse(data);
      } else {
        log(response.statusCode.toString());
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = ExceptionModel.fromJson(responseBody);
        return ErrorResponse(data);
      }
    } catch (e) {
      log("Erro detectado $e, foi no catch");
      final data = ExceptionModel(
          codigo: '404',
          dataHora: DateTime.now(),
          erros: [
            "Um problema inesperado ocorreu ao processar sua requisição.",
            "Nosso time técnico já foi notificado e trabalhará para solucionar o problema o mais rápido possível."
          ],
          httpStatus: 'INTERNAL_SERVER_ERROR',
          mensagem: 'Desculpe, ago deu errado em nosso servidor.');
      return ErrorResponse(data);
    }
  }
}
