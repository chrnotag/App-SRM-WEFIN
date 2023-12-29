import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_provider.dart';
import 'package:modular_study/models/fluxo_assinatura_model/assinatura_eletronica/assinatura_eletronica_model.dart';
import '../../../implementations_config/export_impl.dart';
import 'package:http/http.dart' as http;

class AssinaturaEletronicaImpl {
  AssinaturaEletronicaModel assinaturaEletronicaModel;

  AssinaturaEletronicaImpl({required this.assinaturaEletronicaModel});

  Future<ApiResponse<dynamic>> finalizarAssinatura() async {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final AssinaturaEletronicaProvider assinaturaEletronica =
        Modular.get<AssinaturaEletronicaProvider>();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': authProvider.dataUser!.token
    };
    final body = json.encode(assinaturaEletronicaModel);
    final url = Uri.parse(EndPoints.finalizarAssinaturaEletronica);
    try {
      final response = await http.post(url, headers: headers, body: body);
      log('statusCode: ${response.statusCode}');
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Sucesso!');
        assinaturaEletronica.statusCodeAssinaturaEletronica =
            response.statusCode;
        return SucessResponse(null);
      } else {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = ExceptionModel.fromJson(responseBody);
        Fluttertoast.showToast(
            msg: 'Falha ao obter as hashs: ${data.mensagem}');
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
