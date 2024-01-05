import 'dart:convert';
import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';

part 'resposta_iniciar_assinatura.g.dart';

@JsonSerializable()
class RespostaIniciarAssinaturaModel {
  @JsonKey(fromJson: _dataFromBase64, toJson: _dataToBase64)
  Uint8List hashParaAssinar;
  String token;

  RespostaIniciarAssinaturaModel({required this.hashParaAssinar, required this.token});

  factory RespostaIniciarAssinaturaModel.fromJson(Map<String, dynamic> json) =>
      _$RespostaIniciarAssinaturaModelFromJson(json);

  Map<String, dynamic> toJson() => _$RespostaIniciarAssinaturaModelToJson(this);

  static Uint8List _dataFromBase64(String base64String) =>
      base64Decode(base64String);

  static String _dataToBase64(Uint8List data) =>
      base64Encode(data);
}
