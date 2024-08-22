import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.usuario,
    required this.senha,
    required this.tokenNotificacao,
    this.identificadorCedente,
    required this.idDevice,
  });

  late final String usuario;
  late final String senha;
  late final String tokenNotificacao;
  String? identificadorCedente;
  late final String idDevice;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
