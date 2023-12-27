import 'package:json_annotation/json_annotation.dart';
part 'finalizar_assinatura.g.dart';
@JsonSerializable()
class FinalizarAssinaturaModel{
  int codigoOperacao;
  String hashAssinado;
  String chaveDocumento;
  String token;

  FinalizarAssinaturaModel({required this.codigoOperacao, required this.hashAssinado, required this.chaveDocumento, required this.token});

  factory FinalizarAssinaturaModel.fromJson(Map<String, dynamic> json) => _$FinalizarAssinaturaFromJson(json);

  Map<String, dynamic> toJson() => _$FinalizarAssinaturaToJson(this);
}