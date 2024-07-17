
import 'package:json_annotation/json_annotation.dart';
part 'prazo_liquidez_model.g.dart';
@JsonSerializable()
class PrazoLiquidezModel{
  double valorTotalRecebiveisLiquidados;
  double valorTotalRecebiveisLiquidadosNoDia;
  double valorTotalRecebiveisLiquidados7Dias;
  double valorTotalRecebiveisLiquidados15Dias;
  double valorTotalRecebiveisLiquidados30Dias;
  double valorTotalRecebiveisLiquidados45Dias;
  double valorTotalRecebiveisLiquidados60Dias;
  double valorTotalRecebiveisLiquidados90Dias;
  double valorTotalRecebiveisLiquidadosMaisDe90Dias;
  double valorTotalRecebiveisLiquidadosAntesDoVencimento;
  int quantidadeTotalRecebiveisLiquidados;
  int quantidadeTotalRecebiveisLiquidadosNoDia;
  int quantidadeTotalRecebiveisLiquidadosAntesVencimento;
  int quantidadeTotalRecebiveisLiquidados7Dias;
  int quantidadeTotalRecebiveisLiquidados15Dias;
  int quantidadeTotalRecebiveisLiquidados30Dias;
  int quantidadeTotalRecebiveisLiquidados45Dias;
  int quantidadeTotalRecebiveisLiquidados60Dias;
  int quantidadeTotalRecebiveisLiquidados90Dias;
  int quantidadeTotalRecebiveisLiquidadosMaisDe90Dias;

  PrazoLiquidezModel({
    required this.valorTotalRecebiveisLiquidados,
    required this.valorTotalRecebiveisLiquidadosNoDia,
    required this.valorTotalRecebiveisLiquidados7Dias,
    required this.valorTotalRecebiveisLiquidados15Dias,
    required this.valorTotalRecebiveisLiquidados30Dias,
    required this.valorTotalRecebiveisLiquidados45Dias,
    required this.valorTotalRecebiveisLiquidados60Dias,
    required this.valorTotalRecebiveisLiquidados90Dias,
    required this.valorTotalRecebiveisLiquidadosMaisDe90Dias,
    required this.valorTotalRecebiveisLiquidadosAntesDoVencimento,
    required this.quantidadeTotalRecebiveisLiquidados,
    required this.quantidadeTotalRecebiveisLiquidadosNoDia,
    required this.quantidadeTotalRecebiveisLiquidadosAntesVencimento,
    required this.quantidadeTotalRecebiveisLiquidados7Dias,
    required this.quantidadeTotalRecebiveisLiquidados15Dias,
    required this.quantidadeTotalRecebiveisLiquidados30Dias,
    required this.quantidadeTotalRecebiveisLiquidados45Dias,
    required this.quantidadeTotalRecebiveisLiquidados60Dias,
    required this.quantidadeTotalRecebiveisLiquidados90Dias,
    required this.quantidadeTotalRecebiveisLiquidadosMaisDe90Dias,
  });

  factory PrazoLiquidezModel.fromJson(Map<String, dynamic> json) => _$PrazoLiquidezModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrazoLiquidezModelToJson(this);
}