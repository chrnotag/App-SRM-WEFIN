import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';

import '../../implementations_config/export_impl.dart';

class AssinaturaImpl {
  final String identificador;

  const AssinaturaImpl({required this.identificador});

  Future<ApiResponse<dynamic>> assinaturas() async {
    final url = Uri.parse(EndPoints.assinatura).replace(queryParameters: {
      'identificador': identificador,
    });
    final dio = Dio();
    try {
      //log(url.toString());
      final response = await http.post(url);
      log('teste ${response}');
      if (response.statusCode == 501 || response.statusCode == 200) {
        log(response.statusCode.toString());
        log('teste ${response.body}');
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = AssinaturasModel.fromJson(responseBody);
        // log(data.toString());
        return SucessResponse(data);
      } else {
        log(response.statusCode.toString());
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = ExceptionModel.fromJson(responseBody);
        return ErrorResponse(data);
      }
    } catch (e) {
      log("Erro detectado $e");
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
