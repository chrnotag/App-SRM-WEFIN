import 'dart:convert';
import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:modular_study/core/constants/endpoints.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';

import '../../../models/auth_login_models/usuario_logado_model.dart';
import '../../../models/exceptions_responses/exception_model.dart';
import '../../../models/user_model.dart';
import '../../implementations_config/api_response.dart';
import '../../implementations_config/error_response.dart';
import '../../implementations_config/sucess_response.dart';

class LoginImpl {
  final UserModel userModel;

  LoginImpl({required this.userModel});

  Future<ApiResponse<dynamic>> login() async {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    const url = EndPoints.login;
    const headers = {'Content-Type': 'application/json; charset=utf-8'};
    final body = json.encode(userModel.toJson());

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = LoginResponse.fromJson(responseBody);
        authProvider.setDataUser = data;
        authProvider.empresaSelecionada ??= data.listaCedente[0];
        return SucessResponse(data);
      } else {
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
