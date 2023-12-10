import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.nomeUsuario,
    required this.senha,
    this.identificadorCedente,
    required this.idDevice,
  });

  late final String nomeUsuario;
  late final String senha;
  String? identificadorCedente;
  late final String idDevice;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
