import 'package:flutter/material.dart';
import 'package:modular_study/core/providers/auth_provider_config/login_implementation.dart';
import 'package:modular_study/models/auth_login_models/cedente_model.dart';
import 'package:modular_study/models/auth_login_models/usuario_logado_model.dart';
import 'package:modular_study/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider._();

  static final _instance = AuthProvider._();

  factory AuthProvider() {
    return _instance;
  }

  Future<dynamic> login(UserModel userModel) async {
    credenciaisUsuario = userModel;
    return await LoginImpl(userModel: userModel).login();
  }

  late UserModel _credenciaisUsuario;

  UserModel get credenciaisUsuario => _credenciaisUsuario;

  set credenciaisUsuario(UserModel credenciais) =>
      _credenciaisUsuario = credenciais;

  LoginResponse? _dataUser;
  List<CedenteModel>? _listaCedente;
  CedenteModel? _empresaSelecionada;

  LoginResponse? get dataUser => _dataUser;

  List<CedenteModel>? get listaCedente => _listaCedente;

  CedenteModel? get empresaSelecionada => _empresaSelecionada;

  set setDataUser(LoginResponse loginResponse) {
    _dataUser = loginResponse;
    _setListaCedente = loginResponse.listaCedente;
    notifyListeners();
  }

  set _setListaCedente(List<CedenteModel> listaCedente) {
    _listaCedente = listaCedente;
    notifyListeners();
  }

  set empresaSelecionada(CedenteModel? cedente) {
    _empresaSelecionada = cedente;
    notifyListeners();
  }

  void clearDataUser() {
    _dataUser = null;
    _empresaSelecionada = null;
    _listaCedente = null;
    credenciaisUsuario = UserModel(nomeUsuario: '', senha: '', idDevice: '');
    notifyListeners();
  }
}
