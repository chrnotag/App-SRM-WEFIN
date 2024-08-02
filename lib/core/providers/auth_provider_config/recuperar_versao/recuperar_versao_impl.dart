import 'dart:convert';
import 'dart:io';

import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/enuns/plataforma_enum.dart';
import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/utils/mensagem_erro_requisicao.dart';
import 'package:Srm_Asset/flavors.dart';
import 'package:Srm_Asset/models/versao_model/versao_model.dart';
import 'package:http/http.dart' as http;
import '../../../constants/enuns/os.dart';

class RecuperarVersaoImpl {
  static Future<ApiResponse<dynamic>> recuperar() async {
    final header = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
    };
    final ambiente = Modular.get<Environment>();
    Uri url = ambiente.endpoints.montarUrlBuscarVersao();
    try {
      final response = await http.get(url, headers: header);
      print('resposta: ${response.body}');
      if (response.statusCode == 200) {
        final data = VersaoModel.fromJson(json.decode(response.body));
        return SucessResponse(data);
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e, s) {
      return MensagemErroPadrao.codigo500();
    }
  }
}
