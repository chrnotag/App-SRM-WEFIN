import 'dart:convert';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/models/conta_digital/geral/conta_digital.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import '../../../implementations_config/api_response.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import '../../../utils/mensagem_erro_requisicao.dart';
import '../saldo/conta_digital_saldo_impl.dart';

class ContaDigitalImpl {
  static Future<ApiResponse<dynamic>> pegarDadosContaDigital() async {
    final authProvider = Modular.get<AuthProvider>();
      final ambiente = Modular.get<Environment>();
      final Uri url = Uri.parse(ambiente.endpoints.contaDigital);
      final headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'accept': 'application/json',
        'Authorization': authProvider.dataUser!.token,
        'plataforma': ambiente.plataforma.name
      };
      try {
        final response = await http.get(url, headers: headers);
        print('Resposta  da requisição: ${response.body}');
        print('statusCode: ${response.statusCode}');
        if (response.statusCode == 200) {
          final responseBody = json.decode(utf8.decode(response.bodyBytes));
          final data = ContaDigitalModel.fromJson(responseBody);
          final saldo = await ContaDigitalSaldoImpl.resgatarSaldo(data.conta);
          print('saldo: ${saldo.data}');
          return SucessResponse(data);
        } else if (response.statusCode == 500) {
          print('teste2');
          return MensagemErroPadrao.codigo500();
        } else {
          print('teste1');
          return MensagemErroPadrao.erroResponse(response.bodyBytes);
        }
      } catch (e, s) {
        print('teste3, $e,$s');
        return MensagemErroPadrao.codigo500();
      }
  }
}
