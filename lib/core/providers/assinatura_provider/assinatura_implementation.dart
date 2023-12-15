import 'package:http/http.dart' as http;
import 'package:modular_study/core/providers/assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';

import '../../implementations_config/export_impl.dart';

class AssinaturaImpl {
  const AssinaturaImpl();
  Future<ApiResponse<dynamic>> assinaturas() async {
    final AssinaturaProvider assinaturaProvider =
        Modular.get<AssinaturaProvider>();
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final url = Uri.parse(EndPoints.assinatura);
    log(authProvider.dataUser!.token);
    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': authProvider.dataUser!.token
      });
      log('status code ${response.statusCode}');
      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        List<AssinaturasModel> data = [];
        data = List<AssinaturasModel>.from(
            responseBody.map((model) => AssinaturasModel.fromJson(model)));
        assinaturaProvider.assinaturas = data;
        return SucessResponse(data);
      } else {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = ExceptionModel.fromJson(responseBody);
        return ErrorResponse(data);
      }
    } catch (e, stacktrace) {
      final data = ExceptionModel(
          codigo: '500',
          dataHora: DateTime.now(),
          httpStatus: 'INTERNAL_SERVER_ERROR',
          mensagem: 'Desculpe, ago deu errado em nosso servidor.');
      log('erro:$stacktrace');
      return ErrorResponse(data);
    }
  }
}
