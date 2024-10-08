import 'dart:convert';
import 'package:Srm_Asset/core/utils/mensagem_erro_requisicao.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import '../../../../models/auth_login_models/SRM/usuario_logado_model.dart';
import '../../../../models/user_model.dart';
import '../../../constants/classes_abstratas/envirioment.dart';
import '../../../implementations_config/api_response.dart';
import '../../../implementations_config/sucess_response.dart';

class LoginImpl {
  final UserModel userModel;

  LoginImpl({required this.userModel});

  Environment ambiente = Modular.get<Environment>();

  Future<ApiResponse<dynamic>> login() async {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final url = ambiente.endpoints.login;
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'plataforma': ambiente.plataforma.name
    };
    final body = json.encode(userModel.toJson());
    print('CURL: $headers\nbody: $body\n url: $url');
    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print('response login: ${response.body}');

      if (response.statusCode == 200) {
        print('response login: ${response.body}');
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = LoginResponse.fromJson(responseBody);
        authProvider.setDataUser = data;
        authProvider.rolesAcesso = data.roles;
        return SucessResponse(data);
      } else if (response.statusCode == 500) {
        return MensagemErroPadrao.codigo500();
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (e) {
      print(e);
      return MensagemErroPadrao.codigo500();
    }
  }
}
