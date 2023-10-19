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

  login(UserModel userModel) => LoginImpl(userModel: userModel).login();

  LoginResponse? _dataUser;
  bool _isLoading = false;
  List<CedenteModel>? _listaCedente;
  CedenteModel? _empresaSelecionada;

  bool get isLoading => _isLoading;

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

  set setEmpresaSelecionada(CedenteModel cedente) {
    _empresaSelecionada = cedente;
    notifyListeners();
  }

  void setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void clearDataUser() {
    _dataUser = null;
    _empresaSelecionada = null;
    _listaCedente = null;
    notifyListeners();
  }
}
