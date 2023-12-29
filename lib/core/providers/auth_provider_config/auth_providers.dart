import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modular_study/core/providers/assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/providers/auth_provider_config/login_implementation.dart';
import 'package:modular_study/models/auth_login_models/cedente_model.dart';
import 'package:modular_study/models/auth_login_models/usuario_logado_model.dart';
import 'package:modular_study/models/user_model.dart';

import '../../../models/exceptions_responses/exception_model.dart';
import '../../constants/route_labels.dart';

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

  CedenteModel buscarEmpresa(String identificadorCedente){
    return dataUser!.listaCedente.firstWhere((cedente) => cedente.identificador == identificadorCedente);
  }

  Future<void> RelogarTrocarCedente(String identificadorCedente, OverlayEntry overlayLoader) async {
    final AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();
    if (empresaSelecionada!.identificador != identificadorCedente) {
      final credenciaisLogin = UserModel(
          usuario: credenciaisUsuario.usuario,
          senha: credenciaisUsuario.senha,
          idDevice: credenciaisUsuario.idDevice,
          identificadorCedente: identificadorCedente);

      final respostaLogin = await login(credenciaisLogin);
      if (respostaLogin != null && respostaLogin.error != null) {
        _erroTrocaCedente(respostaLogin, overlayLoader);
      } else {
        final respostaAssinatura = await assinaturaProvider.pegarAssinaturas();
        if (respostaAssinatura.error != null) {
          _erroTrocaCedente(respostaAssinatura, overlayLoader);
        } else {
          overlayLoader.remove();
          Modular.to.pushNamed(AppRoutes.homeAppRoute);
        }
      }
    } else {
        final respostaAssinatura = await assinaturaProvider.pegarAssinaturas();
      if (respostaAssinatura.error != null) {
        _erroTrocaCedente(respostaAssinatura, overlayLoader);
      } else {
        overlayLoader.remove();
        notifyListeners();
        Modular.to.pushNamed(AppRoutes.homeAppRoute);
      }
    }
  }

  void _erroTrocaCedente(dynamic response, OverlayEntry overlayLoader) {
    final error = response.error as ExceptionModel;
      overlayLoader.remove();
    Fluttertoast.showToast(
        msg: 'Erro: ${error.mensagem}, ${error.erros}, ${error.httpStatus}');
    notifyListeners();
  }

  void clearDataUser() {
    _dataUser = null;
    _empresaSelecionada = null;
    _listaCedente = null;
    credenciaisUsuario = UserModel(usuario: '', senha: '', idDevice: '');
    notifyListeners();
  }
}
