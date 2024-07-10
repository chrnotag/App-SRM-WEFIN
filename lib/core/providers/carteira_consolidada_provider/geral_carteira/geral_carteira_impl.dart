import 'dart:typed_data';

import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/geral_carteira/geral_carteira_provider.dart';
import 'package:Srm_Asset/models/carteira_consolidada/geral_carteira/geral_carteira_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../constants/classes_abstratas/envirioment.dart';
import '../../../implementations_config/export_impl.dart';
import '../../../utils/mensagem_erro_requisicao.dart';
import '../../auth_provider_config/logar/auth_providers.dart';
import 'package:http/http.dart' as http;

class GeralCarteiraImpl{
  static Future<ApiResponse<dynamic>> pegarGeralCarteira() async {
    final Environment ambiente = Modular.get<Environment>();
    final authProvider = Modular.get<AuthProvider>();
    Uri url = Uri.parse(ambiente.endpoints.geralCarteira);
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'Authorization': authProvider.dataUser!.token,
      'plataforma': ambiente.plataforma.name
    };
    final geralCarteiraProvider = Modular.get<GeralCarteiraProvider>();
    try{
      final response = await http.get(url,headers: headers);
      if (response.statusCode == 200) {
        final data = GeralCarteiraModel.fromJson(json.decode(response.body));
        geralCarteiraProvider.dadosGeralCarteira = data;
        return SucessResponse(data);
      } else if (response.statusCode == 500) {
        return MensagemErroPadrao.codigo500();
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    }catch (e, s){
      return MensagemErroPadrao.codigo500();
    }
  }
}