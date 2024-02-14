import 'package:flutter/material.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/theme_provider.dart';
import 'package:modular_study/models/fluxo_assinatura_model/finalizar_assinatura/finalizar_assinatura.dart';
import 'package:http/http.dart' as http;
import '../../../implementations_config/export_impl.dart';
import '../../auth_provider_config/deslogar/verificar_sessao.dart';

class FinalizarAssinaturaImpl {
  FinalizarAssinaturaModel assinaturaFinalizada;

  FinalizarAssinaturaImpl({required this.assinaturaFinalizada});

  Future<ApiResponse<dynamic>> finalizarAssinatura() async {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final url = Uri.parse(EndPoints.finalizarAssinatura);
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma' : themeProvider.temaSelecionado.name,
    };
    final body = json.encode(assinaturaFinalizada);
    try {
      final response = await http.post(url, body: body, headers: headers);
      switch (response.statusCode) {
        case 204:
          return SucessResponse(null);
        case 401:
          VerificarSessao.sessaoExpirada();
          final responseBody = json.decode(utf8.decode(response.bodyBytes));
          final data = ExceptionModel.fromJson(responseBody);
          return ErrorResponse(data);
        default:
          final responseBody = json.decode(utf8.decode(response.bodyBytes));
          final data = ExceptionModel.fromJson(responseBody);
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
