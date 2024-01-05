import 'package:json_annotation/json_annotation.dart';
part 'recuperar_senha_model.g.dart';

@JsonSerializable()
class RecuperarSenhaModel{
  String identificadorCedente;
  String usuario;
  RecuperarSenhaModel({required this.identificadorCedente, required this.usuario});

  factory RecuperarSenhaModel.fromJson(Map<String, dynamic> json) => _$RecuperarSenhaModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecuperarSenhaModelToJson(this);
}