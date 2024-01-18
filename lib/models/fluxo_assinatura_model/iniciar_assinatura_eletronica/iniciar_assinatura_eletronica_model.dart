import 'package:json_annotation/json_annotation.dart';

part 'iniciar_assinatura_eletronica_model.g.dart';

@JsonSerializable()
class IniciarAssinaturaEletronicaModel {
  int codigoOperacao;

  IniciarAssinaturaEletronicaModel({required this.codigoOperacao});

  factory IniciarAssinaturaEletronicaModel.fromJson(
          Map<String, dynamic> json) =>
      _$IniciarAssinaturaEletronicaModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$IniciarAssinaturaEletronicaModelToJson(this);
}
