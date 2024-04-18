import 'package:json_annotation/json_annotation.dart';

part 'conta_digital.g.dart';

@JsonSerializable()
class ContaDigitalModel {
  String documentoTitular;
  int idConta;
  String agencia;
  String conta;
  String tipoConta;
  CentroCusto centroCusto;

  ContaDigitalModel(
      {required this.documentoTitular,
      required this.idConta,
      required this.agencia,
      required this.conta,
      required this.tipoConta,
      required this.centroCusto});

  factory ContaDigitalModel.fromJson(Map<String, dynamic> json) =>
      _$ContaDigitalModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContaDigitalModelToJson(this);
}

@JsonSerializable()
class CentroCusto {
  String codigo;
  String nome;

  CentroCusto({required this.codigo, required this.nome});

  factory CentroCusto.fromJson(Map<String, dynamic> json) =>
      _$CentroCustoFromJson(json);

  Map<String, dynamic> toJson() => _$CentroCustoToJson(this);
}
