import 'package:modular_study/core/implementations_config/export_impl.dart';
import 'package:modular_study/core/providers/auth_provider_config/deslogar/verificar_sessao.dart';
import 'package:modular_study/core/providers/theme_provider.dart';
import 'package:http/http.dart' as http;

class DeslogarImpl {
  Future<ApiResponse<dynamic>> deslogar() async {
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'plataforma': themeProvider.temaSelecionado.name
    };
    final url = Uri.parse(EndPoints.login);
    try {
      final response = await http.delete(url, headers: headers);
      switch (response.statusCode) {
        case 200:
          VerificarSessao.limparDadosSessao();
          Modular.to.navigate(Modular.initialRoute);
          return SucessResponse(null);
        case 401:
          VerificarSessao.limparDadosSessao();
          log('Deslogado');
          Modular.to.navigate(Modular.initialRoute);
          final responseBody = json.decode(utf8.decode(response.bodyBytes));
          final data = ExceptionModel.fromJson(responseBody);
          return ErrorResponse(data);
        default:
          log('Erro ao deslogar');
          final responseBody = json.decode(utf8.decode(response.bodyBytes));
          final data = ExceptionModel.fromJson(responseBody);
          return ErrorResponse(data);
      }
    } catch (e) {
      log('Erro ao deslogar');
      final data = ExceptionModel(
          codigo: '500',
          dataHora: DateTime.now(),
          httpStatus: 'INTERNAL_SERVER_ERROR',
          mensagem: 'Desculpe, algo deu errado em nosso servidor.');
      return ErrorResponse(data);
    }
  }
}
