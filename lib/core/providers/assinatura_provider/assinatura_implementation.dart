import 'package:http/http.dart' as http;
import 'package:modular_study/core/providers/assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';

import '../../implementations_config/export_impl.dart';

class AssinaturaImpl {
  const AssinaturaImpl();
  Future<ApiResponse<dynamic>> assinaturas() async {
    final AssinaturaProvider assinaturaProvider =
        Modular.get<AssinaturaProvider>();
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final url = Uri.parse(EndPoints.assinatura);
    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': authProvider.dataUser!.token
      });
      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        List<MonitorAssinaturasModel> data = [];
        data = List<MonitorAssinaturasModel>.from(
            responseBody.map((model) => MonitorAssinaturasModel.fromJson(model)));
        assinaturaProvider.assinaturas = data;
        return SucessResponse(data);
      } else {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = ExceptionModel.fromJson(responseBody);
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
