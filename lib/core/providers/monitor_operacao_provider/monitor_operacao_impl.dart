import 'dart:convert';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/monitor_operacao_provider/monitor_operacoes_provider.dart';
import 'package:http/http.dart' as http;
import 'package:Srm_Asset/models/monitor_operacoes_model/monitor_operacoes_model.dart';
import '../../constants/classes_abstratas/envirioment.dart';
import '../../implementations_config/api_response.dart';
import '../../utils/mensagem_erro_requisicao.dart';
import '../auth_provider_config/deslogar/verificar_sessao.dart';

class MonitorOperacaoImpl {
  Future<ApiResponse<dynamic>> carregarOperacoes() async {
    Environment ambiente = Modular.get<Environment>();
    AuthProvider authProvider = Modular.get<AuthProvider>();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': ambiente.plataforma.name,
    };
    final url = Uri.parse(ambiente.endpoints.operacoes);
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
          return MensagemErroPadrao.erroResponse(response.bodyBytes);
        default:
          return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e) {
      return MensagemErroPadrao.codigo_500();
    }
  }
}
