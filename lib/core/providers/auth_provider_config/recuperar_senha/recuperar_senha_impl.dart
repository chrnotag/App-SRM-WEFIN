import 'package:modular_study/core/implementations_config/export_impl.dart';
import 'package:modular_study/core/providers/theme_provider.dart';
import 'package:http/http.dart' as http;
import '../../../../models/recuperar_senha_model/recuperar_senha_model.dart';

class RecuperarSenhaImpl {
  RecuperarSenhaModel dadosUsuario;

  RecuperarSenhaImpl({required this.dadosUsuario});
  
  Future<ApiResponse<dynamic>> recuperarSenha() async {
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'plataforma': themeProvider.temaSelecionado.name
    };
    final body = json.encode(dadosUsuario.toJson());
    final url = Uri.parse(EndPoints.recuperarSenha);
    try{
      final response = await http.post(url, headers: headers, body: body);
      switch(response.statusCode){
        case 204:
          return SucessResponse(null);
        default:
          final responseBody = json.decode(utf8.decode(response.bodyBytes));
          final data = ExceptionModel.fromJson(responseBody);
          return ErrorResponse(data);
      }
    }catch (e){
      final data = ExceptionModel(
          codigo: '500',
          dataHora: DateTime.now(),
          httpStatus: 'INTERNAL_SERVER_ERROR',
          mensagem: 'Desculpe, algo deu errado em nosso servidor.');
      return ErrorResponse(data);
    }
  }
}