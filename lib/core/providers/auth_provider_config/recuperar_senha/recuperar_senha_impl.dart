import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/utils/mensagem_erro_requisicao.dart';
import 'package:http/http.dart' as http;
import '../../../../models/recuperar_senha_model/recuperar_senha_model.dart';
import '../../../constants/classes_abstratas/envirioment.dart';

class RecuperarSenhaImpl {
  RecuperarSenhaModel dadosUsuario;

  RecuperarSenhaImpl({required this.dadosUsuario});
  Environment ambiente = Modular.get<Environment>();
  Future<ApiResponse<dynamic>> recuperarSenha() async {
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'plataforma': ambiente.plataforma.name
    };
    final body = json.encode(dadosUsuario.toJson());
    final url = Uri.parse(ambiente.endpoints.recuperarSenha);
    try {
      final response = await http.post(url, headers: headers, body: body);
      log('status Code: ${response.statusCode}');
      log('body: ${response.body}');
      switch (response.statusCode) {
        case 204:
          return SucessResponse(null);
        default:
          return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e) {
      return MensagemErroPadrao.codigo500();
    }
  }
}
