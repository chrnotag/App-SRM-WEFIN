import 'package:flutter/cupertino.dart';
import 'package:modular_study/core/providers/auth_provider_config/recuperar_senha/recuperar_senha_impl.dart';
import 'package:modular_study/models/recuperar_senha_model/recuperar_senha_model.dart';

class RecuperarSenhaProvider extends ChangeNotifier{

  RecuperarSenhaModel? _dadosUsuario;
  RecuperarSenhaModel? get dadosUsuario => _dadosUsuario;
  set dadosUsuario(RecuperarSenhaModel? dados) {
    _dadosUsuario = dados;
    notifyListeners();
  }
  recuperarSenha() => RecuperarSenhaImpl(dadosUsuario: dadosUsuario!).recuperarSenha();

}