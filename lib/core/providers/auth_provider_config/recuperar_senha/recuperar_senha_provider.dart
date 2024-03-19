import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/recuperar_senha/recuperar_senha_impl.dart';
import 'package:Srm_Asset/models/recuperar_senha_model/recuperar_senha_model.dart';

class RecuperarSenhaProvider extends ChangeNotifier{

  RecuperarSenhaModel? _dadosUsuario;
  RecuperarSenhaModel? get dadosUsuario => _dadosUsuario;
  set dadosUsuario(RecuperarSenhaModel? dados) {
    _dadosUsuario = dados;
    notifyListeners();
  }
  recuperarSenha() => RecuperarSenhaImpl(dadosUsuario: dadosUsuario!).recuperarSenha();

}