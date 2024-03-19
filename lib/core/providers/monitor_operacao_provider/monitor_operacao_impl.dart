import 'dart:convert';
import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/endpoints.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/monitor_operacao_provider/monitor_operacoes_provider.dart';
import 'package:Srm_Asset/core/providers/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:Srm_Asset/models/monitor_operacoes_model/monitor_operacoes_model.dart';
import '../../implementations_config/api_response.dart';
import '../auth_provider_config/deslogar/verificar_sessao.dart';

class MonitorOperacaoImpl {
  Future<ApiResponse<dynamic>> carregarOperacoes() async {
    AuthProvider authProvider = Modular.get<AuthProvider>();
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': themeProvider.temaSelecionado.name,
    };
    final url = Uri.parse(EndPoints.operacoes);
    try {
      final response = await http.get(url, headers: headers);
      switch (response.statusCode) {
        case 200:
          final responseBody = json.decode(utf8.decode(response.bodyBytes));
          final MonitorOperacoesProvider operacoesProvider = Modular.get<MonitorOperacoesProvider>();
          List<MonitorOperacoesModel> data = [];
          data = List<MonitorOperacoesModel>.from(responseBody.map((model) => MonitorOperacoesModel.fromJson(model)));
          operacoesProvider.operacoes = data;
          return SucessResponse(data);
        case 401:
          VerificarSessao.sessaoExpirada();
          final responseBody = json.decode(response.body);
          final data = ExceptionModel.fromJson(responseBody);
          return ErrorResponse(data);
        default:
          final responseBody = json.decode(response.body);
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
