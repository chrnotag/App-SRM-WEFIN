import 'package:json_annotation/json_annotation.dart';
part 'geral_carteira_model.g.dart';

@JsonSerializable()
class GeralCarteiraModel {
  final int valorTotalRecebiveisEmAberto;
  final int valorTotalRecebiveisAVencer;
  final int valorTotalRecebiveisVencidos;
  final int valorTotalRecebiveisLiquidados;
  final int quantidadeTotalRecebiveis;
  final int quantidadeTotalRecebiveisAVencer;
  final int quantidadeTotalRecebiveisVencidos;
  final int quantidadeTotalRecebiveisLiquidados;

  GeralCarteiraModel({
    required this.valorTotalRecebiveisEmAberto,
    required this.valorTotalRecebiveisAVencer,
    required this.valorTotalRecebiveisVencidos,
    required this.valorTotalRecebiveisLiquidados,
    required this.quantidadeTotalRecebiveis,
    required this.quantidadeTotalRecebiveisAVencer,
    required this.quantidadeTotalRecebiveisVencidos,
    required this.quantidadeTotalRecebiveisLiquidados,
  });

  factory GeralCarteiraModel.fromJson(Map<String, dynamic> json) => _$GeralCarteiraModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeralCarteiraModelToJson(this);
}
