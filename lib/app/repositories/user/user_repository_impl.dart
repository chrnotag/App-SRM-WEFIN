import 'package:flutter_mobile_project/app/core/exceptions/failure.dart';
import 'package:flutter_mobile_project/app/core/exceptions/user_exists_exception.dart';
import 'package:flutter_mobile_project/app/core/logger/app_logger.dart';
import 'package:flutter_mobile_project/app/core/rest_client/rest_client.dart';
import 'package:flutter_mobile_project/app/core/rest_client/rest_client_exception.dart';
import 'package:flutter_mobile_project/app/models/user_model.dart';

import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;
  final AppLogger _log;

  UserRepositoryImpl({
    required RestClient restClient,
    required AppLogger log,
  })  : _restClient = restClient,
        _log = log;

  @override
  Future<void> register(String email, String password) async {
    try {
      await _restClient
          .unauth()
          .post('/auth/register', data: {'email': email, 'password': password});
    } on RestClientException catch (e, s) {
      if (e.statusCode == 400 &&
          e.response.data['message'].contains('Usuário já cadastrado')) {
        _log.error(e.error, e, s);
        throw UserExistsException();
      }

      _log.error('Erro ao cadastrar usuário');
      throw Failure(message: 'Erro ao registrar usuário');
    }
  }

  @override
  Future<String> login(String email, String password) async {
    try {
      final result = await _restClient.unauth().post(
        '/auth/',
        data: {
          'login': email,
          'password': password,
          'social_login': false,
          'supplier_user': false,
        },
      );

      return result.data['access_token'];
    } on RestClientException catch (e, s) {
      if (e.statusCode == 403) {
        throw Failure(
            message: 'Usuário inconsistente entre em contato com o suporte!!!');
      }
      _log.error('Erro ao realizar login', e, s);
      throw Failure(
          message: 'Erro ao realizar login, tente novamente mais tarde');
    }
  }

  @override
  Future<UserModel> getUserLogged() async {
    try {
      final result = await _restClient.get('/user/');

      return UserModel.fromMap(result.data);
    } on RestClientException catch (e, s) {
      _log.error('Erro ao buscar dados do usuario logado', e, s);
      throw Failure(message: 'Erro ao buscar dados do usuario logado');
    }
  }
}
