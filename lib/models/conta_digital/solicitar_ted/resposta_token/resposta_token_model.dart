import 'package:json_annotation/json_annotation.dart';

part 'resposta_token_model.g.dart';

@JsonSerializable()
class RespostaTokenModel{
  final String celular;
  final bool tokenEnviado;
  const RespostaTokenModel({required this.celular, required this.tokenEnviado});

  factory RespostaTokenModel.fromJson(Map<String, dynamic> json) => _$RespostaTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$RespostaTokenModelToJson(this);
}