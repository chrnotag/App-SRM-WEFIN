import 'package:json_annotation/json_annotation.dart';

part 'model_operacao.g.dart';

@JsonSerializable()
class OperacaoModel {
  final List<String>? papeis;
  final String? procurador;
  final String? situacao;
  final List<String>? assinantes;
  final List<String>? documentos;
  final String? tipoAssinatura;
  final String? data;

  OperacaoModel(
      {required this.papeis,
      required this.procurador,
      required this.situacao,
      required this.assinantes,
      required this.documentos,
      required this.tipoAssinatura,
      required this.data});

  factory OperacaoModel.fromJson(Map<String, dynamic> json) =>
      _$OperacaoModelFromJson(json);

  Map<String, dynamic> toJson() => _$OperacaoModelToJson(this);
}
