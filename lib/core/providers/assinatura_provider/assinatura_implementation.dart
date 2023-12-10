import 'package:http/http.dart' as http;
import 'package:modular_study/core/providers/assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';

import '../../implementations_config/export_impl.dart';

class AssinaturaImpl {
  const AssinaturaImpl();

  Future<ApiResponse<dynamic>> assinaturas() async {
    final AssinaturaProvider assinaturaProvider =
        Modular.get<AssinaturaProvider>();
    final url = Uri.parse(EndPoints.assinatura);
    try {
      final response = await http.post(url, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      });
      log('status code ${response.statusCode}');
      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        log('$responseBody');
        final data = List<AssinaturasModel>.from(
            responseBody.map((model) => AssinaturasModel.fromJson(model)));
        log('data: $data');
        assinaturaProvider.assinaturas = data;
        return SucessResponse(data);
      } else {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = ExceptionModel.fromJson(responseBody);
        log('error: $data');
        return ErrorResponse(data);
      }
    } catch (e) {
      final data = ExceptionModel(
          codigo: '500',
          dataHora: DateTime.now(),
          httpStatus: 'INTERNAL_SERVER_ERROR',
          mensagem: 'Desculpe, ago deu errado em nosso servidor.');
      return ErrorResponse(data);
    }
  }
}
