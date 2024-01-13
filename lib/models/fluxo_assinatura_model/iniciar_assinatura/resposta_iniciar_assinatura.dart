import 'dart:convert';
import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';

part 'resposta_iniciar_assinatura.g.dart';

@JsonSerializable()
class RespostaIniciarAssinaturaModel {
  String hashParaAssinar;
  String token;
  String chaveDocumento;

  RespostaIniciarAssinaturaModel(
      {required this.hashParaAssinar,
      required this.token,
      required this.chaveDocumento});

  factory RespostaIniciarAssinaturaModel.fromJson(Map<String, dynamic> json) =>
      _$RespostaIniciarAssinaturaModelFromJson(json);

  Map<String, dynamic> toJson() => _$RespostaIniciarAssinaturaModelToJson(this);
}
