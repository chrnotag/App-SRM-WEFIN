import 'package:flutter_mobile_project/app/models/usuario_logado/cedente_model.dart';

class UsuarioLogadoModel {
  final String? nome;
  final String? usuario;
  final String? identificadorUsuario;
  final String? token;
  final String? tipoToken;
  final DateTime? dataExpiraSessao;
  final String? imei;
  final List<CedenteModel>? listaCedente;

  UsuarioLogadoModel(
      this.nome,
      this.usuario,
      this.identificadorUsuario,
      this.token,
      this.tipoToken,
      this.dataExpiraSessao,
      this.imei,
      this.listaCedente);
}
