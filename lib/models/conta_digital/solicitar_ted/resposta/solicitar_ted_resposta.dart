import 'package:json_annotation/json_annotation.dart';

part 'solicitar_ted_resposta.g.dart';

@JsonSerializable()
class SolicitarTedResposta {
  final DateTime data;
  final String evento;
  final String status;
  final String transacao;

  SolicitarTedResposta({
    required this.data,
    required this.evento,
    required this.status,
    required this.transacao,
  });

  factory SolicitarTedResposta.fromJson(Map<String, dynamic> json) => _$SolicitarTedRespostaFromJson(json);

  Map<String, dynamic> toJson() => _$SolicitarTedRespostaToJson(this);
}
