import 'package:json_annotation/json_annotation.dart';
part 'iniciar_assinatura.g.dart';
@JsonSerializable()
class IniciarAssinaturaModel {
  int codigoOperacao;
  String certificado;
  IniciarAssinaturaModel({required this.certificado, required this.codigoOperacao});

  factory IniciarAssinaturaModel.fromJson(Map<String, dynamic> json) => _$IniciarAssinaturaModelFromJson(json);

  Map<String, dynamic> toJson() => _$IniciarAssinaturaModelToJson(this);
}
