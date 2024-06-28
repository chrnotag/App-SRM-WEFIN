import 'package:json_annotation/json_annotation.dart';

import '../../../core/constants/enuns/RolesAcessoEnum.dart';

import 'cedente_model.dart';

part 'usuario_logado_model.g.dart';

@JsonSerializable()
class LoginResponse {
  LoginResponse(
      {required this.nome,
      required this.usuario,
      required this.identificadorUsuario,
      required this.identificadorCedente,
      required this.token,
      required this.tipoToken,
      required this.dataExpiraSessao,
      required this.idDevice,
      required this.listaCedente,
      required this.roles});

  late final String nome;
  late final String usuario;
  late final String identificadorUsuario;
  late final String identificadorCedente;
  late final String token;
  late final String tipoToken;
  late final DateTime dataExpiraSessao;
  late final String idDevice;
  late final List<CedenteModel> listaCedente;
  late final List<RolesAcessoEnum> roles;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
