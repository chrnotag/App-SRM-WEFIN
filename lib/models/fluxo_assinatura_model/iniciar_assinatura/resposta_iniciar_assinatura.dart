import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'resposta_iniciar_assinatura.g.dart';

@JsonSerializable()
class RespostaIniciarAssinatura {
  Uint8List hashParaAssinar;
  String token;

  RespostaIniciarAssinatura(
      {required this.hashParaAssinar, required this.token});

  factory RespostaIniciarAssinatura.fromJson(Map<String, dynamic> json) =>
      _$RespostaIniciarAssinaturaFromJson(json);

  Map<String, dynamic> toJson() => _$RespostaIniciarAssinaturaToJson(this);
}
