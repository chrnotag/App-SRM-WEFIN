import 'package:json_annotation/json_annotation.dart';

part 'carteira_aberto_model.g.dart';

@JsonSerializable()
class CarteiraAbertoModel {
  final double valorTotalRecebiveisEmAberto;
  final double valorTotalRecebiveisAVencer;
  final double valorTotalRecebiveisVencidos;
  final int quantidadeTotalRecebiveisAVencer;
  final int quantidadeTotalRecebiveisVencidos;

  CarteiraAbertoModel({
    required this.valorTotalRecebiveisEmAberto,
    required this.valorTotalRecebiveisAVencer,
    required this.valorTotalRecebiveisVencidos,
    required this.quantidadeTotalRecebiveisAVencer,
    required this.quantidadeTotalRecebiveisVencidos,
  });

  factory CarteiraAbertoModel.fromJson(Map<String, dynamic> json) =>
      _$CarteiraAbertoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarteiraAbertoModelToJson(this);
}
